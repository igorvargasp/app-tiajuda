

import 'dart:convert';

import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/Categoria.dart';
import 'package:frontend/model/Usuario.dart';
import 'package:frontend/screen/api/http_service.dart';
import 'package:frontend/screen/client/dashboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Solicitation extends StatefulWidget {
  late String json;
  Solicitation({required String json}){
    this.json = json;
  }

  @override
  _SolicitationState createState() => _SolicitationState();

}

class _SolicitationState extends State<Solicitation> {
  final _titulo = TextEditingController();
  final _mensagem = TextEditingController();
  String _categoria = "teste";
  late String categoria2;
  List data = [];

  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _nome = TextEditingController();
  final _id = TextEditingController();

  _EditarCategoriaState(){
    HttpService.searchCategoria().then((response){
      setState(() {
        var list = jsonDecode(response.body);
        data = list;
      });
    });
  }

  initState(){
    super.initState();
    _EditarCategoriaState();
    //var timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _EditarCategoriaState());
  }

  dispose(){
    super.dispose();
  }


  Widget build(BuildContext context) {

    if(widget.json.isNotEmpty){
      Map<String, dynamic> map = jsonDecode(widget.json);
      Usuario obj = Usuario.fromJson(map);


      this._nome.text = obj.nome;
      this._senha.text = obj.senha;
      this._email.text = obj.email;
      this._id.text = obj.id.toString();


    }

    return Scaffold(
      appBar: AppBar(
       title: Text("ENVIAR MENSAGEM"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(32, 99, 155, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              Container(

                alignment: Alignment.topLeft,

                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    children: [
                      Text("TÍTULO", style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.normal, color: Color.fromRGBO(32, 99, 155, 1),

                      ),),
                    ],
                  ),

                ),

              ),

              Container(

                width: 305,
                child: TextFormField(

                  controller:_titulo,
                  //obscureText: true,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: Colors.black

                  ),
                  decoration: InputDecoration(
                        hintText: "Digite o titulo do seu problema",
                      border: UnderlineInputBorder(
                          borderSide: new BorderSide(
                              color: Color.fromRGBO(32, 99, 155, 1)
                          )
                      )
                  ),
                ),

              ),

              SizedBox(
                height: 10,
              ),
              Container(

                alignment: Alignment.topLeft,

                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    children: [
                      Text("CATEGORIA", style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.normal, color: Color.fromRGBO(32, 99, 155, 1),

                      ),),
                    ],
                  ),

                ),

              ),

              Container(
                width: 305,
                child: DropdownButtonFormField(
                  hint: Text("Selecione uma categoria"),
                  items: data.map((item){
                    return DropdownMenuItem(
                      value: item['nome'].toString(),
                      child: Text(item['nome'].toString()),
                      onTap: (){
                        categoria2 = item['id_Categoria'].toString();
                        print(categoria2);
                      },
                    );
                  }).toList(),
                  onChanged: (val){
                    setState(() {
                      _categoria = val.toString();
                      print(_categoria);
                    });
                  },
                )

              ),
              SizedBox(
                height: 10,
              ),
              Container(

                alignment: Alignment.topLeft,

                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    children: [
                      Text("MENSAGEM", style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.normal, color: Color.fromRGBO(32, 99, 155, 1),

                      ),),
                    ],
                  ),

                ),

              ),
              Container(

                width: 305,
                child: TextFormField(
                  maxLength: 200,
                  maxLines: 7,
                  controller:_mensagem,
                  //obscureText: true,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: Colors.black

                  ),
                  decoration: InputDecoration(
                      hintText: "Digite a sua mensagem",
                      border: UnderlineInputBorder(
                          borderSide: new BorderSide(
                              color: Color.fromRGBO(32, 99, 155, 1)
                          )
                      )
                  ),
                ),

              ),
              SizedBox(
                height: 10,
              ),
              Container(

                child: ElevatedButton(
                  style: sendButton,
                  onPressed: () async{
                    int id_categoria = int.parse(categoria2);
                    var usuario = int.parse(_id.text);
                    var response = await HttpService().RegisterSolicitacao(_mensagem.text, "pendente", _titulo.text, usuario,id_categoria);
                    if(response.id_solicitacao != null){
                      final sucess = SnackBar(
                        content: Text("Solicitação enviada com sucesso!"),
                        backgroundColor: Colors.green,

                      );
                      ScaffoldMessenger.of(context).showSnackBar(sucess);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DashBoard())
                      );
                    }else{
                      final failed = SnackBar(
                        content: Text("Algo deu errado!"),
                        backgroundColor: Colors.red,

                      );
                      ScaffoldMessenger.of(context).showSnackBar(failed);
                    }
                    }, child: Text("ENVIAR MENSAGEM",),
                ),
              ),
            ],
          ),
        ),

      ),
    );

  }




}

final ButtonStyle sendButton = TextButton.styleFrom(

    minimumSize: Size(274, 53),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    backgroundColor: Color.fromRGBO(32, 99, 155, 1),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),

    ),
    textStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.bold,
      fontSize: 14,

    )
);
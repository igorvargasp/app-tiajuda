

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/Categoria.dart';
import 'package:frontend/model/Solicitacao.dart';
import 'package:frontend/model/Usuario.dart';
import 'package:frontend/screen/api/http_service.dart';
import 'package:frontend/screen/client/dashboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboardfuncionario.dart';

class Resposta extends StatefulWidget {
  late String json;
  Resposta({required String json}){
    this.json = json;
  }

  @override
  _RespostaState createState() => _RespostaState();

}

class _RespostaState extends State<Resposta> {

  Solicitacao solicitacao = new Solicitacao(titulo: "",status: "", mensagem: "", usuario: 0, categoria: 0, id_solicitacao: 0);
  Categoria categoria = new Categoria(id: 0, nome: "");
  final _resposta = TextEditingController();

  _listaCategoria(){
    Map<String, dynamic> map = jsonDecode(widget.json);
    Solicitacao obj = Solicitacao.fromJson(map);
    HttpService.searchOneCategoria(obj.categoria).then((response){
      setState(() {
        Map<String, dynamic> map = jsonDecode(response.body);
        categoria = Categoria.fromJson(map);
      });
    });
  }

  initState(){
    super.initState();
    _listaCategoria();
  }


  Widget build(BuildContext context){
    if(widget.json.isNotEmpty) {
      Map<String, dynamic> map = jsonDecode(widget.json);
      Solicitacao obj = Solicitacao.fromJson(map);

      solicitacao.id_solicitacao = obj.id_solicitacao;
      solicitacao.titulo = obj.titulo;
      solicitacao.mensagem = obj.mensagem;
      solicitacao.status = obj.status;
      solicitacao.categoria = obj.categoria;
      solicitacao.usuario = obj.usuario;

    }


    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("MENSAGEM",),
          backgroundColor: Color.fromRGBO(32, 99, 155, 1),
        ),

        body:SingleChildScrollView(
          child: Container(
            child: Column(

              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal:20),
                  child:Row(
                    children: [
                      Text("TÍTULO: ",style: TextStyle(

                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(32, 99, 155, 1),
                          fontSize: 18
                      ),),
                      Text(solicitacao.titulo,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(32, 99, 155, 1),
                          fontSize: 15
                      ),),
                    ],
                  ),
                ),

                Divider(
                  thickness: 3,
                  indent: 20,
                  endIndent: 20,
                  color:Color.fromRGBO(32, 99, 155, 1) ,

                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal:20),
                  child:Row(
                    children: [
                      Text("CATEGORIA: ", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(32, 99, 155, 1),
                          fontSize: 18
                      ),),
                      Text(categoria.nome, style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(32, 99, 155, 1),
                      ),),
                    ],
                  ),
                ),
                Divider(
                  thickness: 3,
                  indent: 20,
                  endIndent: 20,
                  color:Color.fromRGBO(32, 99, 155, 1),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal:20),
                  child:Row(
                    children: [
                      Text("MENSAGEM ",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(32, 99, 155, 1),
                          fontSize: 18
                      ),),

                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal:20, vertical: 2),
                  child:Row(
                    children: [
                      Text(solicitacao.mensagem,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(32, 99, 155, 1),
                          fontSize: 15
                      ),),
                    ],
                  ),
                ),

                Divider(
                  height: 100,
                  thickness: 3,
                  indent: 20,
                  endIndent: 20,
                  color:Color.fromRGBO(32, 99, 155, 1),
                ),

                Container(

                  alignment: Alignment.topLeft,

                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Column(
                      children: [
                        Text("RESPOSTA", style: GoogleFonts.roboto(
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
                    maxLines: 5,
                    controller:_resposta,
                    //obscureText: true,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Colors.black

                    ),
                    decoration: InputDecoration(
                        hintText: "Digite a sua reposta",
                        border: UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Color.fromRGBO(32, 99, 155, 1)
                            )
                        )
                    ),
                  ),

                ),

                SizedBox(
                  height: 60,
                ),

                Container(
                  child: ElevatedButton(
                    style: sendButton,
                    onPressed: () async{
                      var prefs = await SharedPreferences.getInstance();
                      var json = prefs.getString("usuario");
                      Map<String, dynamic> map = jsonDecode(json);
                      Usuario obj = Usuario.fromJson(map);

                      var resposta = await HttpService().RegisterResposta(_resposta.text, "Resolvido", solicitacao.titulo, obj.id, solicitacao.id_solicitacao);
                      if(resposta.id_resposta!= null){
                        var update = await HttpService().updateSolicitacao(solicitacao.mensagem, "Resolvido", solicitacao.titulo, solicitacao.usuario, solicitacao.categoria, solicitacao.id_solicitacao);
                        final sucess= SnackBar(
                          content: Text("Solicitação Respondida com sucesso!"),
                          backgroundColor: Colors.green,

                        );

                        ScaffoldMessenger.of(context).showSnackBar(sucess);

                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DashBoardFunc())
                        );
                      }

                    }, child: Text("RESPONDER MENSAGEM",),
                  ),
                ),

              ],
            ),
          ),
        )
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
      fontSize: 16,

    )
);
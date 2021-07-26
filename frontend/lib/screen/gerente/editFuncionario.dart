import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/model/Categoria.dart';
import 'package:frontend/model/Usuario.dart';
import 'package:frontend/screen/api/http_service.dart';
import 'package:frontend/screen/gerente/editFuncionario.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditarFuncionario extends StatefulWidget{
  EditarFuncionario({Key? key}) : super(key: key);

  @override
  _EditarFuncionarioState createState() => _EditarFuncionarioState();

}


class _EditarFuncionarioState extends State<EditarFuncionario>{
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _nome = TextEditingController();
  final _permissao = TextEditingController();
  var usuario = <Usuario>[];

  _EditarFuncionarioState(){
    HttpService.searchFuncionarios().then((response){
      setState(() {
        Iterable list = jsonDecode(response.body);
        usuario = list.map((model) => Usuario.fromJson(model)).toList();
      });
    });
  }

  initState(){
    super.initState();
    _EditarFuncionarioState();
    //var timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _EditarCategoriaState());
  }

  dispose(){
    super.dispose();
  }




  Widget build(BuildContext) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(32, 99, 155, 1),
          title: Text("EDITAR FUNCIONARIO"),
          centerTitle: true,
        ),




        body: SingleChildScrollView(

          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                alignment: Alignment.centerLeft,
                child: Text("EDITAR FUNCIONARIOS",style: TextStyle(
                  color: Color.fromRGBO(32, 99, 155, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,

                ),),
              ),
              Divider(
                thickness: 2,
                color: Color.fromRGBO(32, 99, 155, 1),
                indent: 50,
                endIndent: 50,
              ),

              Container(
                height: 150.0,

                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: usuario.length,
                    itemBuilder: ( context, int index) {
                      return Column(
                        children: [
                          Row(
                            children: [

                              Container(
                                child: Container(
                                    child: Text(usuario[index].nome,
                                      style:TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(32, 99, 155, 1)
                                      ),
                                    )),
                              ),
                              Container(

                                  child: Row(

                                    children: [
                                      IconButton(

                                        icon: Icon(
                                          Icons.edit_outlined,
                                          color: Color.fromRGBO(32, 99, 155, 1),
                                        ),
                                        onPressed: () async{
                                          var prefs = await SharedPreferences.getInstance();
                                          prefs.clear();
                                          _nome.text = usuario[index].nome;
                                          _email.text = usuario[index].email;
                                          _senha.text = usuario[index].senha;
                                          _permissao.text = usuario[index].tipoUsuario;

                                          prefs.setInt("id",usuario[index].id);
                                       
                                        },
                                      ),
                                      IconButton(

                                        icon: Icon(
                                          Icons.delete_outlined,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async{
                                          var prefs = await SharedPreferences.getInstance();
                                          prefs.setInt("id",usuario[index].id);
                                          var id = prefs.getInt("id");
                                          var response = await HttpService().deleteFuncionario(id);
                                          prefs.clear();
                                          final sucess = SnackBar(
                                            content: Text("Funcionario deletado com sucesso!"),
                                            backgroundColor: Colors.green,
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(sucess);
                                          Navigator.pop(context);

                                        },
                                      ),
                                    ],
                                  )

                              ),

                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          ),

                        ],
                      );
                    }

                ),

              ),

              Column(

                children: [
                  Column(

                    children: [
                      Container(

                        alignment: Alignment.topLeft,

                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 50.0),
                          child: Column(
                            children: [
                              Text("NOME", style: GoogleFonts.roboto(
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

                          controller:_nome,
                          //obscureText: true,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: Colors.black

                          ),

                          decoration: InputDecoration(

                              border: UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Color.fromRGBO(32, 99, 155, 1)
                                  )
                              )
                          ),
                        ),

                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(

                        alignment: Alignment.topLeft,

                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 50.0),
                          child: Column(
                            children: [
                              Text("EMAIL", style: GoogleFonts.roboto(
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

                          controller:_email,
                          //obscureText: true,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: Colors.black

                          ),

                          decoration: InputDecoration(

                              border: UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Color.fromRGBO(32, 99, 155, 1)
                                  )
                              )
                          ),
                        ),

                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(

                        alignment: Alignment.topLeft,

                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 50.0),
                          child: Column(
                            children: [
                              Text("SENHA", style: GoogleFonts.roboto(
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

                          controller:_senha,
                          //obscureText: true,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: Colors.black

                          ),

                          decoration: InputDecoration(

                              border: UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Color.fromRGBO(32, 99, 155, 1)
                                  )
                              )
                          ),
                        ),

                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(

                        alignment: Alignment.topLeft,

                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 50.0),
                          child: Column(
                            children: [
                              Text("FUNCIONARIO", style: GoogleFonts.roboto(
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

                          controller:_permissao,
                          //obscureText: true,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: Colors.black

                          ),

                          decoration: InputDecoration(

                              border: UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Color.fromRGBO(32, 99, 155, 1)
                                  )
                              )
                          ),
                        ),

                      ),

                      SizedBox(
                        height: 15,
                      ),
                      Container(

                        child: ElevatedButton(
                          style: registerButton,
                          onPressed: () async{
                            var prefs = await SharedPreferences.getInstance();
                            var id = prefs.getInt("id");
                            if(id == null){
                              return null;
                            }else{
                              var response = await HttpService().updateFuncionario(_nome.text, _email.text, _senha.text, id, _permissao.text);
                              print(response);
                              setState(() {
                              });
                              final sucess = SnackBar(
                                content: Text("Funcionario Editado com sucesso!"),
                                backgroundColor: Colors.green,

                              );
                              ScaffoldMessenger.of(context).showSnackBar(sucess);
                              Navigator.pop(context);
                            }


                          }, child: Text("CONFIRMAR",),

                        ),
                      ),

                    ],
                  ),
                ],
              ),

            ],
          ),
        )



    );

  }

}




final ButtonStyle registerButton = TextButton.styleFrom(
    primary: Colors.white,
    minimumSize: Size(166, 53),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    backgroundColor:  Color.fromRGBO(32, 99, 155, 1),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),

    ),
    textStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.bold,
      fontSize: 20,

    )

);
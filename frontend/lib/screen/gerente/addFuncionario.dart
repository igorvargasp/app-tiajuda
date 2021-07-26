




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screen/api/http_service.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dashboardGerente.dart';

class AdicionarFuncionario extends StatefulWidget{
  AdicionarFuncionario({Key? key}) : super(key: key);

  @override
  _AdicionarFuncionarioState createState() => _AdicionarFuncionarioState();

}

class _AdicionarFuncionarioState extends State<AdicionarFuncionario>{
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _nome = TextEditingController();
  final _permissao = TextEditingController();

  Widget build(BuildContext contex){

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: new Column(
              children: [
                Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(
                        height: 150,

                      ),
                      new Text("ADICIONAR FUNCIONARIO",style: GoogleFonts.roboto(
                          fontWeight: FontWeight.normal,
                          fontSize: 25,
                          color: Color.fromRGBO(32, 99, 155, 1)
                      ),),

                    ],
                  ),
                ),
                Column(

                  children: [
                    Align(
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
                        autofocus: true,


                        controller:_nome,


                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black

                        ),
                        validator: (String? value){
                          if(value == null || value.isEmpty){
                            return 'O campo nome está vazio';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Digite um nome',
                        ),

                      ),
                    ),



                  ],
                ),

                SizedBox(
                  height: 30,
                ),
                Column(

                  children: [
                    Align(
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
                        controller: _email,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black

                        ),
                        validator: (String? value){
                          if(value == null || value.isEmpty){
                            return 'O campo email está vazio';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Digite um email',
                            border: UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Color.fromRGBO(32, 99, 155, 1)
                                )
                            )
                        ),
                      ),

                    ),

                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Align(
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
                        controller: _senha,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black

                        ),
                        validator: (String? value){
                          if(value == null || value.isEmpty){
                            return 'O campo senha está vazio';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Digite uma senha',
                            border: UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Color.fromRGBO(32, 99, 155, 1)
                                )
                            )
                        ),
                      ),

                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.topLeft,

                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 50.0),
                        child: Column(
                          children: [
                            Text("PERMISSÃO", style: GoogleFonts.roboto(
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
                        controller: _permissao,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black

                        ),
                        validator: (String? value){
                          if(value == null || value.isEmpty){
                            return 'O campo permissão está vazio';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Digite uma permissao EX: (Funcionario/Gerente)',
                            border: UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Color.fromRGBO(32, 99, 155, 1)
                                )
                            )
                        ),
                      ),

                    ),



                  ],
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 25),
                  child: ElevatedButton(
                    style: registerButton,
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        var response = await HttpService().RegisterFuncionario(_nome.text, _email.text, _senha.text, _permissao.text);
                        final sucess = SnackBar(
                          content: Text("Funcionario Criado com sucesso!"),
                          backgroundColor: Colors.green,

                        );
                        ScaffoldMessenger.of(context).showSnackBar(sucess);
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DashBoardGerente())
                        );
                      }


                    }, child: Text("CONFIRMAR",),
                  ),
                ),

                Container(
                  child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Color.fromRGBO(32, 99, 155, 1),
                      onPressed: () {
                        Navigator.pop(context);
                      }
                  ),

                ),


              ]

          ),

        ),

      ),

    );

  }

}



final ButtonStyle registerButton = TextButton.styleFrom(

    minimumSize: Size(166, 53),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    backgroundColor: Color.fromRGBO(32, 99, 155, 1),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),

    ),
    textStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.bold,
      fontSize: 20,

    )
);

final ButtonStyle backButton = TextButton.styleFrom(
    primary: Color.fromRGBO(32, 99, 155, 1),
    minimumSize: Size(166, 53),
    padding: EdgeInsets.symmetric(horizontal: 16.0),


    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        side: BorderSide(
          color: Color.fromRGBO(32, 99, 155, 1),
        )
    ),
    textStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    )

);
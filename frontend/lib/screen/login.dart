import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:frontend/model/Usuario.dart';
import 'package:frontend/screen/client/dashboard.dart';
import 'package:frontend/screen/api/http_service.dart';
import 'package:frontend/screen/funcionario/dashboardfuncionario.dart';
import 'package:frontend/screen/gerente/dashboardGerente.dart';
import 'package:frontend/screen/register.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: import_of_legacy_library_into_null_safe

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();


}

class _LoginState extends State<Login> {
  late Future<Usuario> user;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _senha = TextEditingController();


  Widget build(BuildContext context) {

    saveData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Usuario user = Usuario(id: 0,nome: "", email: _email.text, senha: _senha.text, tipoUsuario: "");
    }

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
                    height: 300,

                  ),
               new Text("TI",style: GoogleFonts.roboto(
                   fontWeight: FontWeight.normal,
                   fontSize: 80,
                   color: Color.fromRGBO(32, 99, 155, 1)
               ),),
                   new Text("HELP",style: GoogleFonts.roboto(
                       fontWeight: FontWeight.normal,
                       fontSize: 40,
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
                        autofocus: true,



                        controller:_email,

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
                          hintText: 'Digite seu email',
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

                        controller:_senha,
                        obscureText: true,
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
                          hintText: 'Digite sua senha',
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
                   margin: EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      style: loginButton,
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){

                          var response = await HttpService().postLogin(_email.text,_senha.text);
                         
                          

                          if(response.senha == "" && response.email == ""){
                            final error= SnackBar(
                              content: Text("Senha ou email incorreto"),
                              backgroundColor: Colors.red,

                            );

                            ScaffoldMessenger.of(context).showSnackBar(error);
                          }else{
                            if(response.tipoUsuario == "cliente"){
                              
                              final sucess = SnackBar(
                                content: Text("Usuario Logado com sucesso!"),
                                backgroundColor: Colors.green,

                              );
                              ScaffoldMessenger.of(context).showSnackBar(sucess);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DashBoard())
                              );
                            }else if(response.tipoUsuario == "Gerente"){
                              final sucess = SnackBar(
                                content: Text("Usuario Logado com sucesso!"),
                                backgroundColor: Colors.green,

                              );
                              ScaffoldMessenger.of(context).showSnackBar(sucess);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DashBoardGerente())
                              );
                            }else if(response.tipoUsuario == "Funcionario"){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DashBoardFunc())
                              );
                            }


                          }

                        }

                      }, child: Text("ENTRAR",),
                    ),
                  ),
               SizedBox(
                 height: 50,
               ),
               Container(

                  child: ElevatedButton(
                    style: registerButton,
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register())
                      );
                    }, child: Text("REGISTRAR",),

                  ),
                ),


              ]

          ),

        ),

       ),

    );

  }
}

final ButtonStyle loginButton = TextButton.styleFrom(
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

final ButtonStyle registerButton = TextButton.styleFrom(
    primary: Color.fromRGBO(32, 99, 155, 1),
    minimumSize: Size(166, 53),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    backgroundColor: Colors.white,

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
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/model/Usuario.dart';
import 'package:frontend/screen/api/http_service.dart';
import 'package:frontend/screen/login.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  late String json;
  EditProfile({required String json}){
    this.json = json;
  }
  @override
  _EditProfileState createState() => _EditProfileState();

}


final _formKey = GlobalKey<FormState>();
class _EditProfileState extends State<EditProfile>  {
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _nome = TextEditingController();
  final _id = TextEditingController();


  @override
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
        backgroundColor: Color.fromRGBO(32, 99, 155, 1),
        title: Text("EDITAR PERFIL"),
        centerTitle: true,

      ),

      body: SingleChildScrollView(

        child: Form(

          key: _formKey,
          child: new Column(



              children: [


                      SizedBox(
                        height: 50,

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

                        controller: _nome,


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
                          hintText: 'Digite seu nome',
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
                            hintText: 'Digite seu email',
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

                SizedBox(
                  height: 50,
                ),
                Container(

                  child: ElevatedButton(
                    style: confirmButton,
                    onPressed: ()async {

                      int id_user = int.parse(_id.text);
                      var response = await HttpService().updateClient(_nome.text,_email.text,_senha.text,id_user);

                      if(response.senha == "" && response.email == ""){
                        final error= SnackBar(
                          content: Text("Algo deu errado"),
                          backgroundColor: Colors.red,

                        );

                        ScaffoldMessenger.of(context).showSnackBar(error);
                      }else{

                        var prefs = await SharedPreferences.getInstance();
                        prefs.clear();
                        await HttpService().searchClient(id_user);

                        final sucess = SnackBar(
                          content: Text("Usuario editado com sucesso!"),
                          backgroundColor: Colors.green,

                        );
                        ScaffoldMessenger.of(context).showSnackBar(sucess);
                        Navigator.pop(context);
                      }

                    }, child: Text("CONFIRMAR",),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(

                  child: ElevatedButton(
                    style: deleteButton,
                    onPressed: () async{
                      int id_user = int.parse(_id.text);
                      var response = await HttpService().deleteClient(id_user);
                      if(response.toString().isNotEmpty){

                        final sucess = SnackBar(
                          content: Text("Usuario deletado com sucesso!"),
                          backgroundColor: Colors.indigo,

                        );
                        ScaffoldMessenger.of(context).showSnackBar(sucess);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                            (Route<dynamic> route) => false,
                        );
                      }
                    }, child: Text("DELETAR PERFIL",),
                  ),
                ),


              ]

          ),

        ),

      ),

    );

  }
}

final ButtonStyle confirmButton = TextButton.styleFrom(

    minimumSize: Size(233, 53),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    backgroundColor: Colors.green,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),

    ),
    textStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.bold,
      fontSize: 20,

    )
);

final ButtonStyle deleteButton = TextButton.styleFrom(

    minimumSize: Size(233, 53),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    backgroundColor: Colors.red,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),

    ),
    textStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.bold,
      fontSize: 20,

    )
);

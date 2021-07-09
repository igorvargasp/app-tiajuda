import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfile createState() => _EditProfileState();

}


final _formKey = GlobalKey<FormState>();
class _EditProfile extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
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
                        height: 200,

                      ),
                      new Text("CRIAR CONTA",style: GoogleFonts.roboto(
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


                        /*controller: TextEditingController(
                          text: usuario.nome,

                        ),
                        onChanged: (val){
                          usuario.nome = val;
                        },*/
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
                        /*controller: TextEditingController(
                          text: usuario.email,
                        ),
                        onChanged: (val){
                          usuario.email = val;
                        },*/
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
                        /*controller: TextEditingController(
                          text: usuario.senha,
                        ),
                        onChanged: (val){
                          usuario.senha = val;
                        },*/
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
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: ElevatedButton(
                    style: registerButton,
                    onPressed: (){


                    }, child: Text("CONFIRMAR",),
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


final ButtonStyle confirmButton = TextButton.styleFrom(

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
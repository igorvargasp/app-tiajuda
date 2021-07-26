
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:frontend/screen/client/editprofile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();

}


class _DashBoardState extends State<DashBoard> {

  Widget build(BuildContext context){

    clearData() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      print("usuario deslogou!");
    }


    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
           children: [

             Container(
               constraints: BoxConstraints(minWidth: 100, maxWidth: 411),
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
                     color: Colors.blue

                 ),
                 validator: (String? value){
                   if(value == null || value.isEmpty){
                     return 'O campo nome está vazio';
                   }
                   return null;
                 },

                 decoration: InputDecoration(
                  prefixIcon:Icon(
                     Icons.search_outlined
                   ),
                   hintText: 'Pesquise por titulo, categoria ou status',
                  border: OutlineInputBorder(

                  )

                 ),

               ),
             ),
             Container(
               constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
               margin: EdgeInsets.symmetric(vertical: 20),
               height: 300,
               alignment: Alignment.center,
               color: Colors.blue,
               child: Text("Aqui vai so dados da solicitacao"),
             ),
             SizedBox(
               height: 80,
             ),

             Container(

               child: ElevatedButton(
                 style: sendButton,
                 onPressed: (){

                 }, child: Text("ENVIAR UM NOVO PROBLEMA",),
               ),
             ),
             SizedBox(
               height: 10,
             ),
             Container(
               child: ElevatedButton(
                 style: editButton,
                 onPressed: () async{

                   var prefs = await SharedPreferences.getInstance();
                   String usuario = (prefs.getString("usuario"));
                   print("login: $usuario");
                   Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => EditProfile(json:usuario))
                   );

                 }, child: Text("EDITAR PERFIL"),
               ),
             ),
             SizedBox(
               height: 10,
             ),
             Container(
               child: ElevatedButton(
                 style: logoutButton,
                 onPressed: (){
                   clearData();
                   Navigator.pop(context);
                 }, child: Text("SAIR"),
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

final ButtonStyle editButton = TextButton.styleFrom(

    minimumSize: Size(274, 53),
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    backgroundColor: Color.fromRGBO(32, 99, 155, 1),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),

    ),
    textStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.bold,
      fontSize: 14,

    )
);

final ButtonStyle logoutButton = TextButton.styleFrom(

    primary: Color.fromRGBO(32, 99, 155, 1),
    minimumSize: Size(274, 53),
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
      fontSize: 14,
    )
);
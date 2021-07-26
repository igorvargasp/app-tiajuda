

import 'package:flutter/material.dart';
import 'package:frontend/screen/gerente/addCategory.dart';
import 'package:frontend/screen/gerente/addFuncionario.dart';
import 'package:frontend/screen/gerente/editCategory.dart';
import 'package:frontend/screen/gerente/editFuncionario.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardGerente extends StatefulWidget{
  DashBoardGerente({Key? key}) : super(key: key);

  @override
  _DashBoardGerenteState createState() => _DashBoardGerenteState();

}

class _DashBoardGerenteState extends State<DashBoardGerente>{



    Widget build(BuildContext context){
    return Scaffold (
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(32, 99, 155, 1),
        title: Text("PAINEL GERENTE/ADMIN"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        child: Column(
          children: [

            SizedBox(
              height: 100,
            ),
            Container(

              alignment: Alignment.center,

              child: ElevatedButton(
                style: confirmButton,
                onPressed: ()async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdicionarFuncionario())
                  );
                }, child: Text("ADICIONAR FUNCIONÁRIO",),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(

              alignment: Alignment.center,

              child: ElevatedButton(
                style: confirmButton,
                onPressed: ()async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditarFuncionario())
                  );
                }, child: Text("EDITAR FUNCIONÁRIO",),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(

              alignment: Alignment.center,

              child: ElevatedButton(
                style: confirmButton,
                onPressed: ()async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdicionarCategoria())
                  );
                }, child: Text("ADICIONAR CATEGORIA",),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(

              alignment: Alignment.center,

              child: ElevatedButton(
                style: confirmButton,
                onPressed: ()async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditarCategoria())
                  );
                }, child: Text("EDITAR CATEGORIA",),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Container(

              alignment: Alignment.center,

              child: ElevatedButton(
                style: logoutButton,
                onPressed: ()async {
                var prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pop(context);

                }, child: Text("SAIR",),
              ),
            ),
          ],
        ),
      ),

    );
  }



}


final ButtonStyle confirmButton = TextButton.styleFrom(

    minimumSize: Size(274, 53),
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
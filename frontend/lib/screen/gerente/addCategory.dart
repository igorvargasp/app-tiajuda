


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screen/api/http_service.dart';
import 'package:frontend/screen/gerente/dashboardGerente.dart';
import 'package:google_fonts/google_fonts.dart';

class AdicionarCategoria extends StatefulWidget{
  AdicionarCategoria({Key? key}) : super(key: key);

  @override
  _AdicionarCategoriaState createState() => _AdicionarCategoriaState();

}

class _AdicionarCategoriaState extends State<AdicionarCategoria>{
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  Widget build (BuildContext contex){

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(32, 99, 155, 1),
        title: Text("ADICIONAR CATEGORIA"),
        centerTitle: true,
      ),
    body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Align(
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
              key: _formKey,
              width: 305,
              child: TextFormField(
                controller: _nome,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,

                ),
                validator: (String? value){
                  if(value == null || value.isEmpty){
                    return 'O campo email está vazio';
                  }
                  return null;
                },
                  decoration: InputDecoration(
                      hintText: 'Digite uma nova categoria',
                      border: UnderlineInputBorder(
                          borderSide: new BorderSide(
                              color: Color.fromRGBO(32, 99, 155, 1)
                          )
                      )
                  )
              ),

            ),
            SizedBox(
              height: 30,
            ),
            Container(

              alignment: Alignment.center,

              child: ElevatedButton(
                style: confirmButton,
                onPressed: ()async {

                  var response = await HttpService().RegisterCategory(_nome.text);
                  if(response.nome != ""){
                    print("categoria adicionada com sucesso");
                  }
                  final sucess = SnackBar(
                    content: Text("Categoria criada com sucesso!"),
                    backgroundColor: Colors.green,

                  );
                  ScaffoldMessenger.of(context).showSnackBar(sucess);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashBoardGerente())
                  );

                }, child: Text("CONFIRMAR",),
              ),
            ),
          ],
        ),
      ),
    ),

    );

  }

}

final ButtonStyle confirmButton = TextButton.styleFrom(

    minimumSize: Size(274, 53),
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

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/model/Categoria.dart';
import 'package:frontend/screen/api/http_service.dart';
import 'package:frontend/screen/gerente/editFuncionario.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditarCategoria extends StatefulWidget{
  EditarCategoria({Key? key}) : super(key: key);

  @override
  _EditarCategoriaState createState() => _EditarCategoriaState();

}


class _EditarCategoriaState extends State<EditarCategoria>{
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  var categoria = <Categoria>[];

  _EditarCategoriaState(){
    HttpService.searchCategoria().then((response){
      setState(() {
        Iterable list = jsonDecode(response.body);
        categoria = list.map((model) => Categoria.fromJson(model)).toList();
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




  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(32, 99, 155, 1),
        title: Text("EDITAR CATEGORIA"),
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
              child: Text("EDITAR CATEGORIA",style: TextStyle(
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
                height: 200.0,

                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                    itemCount: categoria.length,
                    itemBuilder: ( context, int index) {
                      return Column(
                        children: [
                          Row(
                            children: [

                              Container(
                                child: Container(
                                    child: Text(categoria[index].nome,
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
                                        _nome.text = categoria[index].nome;
                                        prefs.setInt("id",categoria[index].id);
                                      },
                                    ),
                                    IconButton(

                                      icon: Icon(
                                        Icons.delete_outlined,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async{
                                        var prefs = await SharedPreferences.getInstance();
                                        prefs.setInt("id",categoria[index].id);
                                        var id = prefs.getInt("id");
                                        var response = await HttpService().deleteCategory(id);
                                        prefs.clear();
                                        final sucess = SnackBar(
                                          content: Text("Categoria deletada com sucesso!"),
                                          backgroundColor: Colors.red,
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
            SizedBox(
              height: 50,
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
                      height: 50,
                    ),
                    Container(

                      child: ElevatedButton(
                        style: registerButton,
                        onPressed: () async{
                          var prefs = await SharedPreferences.getInstance();
                          var id = prefs.getInt("id");
                          var response = await HttpService().updateCategory(_nome.text, id);
                          print(response);
                          setState(() {
                          });
                          final sucess = SnackBar(
                            content: Text("Categoria editada com sucesso!"),
                            backgroundColor: Colors.green,

                          );
                          ScaffoldMessenger.of(context).showSnackBar(sucess);
                          Navigator.pop(context);
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
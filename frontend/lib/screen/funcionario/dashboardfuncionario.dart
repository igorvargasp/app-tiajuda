
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/model/Categoria.dart';
import 'package:frontend/model/Solicitacao.dart';
import 'package:frontend/screen/api/http_service.dart';
import 'package:frontend/screen/client/editprofile.dart';
import 'package:frontend/screen/client/sentSolicitation.dart';
import 'package:frontend/screen/client/solicitationSelect.dart';
import 'package:frontend/screen/funcionario/replysolicitation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DashBoardFunc extends StatefulWidget {
  DashBoardFunc({Key? key}) : super(key: key);

  @override
  _DashBoardFuncState createState() => _DashBoardFuncState();

}


class _DashBoardFuncState extends State<DashBoardFunc> {
  final _nome = TextEditingController();
  List<Solicitacao> solicitacao = <Solicitacao>[];
  List<Solicitacao> filtro = <Solicitacao>[];
  List<Categoria> categoria = <Categoria>[];

  _listaSolicitacao(){
    HttpService.getAllSolicitacao().then((response){
      setState(() {
        Iterable list = jsonDecode(response.body);
        solicitacao = list.map((model) => Solicitacao.fromJson(model)).toList();
        filtro = solicitacao;
      });
    });

  }
  _listaCategoria(){
    HttpService.searchCategoria().then((response){
      setState(() {
        Iterable list = jsonDecode(response.body);
        categoria = list.map((model) => Categoria.fromJson(model)).toList();
      });
    });
  }

  initState(){
    super.initState();
    _listaSolicitacao();
    _listaCategoria();
    //var timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _EditarCategoriaState());
  }

  dispose(){
    super.dispose();
  }

  Widget build(BuildContext context){

    clearData() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      print("usuario deslogou!");
    }




    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("SOLICITAÇÕES",),
        backgroundColor: Color.fromRGBO(32, 99, 155, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [

              Container(
                constraints: BoxConstraints(minWidth: 100, maxWidth: 411),
                child: TextFormField(

                  autofocus: true,

                  controller: _nome,
                  /*onChanged: (val){
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
                  onChanged: (string){
                    setState(() {
                      filtro = solicitacao.where((u) => (u.titulo.toLowerCase().contains(string.toLowerCase()))).toList();
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon:Icon(
                        Icons.search_outlined
                    ),
                    hintText: 'Pesquise por titulo, categoria',


                  ),

                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Container(
                      height: 400,
                      child: ListView.builder(
                          itemCount: filtro.length,
                          itemBuilder: (context, int index){
                            var _color;
                            if(solicitacao[index].status == "pendente"){
                              _color = Colors.amber;
                            }else{
                              _color = Colors.green;
                            }

                            if(solicitacao[index].status == "pendente"){
                              return Card(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(

                                        child: Row(
                                          children: [
                                            Title(color: Color.fromRGBO(32, 99, 155, 1), child: Text("TÍTULO: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:Color.fromRGBO(32, 99, 155, 1)
                                              ) ,)),
                                            Text(filtro[index].titulo, style: TextStyle(
                                                fontWeight: FontWeight.w400
                                            ),),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height:30,
                                        child: ListView.builder(
                                          itemCount: categoria.length,
                                          itemBuilder: (context, int i){
                                            if(solicitacao[index].categoria == categoria[i].id){
                                              return Container(
                                                  child: Row(
                                                    children: [
                                                      Title(color: Color.fromRGBO(32, 99, 155, 1), child: Text("CATEGORIA: ",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color:Color.fromRGBO(32, 99, 155, 1)
                                                        ) ,)),
                                                      Text(categoria[i].nome)
                                                    ],
                                                  )
                                              );
                                            }
                                            return SizedBox(
                                              height: 0,
                                              child: Text(""),
                                            );

                                          },
                                        ),),


                                      Container(

                                        child: Row(
                                          children: [

                                            Title(color: Color.fromRGBO(32, 99, 155, 1), child: Text("STATUS: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:Color.fromRGBO(32, 99, 155, 1)
                                              ) ,)),
                                            Text(filtro[index].status, style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: _color

                                            ),),
                                            SizedBox(
                                              width: 120,
                                            ),
                                            Container(

                                                child: TextButton(
                                                  onPressed: () async{
                                                    Solicitacao lista = filtro[index];
                                                    String json = jsonEncode(lista);
                                                    print(json.toString());

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => Resposta(json:json))
                                                    );
                                                  },child: Text("RESPONDER"),
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }else{
                              return SizedBox(
                                height: 0,
                                child: Text(""),
                              );
                            }


                          }
                      ),
                    )
                  ],
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
                    Navigator.of(context).popUntil((route) => route.isFirst);
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





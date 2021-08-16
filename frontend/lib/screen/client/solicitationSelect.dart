

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/model/Categoria.dart';
import 'package:frontend/model/Resposta.dart';
import 'package:frontend/model/Solicitacao.dart';
import 'package:frontend/screen/api/http_service.dart';
import 'package:frontend/screen/client/dashboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SolicitacaoSelecao extends StatefulWidget {
  late String json;
  SolicitacaoSelecao({required String json}){
    this.json = json;
  }

  @override
  _SolicitacaoSelecaoState createState() => _SolicitacaoSelecaoState();

}

class _SolicitacaoSelecaoState extends State<SolicitacaoSelecao> {

  Solicitacao solicitacao = new Solicitacao(titulo: "",status: "", mensagem: "", usuario: 0, categoria: 0, id_solicitacao: 0);
  Categoria categoria = new Categoria(id: 0, nome: "");
  Resposta resposta = new Resposta(usuario: 0, mensagem: "", status: "", titulo: "", id_resposta: 0, solicitacao: 0);

  _listaCategoria(){
    Map<String, dynamic> map = jsonDecode(widget.json);
    Solicitacao obj = Solicitacao.fromJson(map);
    HttpService.searchOneCategoria(obj.categoria).then((response){
      setState(() {
        Map<String, dynamic> map = jsonDecode(response.body);
        categoria = Categoria.fromJson(map);
      });
    });
  }

  _resposta(){
    Map<String, dynamic> map = jsonDecode(widget.json);
    Solicitacao obj = Solicitacao.fromJson(map);

    HttpService.getResponse(obj.id_solicitacao).then((response){
      setState(() {
        Map<String, dynamic> map = jsonDecode(response.body);
        resposta = Resposta.fromJson(map);
      });
    });
  }

  initState(){
    super.initState();
    _listaCategoria();
    _resposta();
  }


  Widget build(BuildContext context){
    if(widget.json.isNotEmpty) {
      Map<String, dynamic> map = jsonDecode(widget.json);
      Solicitacao obj = Solicitacao.fromJson(map);

      solicitacao.id_solicitacao = obj.id_solicitacao;
      solicitacao.titulo = obj.titulo;
      solicitacao.mensagem = obj.mensagem;
      solicitacao.status = obj.status;
      solicitacao.categoria = obj.categoria;
      solicitacao.usuario = obj.usuario;

    }


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("MENSAGEM",),
        backgroundColor: Color.fromRGBO(32, 99, 155, 1),
      ),

      body:SingleChildScrollView(
        child: Container(
          child: Column(

            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal:20),
              child:Row(
                children: [
                  Text("TÍTULO: ",style: TextStyle(

                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(32, 99, 155, 1),
                    fontSize: 18
              ),),
                Text(solicitacao.titulo,style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(32, 99, 155, 1),
                    fontSize: 15
                ),),
                ],
              ),
              ),

              Divider(
                thickness: 3,
                indent: 20,
                endIndent: 20,
                color:Color.fromRGBO(32, 99, 155, 1) ,

              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal:20),
                child:Row(
                  children: [
                    Text("CATEGORIA: ", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(32, 99, 155, 1),
                        fontSize: 18
                    ),),
                    Text(categoria.nome, style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(32, 99, 155, 1),
                    ),),
                  ],
                ),
              ),
              Divider(
                thickness: 3,
                indent: 20,
                endIndent: 20,
                color:Color.fromRGBO(32, 99, 155, 1),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal:20),
                child:Row(
                  children: [
                    Text("MENSAGEM ",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(32, 99, 155, 1),
                        fontSize: 18
                ),),

                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal:20, vertical: 2),
                child:Row(
                  children: [
                    Text(solicitacao.mensagem,style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(32, 99, 155, 1),
                        fontSize: 15
                    ),),
                  ],
                ),
              ),

              Divider(
                height: 200,
                thickness: 3,
                indent: 20,
                endIndent: 20,
                color:Color.fromRGBO(32, 99, 155, 1),
              ),

              Container(
                alignment: AlignmentDirectional.topStart,
                constraints: BoxConstraints(
                  minWidth: 300.0,
                  maxWidth: 300.0,
                  minHeight: 30.0,
                  maxHeight: 70.0,
                ),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Resposta ",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(32, 99, 155, 1),
                        fontSize: 20
                    ),),
                    SizedBox(
                      height: 10,
                    ),
                    Text(resposta.mensagem,style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(32, 99, 155, 1),
                        fontSize: 12
                    ),),
                  ],
                ),
              ),
              Divider(
                height: 50,
                thickness: 3,
                indent: 20,
                endIndent: 20,
                color:Color.fromRGBO(32, 99, 155, 1),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: ElevatedButton(
                  style: sendButton,
                  onPressed: () async{
                    var response = await HttpService().deleteSolicitacao(solicitacao.id_solicitacao);
                    if(response != ""){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DashBoard())
                      );
                    }
                  }, child: Text("DELETAR MENSAGEM",),
                ),
              ),

            ],
          ),
        ),
      )
    );
  }

}

final ButtonStyle sendButton = TextButton.styleFrom(

    minimumSize: Size(274, 53),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    backgroundColor: Colors.red,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),

    ),
    textStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.bold,
      fontSize: 16,

    )
);
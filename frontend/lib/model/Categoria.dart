import 'package:flutter/foundation.dart';
import 'package:frontend/screen/api/http_service.dart';


class Categoria {

  int id;
  String nome;

  Categoria({required this.id,required this.nome});

  factory Categoria.fromJson(Map<String, dynamic> json){
    return Categoria(
      id: json['id_Categoria'] as int,
      nome: json['nome'] as String,
    );
  }



}
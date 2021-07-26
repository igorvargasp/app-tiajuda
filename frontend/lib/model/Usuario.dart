import 'package:flutter/foundation.dart';

class Usuario{
   int id;
   String nome;
   String email;
   String senha;
   String tipoUsuario;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.tipoUsuario
  });

  factory Usuario.fromJson(Map<String, dynamic> json){
    return Usuario(
      id: json['id_usuario'] as int,
      nome: json['nome'] as String,
      email: json['email'] as String,
      senha: json['senha'] as String,
      tipoUsuario: json['tipoUsuario'] as String
    );
  }



}
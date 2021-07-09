


import 'dart:convert';

import 'package:frontend/model/Usuario.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class HttpService {



  Future<Usuario> postLogin(String email, String senha) async{
    String url = "http://10.0.2.2:8080/login";
    final response = await http.post(Uri.parse(url),headers: {'Content-Type': 'application/json'}, body: jsonEncode({
      "email": email,
      "senha": senha
    }));
    print(response.body);
    var prefs = await SharedPreferences.getInstance();

    if(response.statusCode == 200){
      Map mapResponse = jsonDecode(response.body);
      String json = jsonEncode(mapResponse);
      prefs.setString("usuario", json);
      return Usuario.fromJson(jsonDecode(response.body));

    }else{
      return new Usuario(id: 0,nome: "",email: "",senha: "");
    }

    }

  Future<Usuario> postRegister(String nome, String email, String senha) async{
    String url = "http://10.0.2.2:8080/register";
    final response = await http.post(Uri.parse(url),headers: {'Content-Type': 'application/json'}, body: jsonEncode({
      "nome":  nome,
      "email": email,
      "senha": senha
    }));
    print(response.body);
    if(response.statusCode == 200){
      return Usuario.fromJson(jsonDecode(response.body));
    }else{
      return new Usuario(id: 0,nome: "",email: "",senha: "");
    }

  }

  Future<Usuario> updateClient(String nome, String email, String senha, int id) async{
    String url = "http://10.0.2.2:8080/editar/$id";

    final response = await http.put(Uri.parse(url),headers: {'Content-Type': 'application/json'}, body: jsonEncode({
      "nome":  nome,
      "email": email,
      "senha": senha
    }));
    print(response.body);
    if(response.statusCode == 200){
      return Usuario.fromJson(jsonDecode(response.body));
    }else{
      return new Usuario(id:0,nome: "",email: "",senha: "");
    }

  }

  Future<Usuario> searchClient(int id) async{
    String url = "http://10.0.2.2:8080/usuario/$id";

    final response = await http.get(Uri.parse(url),headers: {'Content-Type': 'application/json'});
    var prefs = await SharedPreferences.getInstance();
    Map mapResponse = jsonDecode(response.body);
    String json = jsonEncode(mapResponse);
    if(response.statusCode == 200){
      prefs.setString("usuario", json);
      return Usuario.fromJson(jsonDecode(response.body));
    }else{
      return new Usuario(id:0,nome: "",email: "",senha: "");
    }

  }

  Future<String> deleteClient(int id) async{
    String url = "http://10.0.2.2:8080/editar/$id";
    final response = await http.delete(Uri.parse(url),headers: {'Content-Type': 'application/json'});
    var prefs = await SharedPreferences.getInstance();

    prefs.clear();
    return response.body;
  }

  }



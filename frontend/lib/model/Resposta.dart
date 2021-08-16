
class Resposta {

  int id_resposta;
  String mensagem;
  String status;
  String titulo;
  int usuario;
  int solicitacao;

  Resposta({
    required this.id_resposta,
    required this.mensagem,
    required this.status,
    required this.titulo,
    required this.usuario,
    required this.solicitacao
  });

  factory Resposta.fromJson(Map<String, dynamic> json){
    return Resposta(
        id_resposta: json['id_resposta'] as int,
        mensagem: json['mensagem'] as String,
        status: json['status'] as String,
        titulo: json['titulo'] as String,
        usuario: json['usuario'] as int,
        solicitacao: json['solicitacao'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_resposta': id_resposta,
      'mensagem': mensagem,
      'status': status,
      'titulo': titulo,
      'usuario': usuario,
      'solicitacao': solicitacao
    };
  }

}
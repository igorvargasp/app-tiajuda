

class Solicitacao {

   int id_solicitacao;
   String mensagem;
   String status;
   String titulo;
   int usuario;
   int categoria;

   Solicitacao({
     required this.id_solicitacao,
     required this.mensagem,
     required this.status,
     required this.titulo,
     required this.usuario,
     required this.categoria
});

   factory Solicitacao.fromJson(Map<String, dynamic> json){
     return Solicitacao(
       id_solicitacao: json['id_solicitacao'] as int,
       mensagem: json['mensagem'] as String,
       status: json['status'] as String,
       titulo: json['titulo'] as String,
       usuario: json['usuario'] as int,
       categoria: json['categoria'] as int
     );
   }

   Map<String, dynamic> toJson() {
     return {
       'id_solicitacao': id_solicitacao,
       'mensagem': mensagem,
       'status': status,
       'titulo': titulo,
       'usuario': usuario,
       'categoria': categoria
     };
   }

}
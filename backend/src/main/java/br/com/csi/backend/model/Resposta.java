package br.com.csi.backend.model;

import javax.persistence.*;

import lombok.Data;

@Table(name = "Resposta")
@Entity(name="Resposta")
@Data
public class Resposta {

       @Id
       @GeneratedValue
       private Integer id_resposta;
       private String mensagem;
       private String status;
       private String titulo;
       @Column(name = "id_usuario")
       private Integer usuario;
       @Column(name = "id_solicitacao")
       private Integer solicitacao;
}

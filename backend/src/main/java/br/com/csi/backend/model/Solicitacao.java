package br.com.csi.backend.model;

import javax.persistence.*;

import lombok.Data;

@Table(name = "Solicitacao")
@Entity(name="Solicitacao")
@Data
public class Solicitacao {
    
       @Id
       @GeneratedValue
       private Integer id_solicitacao;
       private String mensagem;
       private String status;
       private String titulo;
       @Column(name="id_usuario")
       private Integer usuario;
       @Column(name="id_categoria")
       private Integer categoria;

}

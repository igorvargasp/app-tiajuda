package br.com.csi.backend.model;
import javax.persistence.*;

import lombok.Data;







@Table(name = "Usuario")
@Entity(name = "Usuario")
@Data
public class Usuario {
    
    @Id
    @GeneratedValue
    private Integer id_usuario;
    private String nome;
    private String email;
    private String senha;
    private String tipoUsuario;
    

}

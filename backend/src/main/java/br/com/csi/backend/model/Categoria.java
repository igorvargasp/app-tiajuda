package br.com.csi.backend.model;

import javax.persistence.*;

import lombok.Data;

@Table(name = "Categoria")
@Entity(name = "Categoria")
@Data
public class Categoria {
    
    @Id
    @GeneratedValue
    private Integer id_Categoria;
    private String nome;
    

}

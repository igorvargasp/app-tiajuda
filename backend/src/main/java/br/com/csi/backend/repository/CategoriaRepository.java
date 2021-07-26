package br.com.csi.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.csi.backend.model.Categoria;



@Repository
public interface CategoriaRepository extends JpaRepository<Categoria, Integer> {
    
    Categoria findById(int id);
}

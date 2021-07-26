package br.com.csi.backend.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.csi.backend.repository.CategoriaRepository;
import br.com.csi.backend.model.Categoria;

@Service
public class CategoriaService {


    @Autowired
    private CategoriaRepository categoriaRepository;

    public Categoria findCategory(int id){
        return categoriaRepository.findById(id);
    }

    public List<Categoria> findAllCategory(){
        return categoriaRepository.findAll();
    }


    public Categoria createCategory(Categoria categoria){

         List<Categoria> lista = categoriaRepository.findAll();
         for (Categoria cat : lista) {
            if(cat.getNome().equals(categoria.getNome())){           
                Categoria u = new Categoria();
                u.setNome("");
               return u; 
            }
        }
        return categoriaRepository.save(categoria);
    }

  
    public Categoria updateCategory(int id, Categoria categoria){
        Categoria update = categoriaRepository.getById(id);     
        update.setNome(categoria.getNome());
        return categoriaRepository.save(update);
        
    }

    public String removeCategory(int id){
        categoriaRepository.deleteById(id);
        return "Categoria removida com sucesso!";
    }


    
}

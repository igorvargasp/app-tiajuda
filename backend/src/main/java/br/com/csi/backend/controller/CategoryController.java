package br.com.csi.backend.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import br.com.csi.backend.model.Categoria;
import br.com.csi.backend.service.CategoriaService;

@RestController
public class CategoryController {
    
    @Autowired
    private CategoriaService categoriaService;


    @GetMapping("/categoria/{id}")
    public ResponseEntity<Categoria> getCategoria(@PathVariable("id") int id){
        try {
            return ResponseEntity.ok(categoriaService.findCategory(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    
    @GetMapping("/categoria/all")
    public ResponseEntity<List<Categoria>> getCategoria(){
        try {
            return ResponseEntity.ok(categoriaService.findAllCategory());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }



    @PostMapping("/register/category")
    public ResponseEntity<Categoria> registerCategoria(@RequestBody Categoria categoria){
        
        try {
            return ResponseEntity.ok(categoriaService.createCategory(categoria));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }
 

    @PutMapping("/editar/categoria/{id}")
    public ResponseEntity<Categoria> updateCategoria(@PathVariable("id") int id, @RequestBody Categoria categoria){
        try {
            return ResponseEntity.ok(categoriaService.updateCategory(id, categoria));
        } catch (Exception e) {

           e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/editar/categoria/{id}")
    public ResponseEntity<?> deleteCategory(@PathVariable("id") int id){
        try {
            return ResponseEntity.ok(categoriaService.removeCategory(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }


    
}

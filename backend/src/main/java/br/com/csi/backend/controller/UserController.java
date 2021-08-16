package br.com.csi.backend.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import br.com.csi.backend.model.Usuario;
import br.com.csi.backend.service.UserService;


@RestController
public class UserController {
    
    @Autowired
    private UserService userService;


    @GetMapping("/usuario/{id}")
    public ResponseEntity<Usuario> getUser(@PathVariable("id") int id){
        try {
            return ResponseEntity.ok(userService.findUser(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping("/register")
    public ResponseEntity<Usuario> registerUser(@RequestBody Usuario user){
        
        try {
            return ResponseEntity.ok(userService.createUser(user));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping("/login")
    public ResponseEntity<Usuario> login(@RequestBody Usuario user){
        try {
            return ResponseEntity.ok(userService.signIn(user));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    @PutMapping("/editar/{id}")
    public ResponseEntity<Usuario> update(@PathVariable("id") int id, @RequestBody Usuario usuario){
        try {
            return ResponseEntity.ok(userService.updateUser(id, usuario));
        } catch (Exception e) {

           e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/editar/{id}")
    public ResponseEntity<?> delete(@PathVariable("id") int id){
        try {
            return ResponseEntity.ok(userService.removeUser(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    //--------------------------------------------------------
    //-----------------GERENTE--------------------------------
    //--------------------------------------------------------

    @GetMapping("/users/gerente")
    public ResponseEntity<List<Usuario>> getFuncionarios(){
        try {
            return ResponseEntity.ok(userService.findAllFuncionarios());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping("/users/gerente")
    public ResponseEntity<Usuario> createFuncionarios(@RequestBody Usuario user){
            try {
                return ResponseEntity.ok(userService.createUserFuncionario(user));
            } catch (Exception e) {
                e.printStackTrace();
            }
            return ResponseEntity.notFound().build();
    }

    @PutMapping("/users/gerente/{id}")
    public ResponseEntity<Usuario> updateFuncionario(@PathVariable("id") int id, @RequestBody Usuario usuario){
        try {
            return ResponseEntity.ok(userService.updateUserFuncionario(id, usuario));
        } catch (Exception e) {

           e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    
    @DeleteMapping("/editar/funcionario/{id}")
    public ResponseEntity<?> deleteFuncionario(@PathVariable("id") int id){
        try {
            return ResponseEntity.ok(userService.removeUserFuncionario(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

}

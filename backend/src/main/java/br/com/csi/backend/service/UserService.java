package br.com.csi.backend.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import br.com.csi.backend.model.Usuario;
import br.com.csi.backend.repository.UsuarioRepository;

@Service
public class UserService {
    
    @Autowired
    private UsuarioRepository userRepository;

    public Usuario findUser(int id){
        return userRepository.findById(id);
    }


    public Usuario createUser(Usuario user){
         user.setTipoUsuario("cliente");
         List<Usuario> lista = userRepository.findAll();
         for (Usuario usuario : lista) {
            if(usuario.getEmail().equals(user.getEmail())){
                Usuario u= new Usuario();
                u.setNome("");
                u.setSenha("");
                u.setEmail("");
               return u; 
            }
        }
        return userRepository.save(user);
    }

    public Usuario signIn(Usuario user){
        Usuario oldUser = userRepository.findUserByEmailAndSenha(user.getEmail(),user.getSenha());
         List<Usuario> lista = userRepository.findAll();
         for (Usuario usuario : lista) {
             if(usuario.getEmail().equals(oldUser.getEmail()) && usuario.getSenha().equals(oldUser.getSenha())){
                return usuario;
             }
         }
        return oldUser;
    }

    public Usuario updateUser(int id, Usuario user){
        Usuario update = userRepository.getById(id);
        update.setEmail(user.getEmail());
        update.setNome(user.getNome());
        update.setSenha(user.getSenha());
        update.setTipoUsuario("cliente");
        return userRepository.save(update);
        
    }

    public String removeUser(int id){
        userRepository.deleteById(id);
        return "Usuario removido com sucesso!";
    }
}

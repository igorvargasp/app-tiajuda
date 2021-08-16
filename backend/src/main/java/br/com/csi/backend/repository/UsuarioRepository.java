package br.com.csi.backend.repository;






import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.csi.backend.model.Usuario;



@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {

    Usuario findUserByEmailAndSenha(String email, String senha);
    Usuario findById(int id);
   


}



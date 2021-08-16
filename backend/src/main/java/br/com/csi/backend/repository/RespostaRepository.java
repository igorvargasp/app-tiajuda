package br.com.csi.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import br.com.csi.backend.model.Resposta;

@Repository
public interface RespostaRepository extends JpaRepository<Resposta, Integer> {
    
    Resposta findBySolicitacao(int id);


}

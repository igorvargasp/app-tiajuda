package br.com.csi.backend.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.csi.backend.model.Solicitacao;

@Repository
public interface SolicitacaoRepository extends JpaRepository<Solicitacao, Integer> {
    
    List<Solicitacao> findByUsuario(int id); 
    public Solicitacao findById(int id);
}

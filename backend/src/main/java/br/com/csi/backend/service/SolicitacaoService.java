package br.com.csi.backend.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.csi.backend.model.Solicitacao;
import br.com.csi.backend.repository.SolicitacaoRepository;





@Service
public class SolicitacaoService {


    @Autowired
    private SolicitacaoRepository solicitacaoRepository;
    
    public Solicitacao createSolicitacao(Solicitacao solicitacao){
       return solicitacaoRepository.save(solicitacao);
   }

   public List<Solicitacao> getSolicitacaoList(int id){
    return solicitacaoRepository.findByUsuario(id);
   }

   public String deleteSolicitacao(int id){
    solicitacaoRepository.deleteById(id);
    return "Solicitação deletada com sucesso";
   }

   public Solicitacao getOneSolicitacao(int id){
    return solicitacaoRepository.findById(id);
   }

   public Solicitacao updateSolicitacao(Solicitacao solicitacao, int id){
       Solicitacao update = solicitacaoRepository.findById(id);
       update.setCategoria(solicitacao.getCategoria());
       update.setMensagem(solicitacao.getMensagem());
       update.setStatus(solicitacao.getStatus());
       update.setTitulo(solicitacao.getTitulo());
       update.setUsuario(solicitacao.getUsuario());
       return solicitacaoRepository.save(update);
   }

   public List<Solicitacao> getAllSolicitacao(){
       return solicitacaoRepository.findAll();
   }

}

package br.com.csi.backend.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.csi.backend.model.Resposta;
import br.com.csi.backend.repository.RespostaRepository;

@Service
public class RespostaService {


    @Autowired
    private RespostaRepository service;

    public Resposta replySolicitation(Resposta resposta){
        return service.save(resposta);
    }

    public Resposta replybyId(int idSolicitacao){
        return service.findBySolicitacao(idSolicitacao);
    }
    
}

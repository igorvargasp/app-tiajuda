package br.com.csi.backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import br.com.csi.backend.model.Resposta;
import br.com.csi.backend.model.Solicitacao;
import br.com.csi.backend.model.Usuario;
import br.com.csi.backend.service.RespostaService;
import br.com.csi.backend.service.SolicitacaoService;
import br.com.csi.backend.service.UserService;

@RestController
public class RespostaController {
    

    @Autowired
    private RespostaService respostaService;
    @Autowired
    private SolicitacaoService solicitacaoService;
    @Autowired
    private UserService userService;
    @Autowired
    private JavaMailSender mailSender;

    private String sendEmail(Resposta resposta) {
        Solicitacao solicitacao = solicitacaoService.getOneSolicitacao(resposta.getSolicitacao());
        Usuario usuario = userService.findUser(solicitacao.getUsuario());

        SimpleMailMessage message = new SimpleMailMessage();
        message.setText(resposta.getMensagem());
        message.setTo(usuario.getEmail());
        message.setSubject(resposta.getTitulo()+" - " + resposta.getStatus());
        message.setFrom("apptihelp@gmail.com");
        
        try {
            mailSender.send(message);
            return "Email enviado com sucesso!";
        } catch (Exception e) {
            e.printStackTrace();
            return "Erro ao enviar email.";
        }

    }

    @PostMapping("/resposta")
    public ResponseEntity<Resposta> reply(@RequestBody Resposta resposta){
        try {
            sendEmail(resposta);
            return ResponseEntity.ok(respostaService.replySolicitation(resposta));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/resposta/{id}")
    public ResponseEntity<Resposta> getReplyId(@PathVariable("id") int id){
        try {
            return ResponseEntity.ok(respostaService.replybyId(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }
    




}

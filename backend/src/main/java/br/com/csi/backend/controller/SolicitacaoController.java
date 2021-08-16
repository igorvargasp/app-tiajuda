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

import br.com.csi.backend.model.Solicitacao;
import br.com.csi.backend.service.SolicitacaoService;

@RestController
public class SolicitacaoController {
    
    @Autowired
    private SolicitacaoService service;

    @PostMapping("/solicitacao")
    public ResponseEntity<Solicitacao> registerSolicitacao(@RequestBody Solicitacao solicitacao){
        try {
            return ResponseEntity.ok(service.createSolicitacao(solicitacao));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/solicitacao/{id}")
    public ResponseEntity<List<Solicitacao>> getSolicitacao(@PathVariable("id") int idUser){
        try {
            return ResponseEntity.ok(service.getSolicitacaoList(idUser));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/solicitacao/{id}")
    public ResponseEntity<?> deleteSolicitacao(@PathVariable("id") int id){
        try {
            return ResponseEntity.ok(service.deleteSolicitacao(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/solicitacao/one/{id}")
    public ResponseEntity<Solicitacao> getOneSolicitacao(@PathVariable("id") int id){
        try {
            return ResponseEntity.ok(service.getOneSolicitacao(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    @PutMapping("/solicitacao/editar/{id}")
    public ResponseEntity<Solicitacao> updateSolicitacao(@PathVariable("id") int id, @RequestBody Solicitacao solicitacao){
        try {
            return ResponseEntity.ok(service.updateSolicitacao(solicitacao, id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/solicitacao")
    public ResponseEntity<List<Solicitacao>> solicitacaoList(){
        try {
            return ResponseEntity.ok(service.getAllSolicitacao());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

}

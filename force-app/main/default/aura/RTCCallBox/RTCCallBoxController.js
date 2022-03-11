({
    doInit : function(component, event, helper)
    {
        //helper.observarEventosCallbox(component, event, helper);
    },
    //Efetuar login callbox
    logarCallbox : function(component, event, helper) 
    {
        component.set('v.carregando', true);
        helper.salvarInformcoesLogin(component, event, helper);
    },
    //Manipular discador
    manipularTeclaPressionada : function(component, event, helper)
    {
        let tecla = event.getParam('tecla');

        let telefone = component.get('v.telefone');

        if(!telefone)
            telefone = '';

        switch(tecla)
        {
            case 'apagar':
                telefone = telefone.substring(0, telefone.length-1);
                break;
            case 'limpar':
                telefone = '';
                break;
            default:
                if(!telefone)
                    telefone = tecla;
                else
                    telefone += tecla;
                break;
        }

        component.set('v.telefone', telefone);
    },
    //Edição de ramal
    editarRamal : function(component, event, helper)
    {
        component.set('v.loginCadastrado', false);
    },
    //Efetuar ligação
    ligarParaTelefone : function(component, event, helper)
    {
        component.set('v.idTarefa', undefined);
        helper.efetuarLigacaoDireta(component, event, helper);
    },
    logarRamalELigarTelfone : function(component, event, helper)
    {
        console.log('logarRamalELigarTelfone');
        console.log(component.get('v.ativarEventoCallbox'));
        component.set('v.telefone', event.getParam('arguments').telefone);
        component.set('v.registroRelacionado', event.getParam('arguments').registroRelacionado);
        event.getParam('arguments').idTarefa

        if(!!event.getParam('arguments').idTarefa)
            component.set('v.idTarefa', event.getParam('arguments').idTarefa);

        if(!component.get('v.ativarEventoCallbox'))
            return;

        if(!component.get('v.telefone') || component.get('v.telefone') == 'null' || component.get('v.telefone') == 'undefined')
        {
            component.set('v.telefone', '');
            component.set('v.carregando', false);
            return;
        }

        if(!component.get('v.ramalRegistrado'))
        {
            helper.registrarRamal(component, event, helper);
            component.set('v.registrarRamalELigar', true);
        }
        else
            helper.efetuarLigacaoDireta(component, event, helper);

        component.set('v.ativarEventoCallbox', false);
    },
    atenderLigacao : function(component, event, helper)
    {
        WebphoneL5.accept();
    },
    recusarLigacao : function(component, event, helper)
    {
        WebphoneL5.reject();
    },
    voltarDiscador : function(component, event, helper)
    {
        component.set('v.statusLigacao', 'discando');
        component.set('v.telefone', '');
    },
    mudarStatusRamal : function(component, event, helper)
    {
        component.set('v.ativarEventoCallbox', false);
        component.set('v.carregando', true);
        if(!component.get('v.ramalRegistrado'))
            helper.registrarRamal(component, event, helper);
        else
            helper.desregistrarRamal(component, event, helper);
    },
    unregisterRamal : function(component, event, helper)
    {
        if(component.get('v.ramalRegistrado'))
            helper.desregistrarRamal(component, event, helper);
    },
    //Controlar ligação
    //Mutar ligação
    mutarLigacao : function(component, event, helper)
    {
        component.set('v.ligacaoMutada', !component.get('v.ligacaoMutada'));
        
        if(component.get('v.ligacaoMutada'))
            WebphoneL5.mute();
        else
            WebphoneL5.unmute();
    },
    //Pausar ligação
    pausarLigacao : function(component, event, helper)
    {
        component.set('v.ligacaoPausada', !component.get('v.ligacaoPausada'));
        
        if(component.get('v.ligacaoPausada'))
            WebphoneL5.hold();
        else
            WebphoneL5.unhold();
    },
    //Finalizar ligação
    finalizarLigacao : function(component, event, helper)
    {
        WebphoneL5.hangup();
    },
    //Histórico
    abrirOuOcultarHistorico : function(component, event, helper)
    {
        component.set('v.carregando', true);

        if(component.get('v.verHistorico'))
        {
            component.set('v.verHistorico', false);
            component.set('v.carregando', false);
        }
        else
            helper.buscarHistoricoChamadas(component, event, helper);
    },
    ligarTelefone : function(component, event, helper)
    {
        component.set('v.telefone', event.getSource().get("v.value"));
        component.set('v.verHistorico', false);
    },
    //Transferir ligação
    abrirAreaTransferencia : function(component, event, helper)
    {
        component.set('v.transferirLigacao', true);
    },
    conectarRamal : function(component, event, helper)
    {
        let ramalDestino = component.get('v.ramalTransferencia');
        WebphoneL5.dtmf({ dtmf: "1" });

        component.set('v.tentativaTranferencia', true);
        component.set('v.transferenciaEmAndamento', true);

        WebphoneL5.transfer({ number: ramalDestino });

        setInterval(function(){
            component.set('v.transferenciaEmAndamento', false);
        }, 10000);
    },
    transferirLigacao : function(component, event, helper)
    {
        helper.transferirTarefaChamada(component, event, helper);
    },
    cancelarTransferencia : function(component, event, helper)
    {
        WebphoneL5.cancelTransfer();
        component.set('v.ramalTransferencia', '');
        component.set('v.transferirLigacao', false);
        component.set('v.tentativaTranferencia', false);
    },
    fecharAlerta : function(component, event, helper)
    {
        component.set('v.mostrarAlerta', false);
    }
})
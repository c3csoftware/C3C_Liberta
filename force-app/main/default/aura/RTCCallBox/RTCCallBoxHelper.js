({
    //Salvar informações de login callbox
    salvarInformcoesLogin : function(component, event, helper)
    {
        let servico = component.find('AcessoCallBoxService');
        
        servico.setParams({
            'ramalUsuario': component.get('v.ramal'),
            'senhaCallbox': component.get('v.senhaCallbox')
        });

        servico.callServiceMethod('salvarInformacoesAcessoCallboxUsuarioAtual', '', (data) =>
        {
            if(data.status == 'CompletedSuccess')
            {
                component.set('v.loginCadastrado', true);
            }
            else if(data.status == 'CompletedError')
            {
                for (let error of data.errors) 
                {
                    helper.showToast(component, 'error', 'Erro!!', 'Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                }
            }

            component.set('v.carregando', false);
        });
    },
    //Obter informações do login callbox
    obterInformacoesLogin : function(component, helper) 
    {
        let servico = component.find('AcessoCallBoxService');
        let callboxAuraEvent = $A.get("e.c:CallboxAuraEvent");

        servico.callServiceMethod('obterInformacoesDoLoginCallBoxDoUsuarioAtual', '', (data) => 
        {
            if(data.status == 'CompletedSuccess')
            {
                component.set('v.ramal', data.response.ramalCallbox);

                if(!!data.response.senhaCallbox && !!data.response.ramalCallbox)
                {
                    console.log('userinfo', JSON.parse(JSON.stringify(data.response)));
                    component.set('v.senhaCallbox', data.response.senhaCallbox);
                    component.set('v.serverCallbox', data.response.serverCallbox);
                    component.set('v.loginCadastrado', true);

                    callboxAuraEvent.fire();
                }
            }
            else if(data.status == 'CompletedError')
            {
                for (let error of data.errors) 
                {
                    helper.showToast(component, 'error', 'Erro!!', 'Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                }
            }

            component.set('v.consultandoLogin', false);
            component.set('v.carregando', false);
        });
    },
    efetuarLigacao : function(component, event, helper, telefone)
    {
        console.log('Ligando para: '+telefone);
        //Cadastrar ramal
        WebphoneL5.call({
            "number": telefone
        });
    },
    registrarRamal : function(component, event, helper)
    {
        let servico = component.find('AcessoCallBoxService');

        servico.setParams({
            'ramal': component.get('v.ramal'),
            'identificacaoGuia': component.get('v.identificacaoGuia')
        })

        servico.callServiceMethod('registrandoRamal', '', (data) => 
        {
            if(data.status == 'CompletedSuccess')
            {
                try
            	{
                    WebphoneL5.init( 
                    {
                        'extension': component.get('v.ramal'),
                        'password': component.get('v.senhaCallbox'),
                        'server': component.get('v.serverCallbox'),
                        'hideInterface': true,
                        'showCdr': true
                    });
    			}catch(e)
                {
                    helper.showToast(component, 'error', '', 'Ocorreu um problema ao tentar conectar no Ramal, por favor verifique seu ramal e senha e tente novamente.');
                    component.set('v.ramalRegistrado', false);
                    component.set('v.carregando', false);
                    console.log(e);
                }
            }
            else if(data.status == 'CompletedError')
            {
                component.set('v.carregando', false);
                for (let error of data.errors) 
                {
                    helper.showToast(component, 'error', 'Erro!!', 'Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                }
            }
        });
    },
    desregistrarRamal : function(component, event, helper)
    {
        try
        {
            WebphoneL5.unregister();
        }catch(e){
            helper.showToast(component, 'error', '', 'Ocorreu um problema ao tentar desconectar no Ramal.');
            component.set('v.ramalRegistrado', false);
            component.set('v.carregando', false);
            console.log(e);
        }

        if(window.location.href.includes('?ligar'))
            window.location.href = window.location.href.split('?ligar')[0];
        else if(window.location.href.includes('&ligar'))
            window.location.href = window.location.href.split('&ligar')[0];
        else
            window.location.href = '';
    },
    salvarInformacoesChamada : function(component, event, helper)
    {

        let servico = component.find('TaskCallService');

        if(!!component.get('v.telefone') && component.get('v.telefone').length < 8)
        {
            console.log('Número não pode salvar');
            return;
        }

        let callState = component.get('v.callState');
        let callboxChamadaInfo = {
            idTarefaChamada: component.get('v.idTarefa'),
            numeroDestino: component.get('v.telefone'),
            ramalUtilizado: callState.from,
            statusChamada: callState.state,
            direcaoChamada: callState.direction
        };

        console.log('registroRelacionado: '+component.get('v.registroRelacionado'));

        if(!!component.get('v.registroRelacionado'))
            callboxChamadaInfo.registroRelacionado = component.get('v.registroRelacionado');

        if(!!callState.CDR)
        {
            callboxChamadaInfo.duracaoSegudos = parseInt(callState.CDR.duration),
            callboxChamadaInfo.dataInicioChamada = callState.CDR.startDate;
            callboxChamadaInfo.dataTerminoChamada = callState.CDR.endDate;
            callboxChamadaInfo.linkAcessarGravacaoChamada = callState.CDR.recordingLink;
        }
        
        servico.setParams({
            callboxChamadaInfo: JSON.stringify(callboxChamadaInfo)
        });

        servico.callServiceMethod('criarAtualizarTarefaChamada', '', (data) =>
        {
            if(data.status == 'CompletedSuccess')
            {
                console.log(JSON.stringify(data));
                component.set('v.idTarefa', data.response);
                component.set('v.registroRelacionado', undefined);
            }
            else if(data.status == 'CompletedError')
            {
                for (let error of data.errors) 
                {
                    helper.showToast(component, 'error', 'Erro!!', 'Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                }
            }
        });
    },

    //Efetuar ligação ao registrar ramal
    efetuarLigacaoDireta : function(component, event, helper)
    {
        component.set('v.ligandoParaTelefone', true);

        let telefone = component.get('v.telefone');

        if(!!telefone)
        {
            telefone = telefone.replace('+55', '');
            telefone = telefone.replace(/[^0-9]/g,'');
        }

        if(!telefone)
            telefone = '';

        if(!!telefone && telefone.length > 8)
        {
            component.set('v.telefoneFormated', telefone.substring(0, 5)+telefone.substring(4, telefone.length-5));
            
            if(telefone.substring(0, 2) == '51')
            {
                telefone = telefone.replace('51', '');
                telefone = '0'+telefone;
            }
            else if(telefone.substring(0, 3) == '051')
            {
                telefone = telefone.replace('051', '');
                telefone = '0'+telefone;
            }
            else
            {
                if(telefone.substring(0, 1) != '0')
                    telefone = '0'+telefone;
            }
        }

        component.set('v.statusLigacao', 'conectandoLigacao');
        helper.efetuarLigacao(component, event, helper, telefone);
    },

    //Transferência tarefa
    transferirTarefaChamada : function(component, event, helper)
    {
        let ramalTransferencia = component.get('v.ramalTransferencia');
        let idTarefa = component.get('v.idTarefa');

        let servico = component.find('TaskCallService');

        servico.setParams({
            'idTarefa': idTarefa,
            'ramalTransferencia': ramalTransferencia
        });

        servico.callServiceMethod('tranferirChamada', '', (data) =>
        {
            if(data.status == 'CompletedSuccess')
            {
                console.log(idTarefa);
                console.log('Atualizar');
                WebphoneL5.completeTransfer();

                component.set('v.ramalTransferencia', '');
                component.set('v.transferirLigacao', false);
                component.set('v.tentativaTranferencia', false);
            }
            else if(data.status == 'CompletedError')
            {
                for (let error of data.errors) 
                {
                    helper.showToast(component, 'error', 'Erro!!', 'Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                }
            }
        });
    },

    //Histórico
    buscarHistoricoChamadas : function(component, event, helper)
    {
        let servico = component.find('TaskCallService');

        servico.callServiceMethod('obterTarefasChamadasDoUsuarioAtual', '', (data) =>
        {
            if(data.status == 'CompletedSuccess')
            {
                if(!!data.response)
                    component.set('v.historico', data.response);

                component.set('v.verHistorico', true);
                component.set('v.carregando', false);
            }
            else if(data.status == 'CompletedError')
            {
                for (let error of data.errors) 
                {
                    helper.showToast(component, 'error', 'Erro!!', 'Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                }
            }
        });
    },

    //Observers
    observarStatusRamal : function(component, helper)
    {
        WebphoneL5.onWebphoneStateChange (
            function(webphoneState) 
            {
                console.log('WEBPHONESATATE', webphoneState);

                if(webphoneState == 'registered')
                {
                    if(component.get('v.registrarRamalELigar'))
                    {
                        helper.efetuarLigacaoDireta(component, event, helper);
                        component.set('v.registrarRamalELigar', false);
                    }

                    component.set('v.ramalRegistrado', true);
                    component.set('v.carregando', false);
                }
                else if(webphoneState == 'unregistered')
                {
                    component.set('v.ramalRegistrado', false);
                    component.set('v.carregando', false);
                }
                else if(webphoneState == 'error to register')
                {
                    component.set('v.ramalRegistrado', false);  
                    component.set('v.carregando', false);
                    component.set('v.carregandoLigacao', false);
					component.set('v.ligandoParaTelefone', false);
                    component.set('v.ligarRedirect', false);
                    component.set('v.registrarRamalELigar', false);
                    helper.showToast(component, 'error', '', 'Ocorreu um problema ao tentar conectar no Ramal, por favor verifique seu ramal e senha, e tente novamente.');
                    window.setTimeout(function(){
                        helper.desregistrarRamal(component, null, helper);
                    }, 10000);
                }
            }
        );
    },
    observarStatusChamada : function(component, helper)
    {
        WebphoneL5.onCallStateChange(
            function(callState) 
            {
                console.log('Call state');
                console.log(callState);

                switch(callState.state)
                {
                    case 'setup':
                        component.set('v.mostrarControleLigacao', true);
                        
                        if(!component.get('v.ligandoParaTelefone'))
                        {
                            component.set('v.telefone', callState.from);
                        }

                        component.set('v.ligarRedirect', false);
                        break;
                    case 'connected':
                        component.set('v.carregandoLigacao', false);
                        break;
                    case 'disconnected':
                        component.set('v.mostrarControleLigacao', false);
                        component.set('v.carregandoLigacao', true);
                        component.set('v.ligandoParaTelefone', false);
                        break;
                }

                component.set('v.callState', callState);
                component.set('v.statusLigacao', callState.state);

                if(callState.state != 'disconnected' || (callState.state == 'disconnected' && !!callState.CDR))
                    helper.salvarInformacoesChamada(component, null, helper);
            }
        );
    },
    showToast: function (component, type, title, message) 
    {
        component.set('v.tipoAlerta', type);
        component.set('v.mensagemAlerta', message);
        component.set('v.mostrarAlerta', true);
        
    },

    //Observers event
    observarEventosCallbox : function(component, event, helper)
    {
        
    }
})
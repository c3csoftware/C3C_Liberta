({
    obterChecklist: function (component, helper) {
        let service = component.find('ChecklistService');

        service.setParams({
            idTarefa: component.get('v.recordId')
        });

        service.callServiceMethod('obterListaPeguntaViewModel', '',
            (data) => {
                if (data.status == 'CompletedSuccess') {
                    component.set('v.listaPerguntas', data.response);
                    if(data.response.length > 0)
                    {
                        let response = data.response[0];
                        if(response['pergunta'] != undefined)
                            component.set('v.tipoTarefa', response.pergunta.tipoTipoDeTarefa);
                    }
                    console.log('data.response:', data.response);

                    helper.verificarPerguntasRelacionadas(component, null, helper);
                }
                else {
                    for (let error of data.errors) {
                        console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    }
                }
            });
    },

    salvarChecklist: function (component, event, helper) {
        let service = component.find('ChecklistService');
        var workspaceAPI = component.find("workspace");

        service.setParams({
            idTarefa: component.get('v.recordId'),
            listaDePerguntasDaTarefa: JSON.stringify(component.get('v.listaPerguntas'))
        });

        service.callServiceMethod('salvarRespostasDaTarefa', '',
            (data) => {
                if (data.status == 'CompletedSuccess') {
                    component.set('v.listaPerguntas', data.response);

                    helper.showToast('success', 'Sucesso!!', 'Checklist salvo!!');
                    $A.get('e.force:refreshView').fire();
                    
                    try
                    {
                        helper.verificarPerguntasRelacionadas(component, event, helper);
                        workspaceAPI.getFocusedTabInfo().then(function (response) {
                            var focusedTabId = response.tabId;
                            workspaceAPI.closeTab({ tabId: focusedTabId });
                        }).catch(function (error) {
                            console.log(error);
                        });
                    }catch(e)
                    {
                        console.log(e);
                        helper.showToast('warning', 'Atenção!!', 'Ocorreu um problema, por favor atualize a tela.');
                    }
                }
                else {
                    for (let error of data.errors) {
                        helper.showToast('error', 'Erro!!', 'Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                        console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    }
                }
                component.set('v.spinner', false);
            });
    },

    atualizarTarefa: function (component, event, helper) {
        let service = component.find('AtualizarTarefaService');

        service.setParams({
            idRegistro: component.get('v.recordId'),
        });

        service.callServiceMethod('atualizarWhatIdParaWhoId', '',
            (data) => {
                console.log(JSON.parse(JSON.stringify(data)));

                if (data.status == 'CompletedSuccess') {
                    console.log('Atualizado com sucesso!');
                }
                else {
                    for (let error of data.errors) {
                        helper.showToast('error', 'Erro!!', 'Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                        console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    }
                }
                component.set('v.spinner', false);
            });
    },

    verificarRespostasComColetaDeInformacoes: function (component, event, helper) {
        let listaDePerguntas = component.get('v.listaPerguntas');

        for (let pergunta of listaDePerguntas) {
            if (!pergunta.listIntanciaRespostaComInformacoes)
                pergunta.listIntanciaRespostaComInformacoes = [];

            for (let indexColetaInformacao = 0; indexColetaInformacao < pergunta.listIntanciaRespostaComInformacoes.length; indexColetaInformacao++) {
                if (pergunta.pergunta.tipo == 'Única escolha') {
                    let indexRespostaPerguntaUnica = pergunta.listIntanciaRespostaComInformacoes[indexColetaInformacao].resposta.value == pergunta.respostaAlternativa;

                    if (!indexRespostaPerguntaUnica)
                        pergunta.listIntanciaRespostaComInformacoes.splice(indexColetaInformacao, 1);
                }

                if (pergunta.pergunta.tipo == 'Múltipla escolha') {
                    let indexRespostaPerguntaMultipla = pergunta.listaRespostasMultiplaEscolhaSelecionadas.includes(pergunta.listIntanciaRespostaComInformacoes[indexColetaInformacao].resposta.value);

                    if (!indexRespostaPerguntaMultipla)
                        pergunta.listIntanciaRespostaComInformacoes.splice(indexColetaInformacao, 1);
                }
            }

            //Pergunta com escolha única
            if (pergunta.pergunta.tipo == 'Única escolha') {
                helper.preencherListaDeColetaInfomacao(pergunta.respostaAlternativa, pergunta);
            }

            //Pergunta com escolha múltipla
            if (pergunta.pergunta.tipo == 'Múltipla escolha') {
                for (let idResposta of pergunta.listaRespostasMultiplaEscolhaSelecionadas) {
                    helper.preencherListaDeColetaInfomacao(idResposta, pergunta);
                }
            }
        }

        component.set('v.listaPerguntas', listaDePerguntas);
    },

    preencherListaDeColetaInfomacao: function (idResposta, pergunta) {
        let indexColetaInformacao = pergunta.listIntanciaRespostaComInformacoes.findIndex(x => x.resposta.value == idResposta);

        let coletaInformacao = {};

        if (indexColetaInformacao >= 0)
            coletaInformacao = pergunta.listIntanciaRespostaComInformacoes[indexColetaInformacao];

        let indexRespostaDisponiveis = pergunta.listaDeRespostas.findIndex(x => x.value == idResposta && x.habilitarColetaInformacoes);

        if (indexRespostaDisponiveis >= 0) {
            coletaInformacao.resposta = pergunta.listaDeRespostas[indexRespostaDisponiveis];
            if (!coletaInformacao.instanciaRespostaMapper) {
                coletaInformacao.instanciaRespostaMapper = {
                    idRegistro: coletaInformacao.resposta.idRespostaRespondida,
                    respostaAlternativa: idResposta
                }
            }

            if (indexColetaInformacao < 0)
                pergunta.listIntanciaRespostaComInformacoes.push(coletaInformacao);
        }
    },

    verificarCamposObrigatorios: function (component, helper, mostrarToast) {
        let listaDePerguntas = component.get('v.listaPerguntas');
        let verificado = true;

        for (let pergunta of listaDePerguntas) {
            let perguntaPassou = false;

            if (pergunta.pergunta.obrigatorio) {
                if (pergunta.pergunta.tipo == 'Dissertativa' || pergunta.pergunta.tipo == 'Moeda')
                    perguntaPassou = !!pergunta.respostaDissertativa;

                switch (pergunta.pergunta.tipo) {
                    case 'Dissertativa':
                        perguntaPassou = !!pergunta.respostaDissertativa;
                        break;
                    case 'Moeda':
                        perguntaPassou = !!pergunta.respostaDissertativa;
                        break;
                    case 'Única escolha':
                        perguntaPassou = !!pergunta.respostaAlternativa;
                        break;
                    case 'Múltipla escolha':
                        perguntaPassou = pergunta.listaRespostasMultiplaEscolhaSelecionadas.length > 0;
                        break;
                }
            }
            else
                perguntaPassou = true;

            if (!perguntaPassou) {
                verificado = false;
            }

            pergunta.erro = !perguntaPassou;
        }

        if (!verificado && mostrarToast)
            helper.showToast('error', 'Erro!!', 'Preencha todos os campos obrigatórios.');

        component.set('v.listaPerguntas', listaDePerguntas);
        return verificado;
    },

    verificarPerguntasRelacionadas: function (component, event, helper) {
        console.log('verificarPerguntasRelacionadas');
        let listaDePerguntas = component.get('v.listaPerguntas');

        console.log(listaDePerguntas);
        for (let pergunta of listaDePerguntas) {
            console.log(pergunta.pergunta.recordId);
            let perguntaRelacionada = listaDePerguntas.findIndex(x => x.pergunta.perguntaRelacionadaPergunta == true && x.pergunta.perguntaRelacionada == pergunta.pergunta.recordId);

            console.log(perguntaRelacionada);
            console.log(listaDePerguntas[perguntaRelacionada]);
            if (perguntaRelacionada >= 0) {
                console.log('encontrei');
                for (let perguntaRelacionada of listaDePerguntas) {
                    if (perguntaRelacionada.pergunta.perguntaRelacionadaPergunta != true ||
                        pergunta.pergunta.recordId != perguntaRelacionada.pergunta.perguntaRelacionada)
                        continue;

                    console.log(perguntaRelacionada.pergunta.perguntaRelacionadaPergunta == true &&
                        pergunta.pergunta.recordId == perguntaRelacionada.pergunta.perguntaRelacionada);
                    console.log(!$A.util.isEmpty(perguntaRelacionada.respostaAlternativa));
                    console.log(perguntaRelacionada.listaRespostasMultiplaEscolhaSelecionadas.length > 0);
                    console.log('------');
                    if (
                        (
                            (
                                !$A.util.isEmpty(pergunta.respostaAlternativa) &&
                                pergunta.respostaAlternativa == perguntaRelacionada.pergunta.respostaRelacionada
                            ) ||
                            (
                                pergunta.listaRespostasMultiplaEscolhaSelecionadas.length > 0 &&
                                pergunta.listaRespostasMultiplaEscolhaSelecionadas.findIndex(x => x.value == perguntaRelacionada.pergunta.respostaRelacionada) >= 0
                            )
                        )
                    )
                        perguntaRelacionada.visualizarRelacioada = true;
                    else {
                        perguntaRelacionada.visualizarRelacioada = false;
                        perguntaRelacionada.respostaAlternativa = '';
                        perguntaRelacionada.listaRespostasMultiplaEscolhaSelecionadas = [];
                        perguntaRelacionada.respostaDissertativa = '';
                    }
                }
            }
        }

        component.set('v.listaPerguntas', listaDePerguntas);
    },

    dispararEvento: function (component, event) {
        console.log('$A.get("e.c:C3C_FechouChecklistHunter"):', $A.get("e.c:C3C_FechouChecklistHunter"));
        $A.get("e.c:C3C_FechouChecklistHunter").fire();
    },

    showToast: function (type, title, message) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            type,
            title,
            message
        });
        toastEvent.fire();
    }
})
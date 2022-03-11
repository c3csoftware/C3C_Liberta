({
    abrirLeadOuOportunidade: function (component) {
        var workspaceAPI = component.find("workspace");
        if (component.get('v.idLead') != '' || component.get('v.idOportunidade') != '') {
            workspaceAPI.getFocusedTabInfo().then(function (response) {
                workspaceAPI.openSubtab({
                    parentTabId: response.tabId,
                    url: component.get('v.idLead') != '' ? '/lightning/r/Lead/' + component.get('v.idLead') + '/view' : '/lightning/r/Opportunity/' + component.get('v.idOportunidade') + '/view',
                    focus: true
                });
            })
                .catch(function (error) {
                    console.log(error);
                });
        }
    },

    abrirTask: function (component) {
        var workspaceAPI = component.find("workspace");
        if (component.get('v.idTarefa') != '') {
            workspaceAPI.getFocusedTabInfo().then(function (response) {
                workspaceAPI.openSubtab({
                    parentTabId: response.tabId,
                    url: '/lightning/r/Task/' + component.get('v.idTarefa') + '/view',
                    focus: true
                });
            })
                .catch(function (error) {
                    console.log(error);
                });
        }
    },

    buscarLeadFilho: function (component, helper) {
        let service = component.find('BuscarInfomacoesLeadFilhoService');

        service.setParams({
            idRegistro: component.get('v.recordId')
        });

        service.callServiceMethod('obterLeadFilhoPorId', '',
            (data) => {
                if (data.status == 'CompletedSuccess') {
                    component.set('v.idLead', data.response.lead == undefined ? '' : data.response.lead);
                    component.set('v.idOportunidade', data.response.oportunidade == undefined ? '' : data.response.oportunidade);
                    component.set('v.idLeadFilho', data.response.recordId);
                    helper.abrirLeadOuOportunidade(component);
                    helper.buscarTarefa(component, helper);

                }
                else {
                    for (let error of data.errors) {
                        console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    }
                }
            });
    },

    buscarTarefa: function (component, helper) {
        let service = component.find('BuscarInformacoesTarefaService');

        service.setParams({
            relativo: component.get('v.idOportunidade') == '' ? component.get('v.idLead') : component.get('v.idOportunidade'),
            nomeTipoTarefa: component.get('v.idOportunidade') == '' ? "Qualificacao de Lead" : "Qualificacao de Oportunidade"
        });

        service.callServiceMethod('obterTarefaPorTipoDeTarefaEWhatIdComLimitacao', '',
            (data) => {
                if (data.status == 'CompletedSuccess') {
                    component.set('v.idTarefa', data.response.recordId);
                    console.log('task:',JSON.stringify(data.response));
                    if (data.response.recordId != undefined)
                        helper.abrirTask(component);
                }
                else {
                    for (let error of data.errors) {
                        console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    }
                }
            });
    },
})
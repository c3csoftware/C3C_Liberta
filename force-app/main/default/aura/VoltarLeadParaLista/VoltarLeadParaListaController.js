({
    doInit : function(component, event, helper) 
    {
        component.set('v.opcoesFlag', [
            {value: 'ligação', label: 'Retorno em Ligação'},
            {value: 'wpp', label: 'Retorno em Whatsapp'},
            {value: 'email', label: 'Retorno no E-mail'}
        ]);
    },
    mudarValoresSelecionados : function(component, event, helper)
    {
        let opcoesFlagSelecionados = component.get('v.opcoesFlagSelecionados');
        let opcoesFlag = component.get('v.opcoesFlag');

        if(opcoesFlagSelecionados.length == opcoesFlag.length)
        {
            component.set('v.mostrarProcessoVoltarLeadLista', true);
            helper.buscarLeadListas(component, event, helper);
        }
        else
        {
            component.set('v.mostrarProcessoVoltarLeadLista', false);
            component.set('v.registroNaoQualificado', true);
        }
    },
    listaLeadSelecionado : function(component, event, helper)
    {
        let valorSelecionado = component.find("picklistListaLead").get("v.value");
        
        component.set('v.listaLeadSelecionado', valorSelecionado);
        component.set('v.botaoVoltaListaLeadAtivo', !valorSelecionado);
    },
    voltarParaListaLead : function(component, event, helper)
    {
        component.set('v.carregandoListaLead', true);
        let servico = component.find('LeadFilhoService');

        servico.setParams({
            idListaLead: component.get('v.listaLeadSelecionado')
        });

        let closeQuickAction = $A.get("e.force:closeQuickAction");
        let refreshView = $A.get("e.force:refreshView");

        servico.callServiceMethod('voltarListaLeadParaFilaCorrespondete', '', function(data) 
        {
            if(data.status == 'CompletedSuccess') 
            {
                helper.showToast('success', 'Sucesso!!', 'Registro voltou para a Lista Lead ');

                closeQuickAction.fire();
            }
            else
            {
                for(let error of data.errors)
                {
                    helper.showToast('error', 'Erro!!', 'Error: '+error.erroCode+', Message: '+error.messageLabelOrText);
                    console.log('Houve um erro na comunicação com o backend. Error: '+error.erroCode+', Message: '+error.messageLabelOrText);
                }
            }

            refreshView.fire();
            component.set('v.carregandoListaLead', false);
        });
    }
})
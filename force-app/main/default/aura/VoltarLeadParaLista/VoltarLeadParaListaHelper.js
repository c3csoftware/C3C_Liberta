({
    buscarLeadListas : function(component, event, helper) 
    {
        let servico = component.find('LeadFilhoService');

        servico.setParams({
            listaIdLeadIdOportunidade: JSON.stringify([component.get('v.recordId')])
        });

        servico.callServiceMethod('obterLeadFilhoPorListaIdLeadIdOportunidade', '', (data) => 
        {
            if(data.status == 'CompletedSuccess') 
            {
                if(data.response.length == 1)
                    component.set('v.listaLeadSelecionado', data.response[0].recordId)

                component.set('v.listaLeads', data.response);
            }
            else
            {
                for(let error of data.errors)
                {
                    helper.showToast('error', 'Erro!!', 'Error: '+error.erroCode+', Message: '+error.messageLabelOrText);
                    console.log('Houve um erro na comunicação com o backend. Error: '+error.erroCode+', Message: '+error.messageLabelOrText);
                }
            }

            component.set('v.carregandoListaLead', false);
        });
    },
    showToast: function (type, title, message) 
    {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            type,
            title,
            message
        });
        toastEvent.fire();
    }
})
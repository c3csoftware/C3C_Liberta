({
    salvarChecklist : function(component, event, helper)
    {
        if(helper.verificarCamposObrigatorios(component, helper, true))
        {
            component.set('v.spinner', true);
            if(component.get('v.tipoTarefa') == 'NPS do Assessor')
                helper.salvarChecklist(component, event, helper);
            else
            {
                if(component.get('v.tipoTarefa') == 'Qualificacao de Lead')
                    helper.dispararEvento(component, event);
                //helper.atualizarTarefa(component, event, helper);
                helper.salvarChecklist(component, event, helper);
            }           
        }
    },
    alteracaoRespostas : function(component, event, helper)
    {
        helper.verificarCamposObrigatorios(component, helper, false);
        helper.verificarRespostasComColetaDeInformacoes(component, event, helper);
        helper.verificarPerguntasRelacionadas(component, event, helper);
    },
})
({
    init: function (component, event, helper) 
    {
        let tipoErro = component.get('v.tipoDeErro');
        if (tipoErro != undefined)
        {
            component.set('v.spinner', false);
            if(tipoErro.includes(' Campos: IdChaveExterna__c: []'))
            {
                component.set('v.tipoDeErro', tipoErro.replace('IdChaveExterna__c: []', 'CPF/CNPJ')); 
                component.set('v.displayModalErro', true);
                component.set('v.displayBotaoConverter', true);
            }
            else if(tipoErro.includes(' Campos: Codigo__c: []'))
            {
                component.set('v.displayModalErro', true);
                component.set('v.tipoDeErro', tipoErro.replace('Codigo__c: []', 'Código XP'));  
            }
            else if(tipoErro.includes('IdChaveExterna__c') && tipoErro.includes('IdChaveExterna__c'))
            {
                component.set('v.displayModalErro', true);
                component.set('v.tipoDeErro', tipoErro.replace('Codigo__c', 'Código XP').replace(': []', '').replace('IdChaveExterna__c,', '')); 
            }
            else
            {
                component.set('v.displayModalErro', true);
            }
        }
    },

    realizarConversao : function(component, event, helper) 
    {
        component.set('v.spinner', true);
        helper.converterLead(component, helper);
    },

    closeTab : function(component, event, helper) 
    {
        $A.get("e.c:C3C_FecharGuiaVF").fire();
    }

})
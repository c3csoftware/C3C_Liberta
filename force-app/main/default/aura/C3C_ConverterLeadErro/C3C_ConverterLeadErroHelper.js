({
    converterLead: function (component, helper) {
        try {
            let service = component.find('ConverterLeadService');
            service.setParams({
                idRegistro: component.get('v.idLead')
            });
            service.callServiceMethod('converterLeadComMerge', '', (data) => {
                if (data.status == 'CompletedSuccess') {
                    window.location.href = "/" + data.response;

                    // component.set('v.fecharPagina', true); 
                    // helper.openTab(component, data.response);
                }
                else {
                    for (let error of data.errors) {
                        component.set('v.displayModalErro', false);
                        component.set('v.displayToast', true);
                        component.set('v.erro', 'Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                        console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    }
                }
            });
        }
        catch (e) {
            console.log('erro:', e);
        }
    },

})
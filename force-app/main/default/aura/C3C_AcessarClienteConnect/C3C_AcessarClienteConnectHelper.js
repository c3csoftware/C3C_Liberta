({
    buscarContaPorId: function (component) {
        try {
            let service = component.find('ContaService');
            service.setParams({
                idConta: component.get('v.recordId')
            });
            service.callServiceMethod('obterContaPorId', '', (data) => {
                if (data.status == 'CompletedSuccess') {
                    var codigo = data.response.codigo;
                    if (codigo != null) {
                        var emBase64 = btoa(codigo);
                        var redirectUrl = 'https://hub.xpi.com.br/rede/#/customers/' + emBase64 + '/consolidated-position';
                        window.open(redirectUrl, '_blank');
                    }
                    else
                        this.showToast('error', 'Erro!', 'Esta conta não possui código!');
                }
            });
            $A.get("e.force:closeQuickAction").fire();
        }
        catch (e) {
            console.log('erro:',e);
        }
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
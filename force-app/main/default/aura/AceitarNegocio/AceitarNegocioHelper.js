({
    aceitarLeadFilho : function(component) {
        let idRegistro = component.get('v.recordId');
        var spinner = component.get('v.spinner');
        console.log('Ta sendo chamado da helper?');
        let service = component.find('AceitarLeadFilhoExtension');
        var fecharPopUp = $A.get("e.force:closeQuickAction");

        service.setParams({
            'idRegistro' : idRegistro
        });

        service.callServiceMethod('atribuirNegociosAoUsuario', '',
            (data) => {
                if (data.status == 'CompletedSuccess') {
                    spinner = false;
                    this.showToast('success', 'Sucesso!', 'Você aceitou o negócio com sucesso');
                    fecharPopUp.fire();
                }else {
                    spinner = false;
                    for (let error of data.errors) {
                        this.showToast('error', 'Erro!!', 'Error:' + error.messageLabelOrText);
                        console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    }
                    fecharPopUp.fire();
                }
            })
    },

    showToast: function (type, title, message) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            type,
            title,
            message
        });
        toastEvent.fire();
    },
})
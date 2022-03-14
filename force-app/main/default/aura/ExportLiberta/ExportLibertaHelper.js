({
    exportarDados : function(component) {
        let action = component.get('c.mandarPlanilhaPorEmail');
       
        let emailUsuario = component.get('v.Email');
        let dataInicial = component.get('v.DataInicial');
        let dataFinal = component.get('v.DataFinal');

        action.setParams({
            emailUsuario: emailUsuario,
            dataInicial: dataInicial,
            dataFinal: dataFinal
        });
        action.setCallback(this, function (response) {
            let state = response.getState();
            let returnValue = response.getReturnValue();
            console.log(returnValue);

            if (state == 'SUCCESS') {
                helper.showToast('success', 'Sucesso', 'Email enviado!');
            } else if (state == 'ERROR') {
                helper.showToast('error', 'Error', 'Ocorreu um erro ao tentar enviar o email.');
            }
            component.set('v.spinner', false);
        });

        $A.enqueueAction(action);
    },

    showToast: function (type, title, message) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            type,
            title,
            message
        });
        toastEvent.fire();
    }
})
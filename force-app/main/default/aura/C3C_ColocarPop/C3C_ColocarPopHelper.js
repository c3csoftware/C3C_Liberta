({
	obterPopDaTarefa : function (component) {
        try {
            let service = component.find('BuscarPopTarefaService');
            service.setParams({
                idRegistro: component.get('v.recordId')
            });
            service.callServiceMethod('obterTarefaPorIdComPop', '', (data) => {
                if (data.status == 'CompletedSuccess') {
                	component.set('v.descricaoPop', data.response.descricaoPop);
                }
            });            
        }
        catch (e) {
            console.log('erro:',e);
        }
    },
})
({
	buscarContaPorId: function (component) {
        try {
            let service = component.find('ContaService');
            service.setParams({
                idConta: component.get('v.recordId')
            });
            service.callServiceMethod('obterContaPorId', '', (data) => {
                if (data.status == 'CompletedSuccess') {
                	var classificacaoEstrela = data.response.classificacaoEstrela;
                	var listaEstrela = [];
                
                    for (var i = 1; i <= classificacaoEstrela; i++){
                        listaEstrela.push(i);
                    }
                	component.set('v.classificacaoEstrela', listaEstrela);
                	console.log('classificacaoEstrela:', classificacaoEstrela);
            		console.log('classificacaoEstrela:', listaEstrela);
                }
            });
            
        }
        catch (e) {
            console.log('erro:',e);
        }
    },
})
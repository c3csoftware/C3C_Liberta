({
    criarTarefa : function(component, event, helper)
    {
        let servico = component.find('TaskCallService');

        servico.setParams({
            idTarefa: '',
            assunto: 'Ligação',
            numeroDestino: component.get('v.celularLigacao'),
            redirecionamentoLigacao: JSON.stringify(true)
        });

        servico.callServiceMethod('criarAtualizarTarefaRedirecionamentoLigacao', '', function(data)
        {
            if(data.status == 'CompletedSuccess')
            {
                window.close();
            }
            else if(data.status == 'CompletedError')
            {
                for (let error of data.errors) 
                {
                    this.showToast('error', 'Erro!!', 'Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                }
            }
        });
    }
})
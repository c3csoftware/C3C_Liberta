({
    obterDataAgendamentoTarefa : function(component, helper) 
    {
        let servico = component.find('AgendamentoTarefaService');

        if(!servico)
            return;

        servico.setParams({
            idRegistro: component.get('v.recordId')
        });

        servico.callServiceMethod('obterMonitoramentoAgendamentoTarefa', '', (data) => {
            if(data.status == 'CompletedSuccess') 
            {
                console.log(data.response);
                let listaAgendamentos = [];

                console.log('--------------------------------------------');
                for(let agendamento of data.response.listaAgendamentosTarefaCompromisso)
                {
                    console.log('---'+agendamento.dataAgendamentoFormatado+'---');
                    if(agendamento.dataAgendamentoFormatado != '---')
                    {
                        let dataAgendamento = new Date(agendamento.dataAgendamento);
                        let indexAgendamentos = listaAgendamentos.findIndex(x => new Date(x.dataAgendamento) > dataAgendamento);
                        
                        console.log(dataAgendamento);
                        console.log(indexAgendamentos);

                        if(indexAgendamentos > -1)
                            listaAgendamentos.splice(indexAgendamentos, 0, agendamento);
                        else
                            listaAgendamentos.push(agendamento);
        			}
					else
                    {
                    	listaAgendamentos.push(agendamento);
                    }
                }

                let indexDataAgendamentoAtual = listaAgendamentos.findIndex(x => x.dataAgendamentoFormatado == '---');

                if(indexDataAgendamentoAtual >= 0)
                {
                    listaAgendamentos.unshift(listaAgendamentos[indexDataAgendamentoAtual]);
                    listaAgendamentos.splice(indexDataAgendamentoAtual+1, 1);
                }

                component.set('v.listaDataAgendamentoTarefa', listaAgendamentos);
                component.set('v.numDiasDesdeUltimaTarefa', !data.response.numDiasUltimaTarefa ? 0 : data.response.numDiasUltimaTarefa);

                setTimeout(function(){
                    let element = document.getElementsByClassName('timeline')[0];

                    if(element.scrollWidth > element.clientWidth)
                    {
                        element.classList.add('unCenter');
                    }
                }, 1000);
            }
            else
            {
                for(let error of data.errors)
                {
                    //helper.showToast('error', 'Erro!!', 'Error: '+error.erroCode+', Message: '+error.messageLabelOrText);
                    console.log('Houve um erro na comunicação com o backend. Error: '+error.erroCode+', Message: '+error.messageLabelOrText);
                }

                component.set('v.chamadaComErro', true);
            }

            component.set('v.carregando', false);
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
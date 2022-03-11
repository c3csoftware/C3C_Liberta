({
    //
    // Função responsável por salvar o Evento
    //
    salvarEvento: function (component) {
        let service = component.find('EventService');
        service.setParams({
            idRegistro: component.get('v.recordId'),
            idFila: component.get('v.idFila'),
            dataDeInicio: this.converterData(component.get('v.dataDisponivelSelecionada')),
            horario: component.get('v.horarioSelecionado'),
            duracao: component.get('v.duracaoSelecionado'),
            assunto: component.get('v.assunto'),
            descricao: !!component.get('v.descricao') ? component.get('v.descricao') : '',
        });

        service.callServiceMethod('criarEventoParaUsuarioComMenosEventoNoMes', '',
            (data) => {
                if (data.status == 'CompletedSuccess') {
                    component.set('v.nomeAssessor', data.response.nomeProprietario);
                    component.set('v.idEvento', data.response.idRegistro);
                    component.set('v.idProprietarioEvento', data.response.proprietario);
                    component.set('v.dataConvertida', this.converterData(component.get('v.dataDisponivelSelecionada')));
                    //this.salvarRelacaoDoEvento(component);
                    this.showToast('success', 'Sucesso!!', 'Evento salvo!!');
                }
                else {
                    for (let error of data.errors) {
                        component.set('v.spinner', false);
                        this.showToast('error', 'Erro!!', 'Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                        console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    }
                }
                $A.get('e.force:refreshView').fire();
                component.set('v.spinner', false);
            });
    },

    verificarAssessorIndicado: function (component) {
        let service = component.find('EventService');
        service.setParams({
            idRegistro: component.get('v.recordId')
        });
        service.callServiceMethod('verificarAssessorIndicado', '',
            (data) => {
                if (data.status == 'CompletedSuccess'){
                    console.log('Data Response: ' + data.response);
                    component.set('v.assessorIndicado', data.response);
                }
                else {
                    for (let error of data.errors) {
                        component.set('v.spinner', false);
                        this.showToast('error', 'Erro!!', 'Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                        console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    }
                }
                component.set('v.spinner', false);
        });    
    },

    //
    // Função responsável por salvar o EventRelation
    //
    // salvarRelacaoDoEvento: function (component) {
    //     let service = component.find('EventRelationService');
    //     console.log('idEvento:',component.get('v.idEvento'));
    //     console.log('idProprietarioEvento:',component.get('v.idProprietarioEvento'));
    //     service.setParams({
    //         idEvento: component.get('v.idEvento'),
    //         idRelacao: component.get('v.idProprietarioEvento')
    //     });

    //     service.callServiceMethod('criarRelacaoDoEvento', '',
    //         (data) => {
    //             if (data.status == 'CompletedSuccess') {
    //                 console.log('return:',JSON.stringify(data));
    //                 console.log('EventRelation salvo com sucesso!');
    //             }
    //             else {
    //                 for (let error of data.errors) {
    //                     component.set('v.spinner', false);
    //                     this.showToast('error', 'Erro!!', 'Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
    //                     console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
    //                 }
    //             }
    //             component.set('v.spinner', false);
    //         });
    // },

    //
    //Funções responsaveis por calcular e montar as datas disponíveis de acordo com a agenda dos usuários
    //

    //Responsável por montar a lista de datas e horários disponíveis
    montarListaDeDatasDisponiveis: function (component, event, helper) {
        let datasDisponiveis = [];

        //Convertando data e hora para data, da data de inicio e termino
        let dataDeInicio = this.converterDataEHoraParaData(new Date(component.get('v.dataEHoraMinima')));
        let dataDeTermino = this.converterDataEHoraParaData(new Date(component.get('v.dataEHoraMaxima')));

        datasDisponiveis = this.obterListaDeDatasDoPeriodo(datasDisponiveis, dataDeInicio, dataDeTermino);

        component.set('v.datasDisponiveis', datasDisponiveis);

        this.buscarEventosDosUsuariosDaFila(component, event, helper);
    },
    //Responsável por remover as datas indisponíveis
    removerDataIndisponiveis: function (component, event, helper) {
        let datasDisponiveis = component.get('v.datasDisponiveis');
        let agendaDeUsuarios = component.get('v.agendaDeUsuarios');

        for (let i = 0; i < datasDisponiveis.length; i++) {
            let usuariosDisponiveis = [];
            for (let agendaUsuario of agendaDeUsuarios) {
                let horasDisponiveisDoUsuario = 23;
                if (agendaUsuario.eventos.length == 0) {
                    usuariosDisponiveis.push(agendaUsuario.idUsuario);
                    continue;
                }

                for (let eventoAgenda of agendaUsuario.eventos) {
                    let dataInicio = new Date(eventoAgenda.dataDeInicio);
                    let dataTermino = new Date(eventoAgenda.dataDeTermino);

                    let listaDatasPeriodoIndisponivel = this.obterListaDeDatasDoPeriodo(
                        [],
                        this.converterDataEHoraParaData(dataInicio),
                        this.converterDataEHoraParaData(dataTermino)
                    );

                    if (
                        datasDisponiveis[i].getTime() === this.converterDataEHoraParaData(dataInicio).getTime()
                        &&
                        datasDisponiveis[i].getTime() === this.converterDataEHoraParaData(dataTermino).getTime()
                    ) {
                        horasDisponiveisDoUsuario = this.calcularHorasDisponiveisDatas(horasDisponiveisDoUsuario, dataTermino, dataInicio);
                    } else if (datasDisponiveis[i].getTime() === this.converterDataEHoraParaData(dataInicio).getTime())
                        horasDisponiveisDoUsuario = this.calcularHorasDisponiveisDatas(horasDisponiveisDoUsuario, new Date(dataInicio.getFullYear(), dataInicio.getMonth(), dataInicio.getDate(), 23), dataInicio);
                    else if (datasDisponiveis[i].getTime() === this.converterDataEHoraParaData(dataTermino).getTime())
                        horasDisponiveisDoUsuario = this.calcularHorasDisponiveisDatas(horasDisponiveisDoUsuario, dataTermino, new Date(dataTermino.getFullYear(), dataTermino.getMonth(), dataTermino.getDate(), 0));
                    else {
                        for (let dataPeriodo of listaDatasPeriodoIndisponivel) {
                            if (this.converterDataEHoraParaData(dataInicio).getTime() == dataPeriodo.getTime() || this.converterDataEHoraParaData(dataTermino).getTime() == dataPeriodo.getTime())
                                continue;

                            if (datasDisponiveis[i].getTime() == dataPeriodo.getTime())
                                horasDisponiveisDoUsuario = 0;
                        }
                    }
                }

                if (horasDisponiveisDoUsuario > 0)
                    usuariosDisponiveis.push(agendaUsuario.idUsuario);
            }

            if (usuariosDisponiveis.length == 0)
                datasDisponiveis.splice(i, 1);
        }

        component.set('v.datasDisponiveis', datasDisponiveis);
        this.preencherAtributoParaSelecao(component, event, helper);
    },
    preencherAtributoParaSelecao: function (component, event, helper) {
        let listaDatasDisponiveis = [];

        let datasDisponiveis = component.get('v.datasDisponiveis');

        for (let dataDisponivel of datasDisponiveis) {
            listaDatasDisponiveis.push({ label: this.formatarData(dataDisponivel), value: dataDisponivel });
        }

        component.set('v.listaDatasDisponiveis', listaDatasDisponiveis)
    },
    obterListaDeDatasDoPeriodo: function (listaDatasPeriodo, dataDeInicioPerido, dataDeTerminoTermino) {
        //Criando váriavel de referência para lógica
        let dataDeReferencia = new Date(JSON.parse(JSON.stringify(dataDeInicioPerido)));
        //Adicionar a data de inicio nas datas disponíveis
        listaDatasPeriodo.push(dataDeInicioPerido);
        //Responsável por percorrer todas as datas do período da data de inicio até a data de termino.
        while (dataDeReferencia < dataDeTerminoTermino) {
            //Adicionando mais um dia na data de referência
            let dataDoPeriodo = new Date(JSON.parse(JSON.stringify(this.adicionarDias(dataDeReferencia, 1))));

            //Adicionando uma data nas tadas disponíveis
            listaDatasPeriodo.push(dataDoPeriodo);
        }

        return listaDatasPeriodo;
    },
    //Responsável por buscar os eventos dos usuários da fila que estão marcados dentro do périodo selecionado.
    buscarEventosDosUsuariosDaFila: function (component, event, helper) {
        let service = component.find('CalendarioDeEventosService');
        console.log('TESTEEEEEEE');
        service.setParams({
            idFila: component.get('v.idFila'),
            dataDeInicio: component.get('v.dataEHoraMinima'),
            dataDeTermino: component.get('v.dataEHoraMaxima')
        });

        service.callServiceMethod('obterAgendaDeUsuariosDaFilaDurantePeriodo', '', (data) => {
            if (data.status == 'CompletedSuccess') {
                component.set('v.agendaDeUsuarios', data.response);

                this.removerDataIndisponiveis(component, event, helper);
            }
            else {
                for (let error of data.errors) {
                    this.showToast('error', 'Erro!!', 'Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                }
            }
            component.set('v.spinner', false);
        });
    },

    //
    //Funções responsaveis por calcular e montar os horários disponíveis da data selecionada de acordo com a agenda dos usuários
    //

    montarListaDeHorariosDisponiveis: function (component, event, helper) {
        let dataDisponivelSelecionada = new Date(component.get('v.dataDisponivelSelecionada'));
        let agendaDeUsuarios = component.get('v.agendaDeUsuarios');

        let horariosDisponiveis = [];
        for (let agendaUsuario of agendaDeUsuarios) {
            let horarios = helper.obterHorariosDoDia();

            if (agendaUsuario.eventos.length == 0) {
                horariosDisponiveis = horarios;
                break;
            }

            for (let hora of horarios) {
                let incluirHora = true;
                for (let eventoAgenda of agendaUsuario.eventos) {
                    let dataInicio = new Date(eventoAgenda.dataDeInicio);
                    dataInicio.setHours(dataInicio.getHours() - 1);
                    let dataTermino = new Date(eventoAgenda.dataDeTermino);
                    if (dataDisponivelSelecionada.getTime() === helper.converterDataEHoraParaData(dataInicio).getTime() && dataDisponivelSelecionada.getTime() === helper.converterDataEHoraParaData(dataTermino).getTime()) {
                        if (parseInt(hora.value.split(':')[0]) > dataInicio.getHours() && parseInt(hora.value.split(':')[0]) < dataTermino.getHours()) {
                            incluirHora = false;
                        }
                        else if ((parseInt(hora.value.split(':')[0]) == dataInicio.getHours() && parseInt(hora.value.split(':')[0]) == dataTermino.getHours()) && (parseInt(hora.value.split(':')[1]) >= dataInicio.getMinutes() && parseInt(hora.value.split(':')[1]) <= dataTermino.getMinutes())) {
                            incluirHora = false;
                        }
                        else if ((parseInt(hora.value.split(':')[0]) == dataInicio.getHours() && parseInt(hora.value.split(':')[0]) != dataTermino.getHours()) && parseInt(hora.value.split(':')[1]) >= dataInicio.getMinutes()) {
                            incluirHora = false;
                        }
                        else if ((parseInt(hora.value.split(':')[0]) != dataInicio.getHours() && parseInt(hora.value.split(':')[0]) == dataTermino.getHours()) && parseInt(hora.value.split(':')[1]) <= dataTermino.getMinutes()) {
                            incluirHora = false;
                        }
                    }
                    else {
                        if (dataDisponivelSelecionada.getTime() === helper.converterDataEHoraParaData(dataInicio).getTime()) {
                            if (parseInt(hora.value.split(':')[0]) > dataInicio.getHours()) {
                                incluirHora = false;
                            }
                            else if (parseInt(hora.value.split(':')[0]) == dataInicio.getHours() && parseInt(hora.value.split(':')[1]) >= dataInicio.getMinutes()) {
                                incluirHora = false;
                            }
                        }
                        if (dataDisponivelSelecionada.getTime() === helper.converterDataEHoraParaData(dataTermino).getTime()) {
                            if (parseInt(hora.value.split(':')[0]) < dataTermino.getHours()) {
                                incluirHora = false;
                            }
                            else if (parseInt(hora.value.split(':')[0]) == dataTermino.getHours() && parseInt(hora.value.split(':')[1]) <= dataTermino.getMinutes()) {
                                incluirHora = false;
                            }
                        }
                    }
                }
                if (incluirHora)
                    horariosDisponiveis = helper.adicionarItemNoArraySemDuplicar(horariosDisponiveis, hora);
            }
        }

        component.set('v.horariosDisponiveis', horariosDisponiveis);
    },

    //
    //Funções que controlam a etapa que a tela está
    //

    definirProximoPasso: function (component, helper, acao) {
        let passo = component.get('v.passo');
        let novoPasso = passo;

        switch (passo) {
            case 'definirPeriodo':
                if (acao == 'proximoPasso')
                    novoPasso = 'mostrarDatasHorariosDisponiveis';
                break;
            case 'mostrarDatasHorariosDisponiveis':
                if (acao == 'passoAnterior')
                    novoPasso = 'definirPeriodo';
                if (acao == 'proximoPasso')
                    novoPasso = 'salvarEvento';
                break;
        }

        component.set('v.passo', novoPasso);
        this.irParaProximoPasso(component, helper, novoPasso);
    },
    irParaProximoPasso: function (component, helper, proximoPasso) {
        switch (proximoPasso) {
            case 'mostrarDatasHorariosDisponiveis':
                helper.montarListaDeDatasDisponiveis(component, null, helper);
                break;
            case 'definirPeriodo':
                this.limparAtributosParaPassoDefinirPeriodo(component);
                break;
            case 'salvarEvento':
                this.salvarEvento(component);
                break;
        }
    },

    //
    //Funções auxiliares
    //
    limparAtributosParaPassoDefinirPeriodo: function (component) {
        component.set('v.datasDisponiveis', null);
        component.set('v.duracaoSelecionado', null);
        component.set('v.assunto', 'Qualificação do Assessor');
        component.set('v.descricao', '');
        component.set('v.listaDatasDisponiveis', null);
        component.set('v.horariosDisponiveis', null);
        component.set('v.dataDisponivelSelecionada', null);
        component.set('v.horarioSelecionado', null);
        component.set('v.idFila', null);
        component.set('v.dataEHoraMinima', null);
        component.set('v.dataEHoraMaxima', null);
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
    converterDataEHoraParaData: function (dataEHora) {
        let dia = dataEHora.getDate();
        let mes = dataEHora.getMonth();
        let ano = dataEHora.getFullYear();

        return new Date(ano, mes, dia);
    },
    adicionarDias: function (data, quantidadeDeDias) {
        data.setDate(data.getDate() + quantidadeDeDias);
        return data;
    },
    formatarData: function (data) {
        let dia = data.getDate();
        let mes = data.getMonth() + 1;
        let ano = data.getFullYear();

        return (dia < 10 ? '0' + dia : dia) + '/' + (mes < 10 ? '0' + mes : mes) + '/' + ano;
    },
    calcularHorasDisponiveisDatas: function (horasDisponiveis, dataFutura, data) {
        let diferencaEmMiliSegundos = Math.abs(dataFutura - data) / 1000;
        let diferencaEmHoras = Math.floor(diferencaEmMiliSegundos / 3600) % 24;

        if (horasDisponiveis - diferencaEmHoras >= 0)
            horasDisponiveis -= diferencaEmHoras;
        else
            horasDisponiveis = 0;

        return horasDisponiveis;
    },
    obterHorariosDoDia: function () {
        let horarios = [];

        for (let h = 0; h < 24; h++) {
            let hora = h < 10 ? '0' + h : h;

            for (let m = 0; m < 60; m++) {
                let minuto = m < 10 ? '0' + m : m;
                let horario = hora + ':' + minuto;

                horarios.push({ label: horario, value: horario });
            }
        }

        return horarios;
    },
    adicionarItemNoArraySemDuplicar: function (array, item) {
        if (!array.includes(item))
            array.push(item);

        return array;
    },
    converterData: function (dataParaConverter) {
        var date = new Date(dataParaConverter),
            mnth = ("0" + (date.getMonth() + 1)).slice(-2),
            day = ("0" + date.getDate()).slice(-2);

        return [day, mnth, date.getFullYear()].join("/");
    },

    verificarSePopEstaPreenchido: function (component) {
        let recordId = component.get('v.recordId');
        let service = component.find('TaskService');
        var eventoFechar = $A.get("e.force:closeQuickAction");

        service.setParams({
            idRelativo: recordId
        });

        service.callServiceMethod('verificarSeTarefaRelacionadaEstaPreenchida', '',
            (data) => {
                
                if (data.status == 'CompletedSuccess') {

                }
                else {
                    for (let error of data.errors) {
                        component.set('v.spinner', false);
                        this.showToast('error', 'Erro!!', error.messageLabelOrText);
                        console.log('Houve um erro na comunicação com o backend. Error: ' + error.erroCode + ', Message: ' + error.messageLabelOrText);
                    }

                    eventoFechar.fire();
                }

                // $A.get('e.force:refreshView').fire();
                component.set('v.spinner', false);
            });
    }
})
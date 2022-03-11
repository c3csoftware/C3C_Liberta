({
    //Função chamada quando seleciono uma fila
    manipulandoIdFila: function (component, event, helper) {
        //Armazenando id da fila em um atributo do componente
        component.set('v.idFila', event.getParam('recordId'));
    },
    //Função chamada quando quero montar a lista de datas e horários disponíveis
    proximoPasso: function (component, event, helper) {
        component.set('v.spinner', true);
        helper.definirProximoPasso(component, helper, 'proximoPasso');
    },
    //Função chamada quando quero voltar para a tela anterior
    passoAnterior: function (component, event, helper) {
        helper.definirProximoPasso(component, helper, 'passoAnterior');
    },
    //Função chama quando seleciona uma data disponível
    definirHorariosDisponiveis: function (component, event, helper) {
        component.set('v.spinner', true);

        window.setTimeout(
            $A.getCallback(function () {
                new Promise(resolve => {
                    helper.montarListaDeHorariosDisponiveis(component, event, helper);
                    component.set('v.spinner', false);
                });
            }), 1000
        );
    },
    //Função para limpar o atributo assunto
    limparAssunto: function (component, event, helper) {
        component.set('v.assunto', 'Qualificação do Assessor');
    },
    //Função para fechar guia
    fecharGuia: function (component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    },
})
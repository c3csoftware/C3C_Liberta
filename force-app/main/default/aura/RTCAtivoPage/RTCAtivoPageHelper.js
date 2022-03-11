({
    randomNumber : function(max) 
    {
        return Math.floor(Math.random() * max);
    },
    observarEventoRedirecionamentoChamada : function(component, event, helper)
    {
        const empApi = component.find('empApi');
        const channel = '/topic/TarefaRedirecLigacaoEvent';
        const replayId = -1;

        var utilityAPI = component.find("utilitybar");

        empApi.subscribe(channel, replayId, $A.getCallback(eventReceived => {
            if(component.get('v.focadoNaGuia'))
            {
                utilityAPI.openUtility();
                component.set('v.parametrosURL', '&ligar=true&ramal='+eventReceived.data.sobject.RamalRedirecionamentoLigacao__c+'&numerocelular='+eventReceived.data.sobject.CallObject+'&idregistro='+eventReceived.data.sobject.Id);
            }
            else
                utilityAPI.minimizeUtility();
        }))
        .then(subscription => {
            console.log('Subscription request sent to: ', subscription.channel);
        });
    },
    observarFocoNaTela : function(component, event, helper)
    {
        window.addEventListener('focus', function (event) {
            component.set('v.focadoNaGuia', true);
        });

        window.addEventListener('blur', function (event) {
            component.set('v.focadoNaGuia', false);
        });
    }
})
({
    fecharToast : function(component, event, helper) {
        component.set('v.visivel', false);
    },
    mostrarToast : function(component, event, helper)
    {
        let params = event.getParam('arguments');

        component.set('v.visivel', true);
        component.set('v.messagem', params.messagem);
        component.set('v.tipo', params.tipo);
    },
    manipularVisualizacaoToast : function(component, event, helper)
    {
        if(component.get('v.visivel'))
        {
            setTimeout(function(){
                component.set('v.visivel', false);
            }, 5000);
        }
    }
})
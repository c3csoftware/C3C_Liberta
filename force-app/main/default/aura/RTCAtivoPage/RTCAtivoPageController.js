({
    doInit : function(component, event, helper)
    {
        let urlArray = window.location.href.split('/');
        let identificacaoGuia = '';

        for(let i = 3; i < urlArray.length; i++)
        {
            identificacaoGuia += '/'+urlArray[i];
        }

        component.set('v.identificacaoGuia', identificacaoGuia + '-' + Date.now());
        helper.observarEventoRedirecionamentoChamada(component, event, helper);
    },
    paginaCarregada : function(component, event, helper) 
    {
        component.set('v.carregandoPagina', false);
    },
    ligarPaginaDetalhes : function(component, event, helper)
    {
        console.log('ALOWW');
        console.log(event.getParam('acao'));
        console.log(JSON.stringify(event.getParam('parametros')));
        switch(event.getParam('acao'))
        {
            case 'LigarPaginaDetalhes':
                let parametros = event.getParam('parametros');

                component.set('v.parametrosURL', '&ligar=true&ramalAtual=true&numerocelular='+parametros.telefone+'&registrorelacionado='+parametros.registroRelacionado);
                break;
        }
    }
})
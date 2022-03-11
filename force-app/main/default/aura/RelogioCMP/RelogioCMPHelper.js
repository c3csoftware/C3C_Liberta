({
    //Responsável por fazer o relogio funcionar
    ponteiroRelogio : function(component, event, helper)
    {
        window.setTimeout(function(){
            let hora = component.get('v.hora');
            let minuto = component.get('v.minuto');
            let segundo = component.get('v.segundo');

            segundo += 1;

            if(segundo == 60)
            {
                segundo = 0;
                minuto += 1;
            }

            if(minuto == 60)
            {
                minuto = 0;
                hora += 1;
            }

            component.set('v.hora', hora);
            component.set('v.minuto', minuto);
            component.set('v.segundo', segundo);

            helper.formatarTempo(component, event, helper);
            helper.ponteiroRelogio(component, event, helper);
        }, 1000);
    },
    //Responsável por zerar o relogio
    zerarRelogio : function(component, event, helper) 
    {
        component.set('v.hora', 0);
        component.set('v.minuto', 0);
        component.set('v.segundo', 0);

        helper.formatarTempo(component, event, helper);
    },
    //Responsável por formatar o relogio
    formatarTempo : function(component, event, helper)
    {
        let hora = component.get('v.hora');
        let minuto = component.get('v.minuto');
        let segundo = component.get('v.segundo');

        let horaFormatada = hora < 10 ? '0'+hora : hora;
        let minutoFormatado = minuto < 10 ? '0'+minuto : minuto;
        let segundoFormatado = segundo < 10 ? '0'+segundo : segundo;

        component.set('v.horaFormatada', horaFormatada);
        component.set('v.minutoFormatado', minutoFormatado);
        component.set('v.segundoFormatado', segundoFormatado);
    }
})
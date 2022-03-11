({
    doInit : function(component, event, helper) 
    {
        let conjuntoDeTeclas = [];
        let teclas = [];

        for(let i = 1; i <= 9; i++)
        {
            teclas.push({rotulo: i, valor: i});
            if(i%3 == 0)
            {
                conjuntoDeTeclas.push(teclas);
                teclas = [];
            }  
        }

        component.set('v.conjuntoTeclas', conjuntoDeTeclas);
    },
    precionarTecla : function(component, event, helper)
    {
        let tecla = event.currentTarget.dataset.value;

        let evento = component.getEvent('pressionarTeclaEvent');

        evento.setParams({
            tecla
        });

        evento.fire();
    }
})
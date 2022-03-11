({
    init : function(component, event, helper) {
        component.set('v.mesesAno', helper.getMesesObj(component));
        component.set('v.sizeCalendar', 12);
        helper.doInit(component,event,helper);
    },
    selectDia : function(component, event, helper){
        helper.select(component, event, helper);
    },
    onChangeMes : function(component, event, helper){
        component.set('v.mes', parseInt(event.currentTarget.value));
        component.set('v.mesExtenso', helper.getMeses()[event.currentTarget.value]);
        
        var evento = component.getEvent('selectDataCalendario');
        evento.setParams({
            data: {
                mes: parseInt(component.get('v.mes')),
                ano: parseInt(component.get('v.ano'))
            }
        });
        evento.fire();
    },
    onChangeAno : function(component, event, helper){
        component.set('v.ano', event.currentTarget.value);
        
        var evento = component.getEvent('selectDataCalendario');
        evento.setParams({
            data: {
                mes: parseInt(component.get('v.mes')),
                ano: parseInt(component.get('v.ano'))
            }
        });
        evento.fire();
    },
    blurDia : function(component,event,helper){
        event.currentTarget.setAttribute('class','');
    }
})
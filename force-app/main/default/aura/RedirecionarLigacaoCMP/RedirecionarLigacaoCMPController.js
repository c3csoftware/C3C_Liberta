({
    doInit : function(component, event, helper) {
        let urlParams = new URL(window.location.href);

        component.set('v.idRegistroLigacao', urlParams.searchParams.get('idRegistroLigacao'));
        component.set('v.nomeObjeto', urlParams.searchParams.get('nomeObjeto'));
        component.set('v.celularLigacao', urlParams.searchParams.get('celularLigacao'));
    }
})
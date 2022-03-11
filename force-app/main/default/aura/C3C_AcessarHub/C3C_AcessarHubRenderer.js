({
    afterRender: function (component, helper) 
    {
        this.superAfterRender();
        
        helper.buscarContaPorId(component);
    },
})
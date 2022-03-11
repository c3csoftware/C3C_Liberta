({
    afterRender: function (component, helper) 
    {
        this.superAfterRender();
        
        helper.obterPopDaTarefa(component);
    },
})
({
    afterRender : function(component, helper)
    {
        this.superAfterRender();

        helper.criarTarefa(component, null, helper);
    }
})
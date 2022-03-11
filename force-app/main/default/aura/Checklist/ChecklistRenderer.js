({
    afterRender : function(component, helper)
    {
        this.superAfterRender();

        helper.obterChecklist(component, helper);
    }
})
({
    afterRender : function(component, helper)
    {
        this.superAfterRender();

        helper.observarFocoNaTela(component, null, helper);
    }
})
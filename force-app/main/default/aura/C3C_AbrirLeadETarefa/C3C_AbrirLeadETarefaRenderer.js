({
    afterRender: function (component, helper) 
    {
        this.superAfterRender();
        helper.buscarLeadFilho(component, helper);
    },
})
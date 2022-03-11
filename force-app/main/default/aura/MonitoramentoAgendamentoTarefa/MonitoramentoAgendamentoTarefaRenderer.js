({
    afterRender : function(component, helper)
    {
        this.superAfterRender();

        helper.obterDataAgendamentoTarefa(component, helper);
    }
})
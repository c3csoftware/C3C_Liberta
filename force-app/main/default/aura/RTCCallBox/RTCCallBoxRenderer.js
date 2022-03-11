({
    afterRender : function(component, helper)
    {
        //Chamando função super do after render
        this.superAfterRender();
        
        //Buscar informações de login do callbox
        helper.obterInformacoesLogin(component, helper);

        //

        //Adicionar Observadores
        helper.observarEventosCallbox(component, null, helper);
        helper.observarStatusRamal(component, helper);
        helper.observarStatusChamada(component, helper);
    }
})
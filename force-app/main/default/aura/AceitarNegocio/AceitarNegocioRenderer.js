({

// Your renderer method overrides go here
    afterRender : function(component, helper) {
        this.superAfterRender();

        console.log('Entrou no afterRender');
        
        helper.aceitarLeadFilho(component);
    }
})
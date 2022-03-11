({

// Your renderer method overrides go here
    afterRender : function(component, helper) {
        this.superAfterRender();

        helper.verificarAssessorIndicado(component);
        helper.verificarSePopEstaPreenchido(component);
    }

})
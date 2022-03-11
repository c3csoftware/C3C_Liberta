({
    handleSuccess: function(component, event, helper) {
        var record = event.getParam("response");
        
        helper.showToast('Lead Criado com sucesso', 'Lead '+record.Name+' foi criado.', 'success');
        
        var navLink = component.find("navLink");
        var pageRef = {
            type: 'standard__recordPage',
            attributes: {
                actionName: 'view',
                objectApiName: 'Case',
                recordId : record.id
            },
        };
        navLink.navigate(pageRef, true);
    },
	handleClose : function(component, event, helper) {
		window.location.href = '/lightning/o/Lead/list?filterName=Recent';
	}
})
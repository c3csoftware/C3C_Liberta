({
	afterRender: function (component, helper) 
    {
        this.superAfterRender();
        
        window.open('https://liberta--dev.lightning.force.com/', '_self');
        
    },
})
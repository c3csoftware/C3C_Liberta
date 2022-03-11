({
	showToast: function(title, message, type) 
	{
        $A.get("e.force:showToast")
        .setParams({
            title,
            message,
            type
        }).fire();
    }
})
({
    doInit : function(component, event, helper)
    {
        let options = component.get('v.options');
        let valueSelected = component.get('v.valueSelected')

        if(options == undefined || options == null || valueSelected == undefined || valueSelected == null)
            return;
        
        for(let option of options)
        {
            if(valueSelected.trim().toLowerCase() == option.value.trim().toLowerCase())
				component.set('v.valueSelected', option.value);
        }
    },
	onChange : function(component, event, helper) 
    {
        let valueSelected = component.find('selectDropdown').get('v.value');
        component.set('v.valueSelected', valueSelected);
        
        let evento = component.getEvent('changeSelectDropDown');

        evento.fire();
	}
})
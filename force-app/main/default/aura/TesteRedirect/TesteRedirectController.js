({
    doInit: function (component, event, helper) {
        let id = component.get('v.recordId');
        console.log('id', id);
        window.open('https://www.google.com/','_blank');
        $A.get("e.force:closeQuickAction").fire();
    }
})
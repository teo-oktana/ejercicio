({
		getContacts : function(component, event, helper) {
        var accid = component.get("v.accid");
        var action = component.get("c.getContacts");
        action.setParams({
            "accId" : accid
        })
        action.setCallback(this, function(response) {
            var state = response.getState();
            switch(state) {
                case "SUCCESS":
                    var availableContacts = response.getReturnValue();
                    component.set("v.contacts", availableContacts);
                    break;
                    
                case "INCOMPLETE":
                    console.log('Incomplete');
                    break;
                    
                case "ERROR":
                    console.log(response.getError());
                    break;
            }
        });
        $A.enqueueAction(action);  
    },
})
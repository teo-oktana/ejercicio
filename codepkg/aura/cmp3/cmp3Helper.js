({
	getAllAccounts : function(component, event, helper) {
        var accName = component.get("v.accountString");
        var action = component.get("c.getAccounts");
        action.setParams({
            "accName" : accName
        })
        action.setCallback(this, function(response) {
            var state = response.getState();
            switch(state) {
                case "SUCCESS":
                    var availableAccounts = response.getReturnValue();
                    component.set("v.accounts", availableAccounts);
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
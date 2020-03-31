({
	init : function(component, event, helper) {
		helper.getAllAccounts(component, event, helper);
	},
    
    doSearch : function(component, event, helper) {
        console.log("estoy en doSearch");
        var params = event.getParam('arguments');
        if (params) {
            component.set("v.accountString", params.accountString);
            console.log("los params son " + params);
	        helper.getAllAccounts(component, event, helper);
        }
    },
})
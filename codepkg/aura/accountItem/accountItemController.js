({
	searchContact : function(component, event, helper) {
        var params = {"accountid" : component.get("v.account.Id")};
        var cEvent = component.getEvent("contactlist");
	    cEvent.setParams(params);
        cEvent.fire();
	},
})
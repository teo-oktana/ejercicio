({
    onSearchSubmit : function(component, event, helper) {
      	console.log("search string is "+component.get("v.accountString"));
        
        //var search = component.find("searchform");
		//console.log("search var is "+ search);
        var params = {"accountString": component.get("v.accountString") };

        var form = component.getEvent("accountsearch");
        form.setParams(params);
        form.fire();  
    },
})
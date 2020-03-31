({
	doSearch : function(component, event, helper) {
        console.log("estoy en doSearch de cmp4");
        var params = event.getParam('arguments');
        
        if (params) {
            component.set("v.accid", params.accid);
            //console.log("params do search cmp4 1-accoundid o 2 accid");
            //console.log("1- " + params.accountid);
            //console.log("2- " + params.accid);
	        helper.getContacts(component, event, helper); 
        }
    },
})
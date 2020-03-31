({
	onContactSelected : function(component, event, helper) {
		
        var params = {"thecontact": component.get("v.contact") };
        console.log("v.contact "+ component.get("v.contact.Name"));
		console.log("estoy en contactitemcontroller y el param es "+ params);
        var form = $A.get("e.c:ContactSelected");
        form.setParams(params);
        form.fire();
	}
})
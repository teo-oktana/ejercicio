({
	onContactSelected : function(component, event, helper) {
		var contact = event.getParam("thecontact");
        console.log("estoy en contactdetailscontroller y contact es " + contact);
        component.set("v.contact", contact);
	}
})
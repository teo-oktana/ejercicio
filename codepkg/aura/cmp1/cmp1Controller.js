({
	onSearchSubmit : function(component, event, helper) {
        var params = event.getParam("accountString");
        console.log("onSearchsubmit params es "+ params)
        var searchResult = component.find("mysearch");
        if(searchResult) {
            searchResult.search(params);
            var account2pass = component.find("mycontacts");
            if(account2pass) {
                account2pass.search();
            }
        }
	},
    
    onContactList : function(component, event, helper) {
        var params = event.getParam("accountid");
        console.log("cmp1controller params "+params);
        var account2pass = component.find("mycontacts");
        if(account2pass) {
      		account2pass.search(params);      
        }
    }, 
    
})
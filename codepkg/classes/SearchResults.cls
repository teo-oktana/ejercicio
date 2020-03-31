public with sharing class SearchResults {

    @AuraEnabled
    public static List<Account> getAccounts(String accName) {
        if(accName == null || accName == '') {
			return [select Name from Account];
        }
        else {
			String accountName = '%'+accName+'%';
 	    	return [select Name from Account where Name like :accountName];    
        }
    }
    
    //@AuraEnabled
    //public static List<Account> getAccountsWhere (String accName) {
    //    String accountName = '%'+accName+'%';
    //    return [select Name from Account where Name like :accountName];
    //}
    
    @AuraEnabled
    public static List<Contact> getContacts(String accId) {
        return [select Id, Name, Phone, Account.Name, Email, Title from Contact where accountId =: accId];
    }
}
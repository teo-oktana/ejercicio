trigger sameName on Work_Item__c (before insert) {
	
    if(Trigger.isBefore){
    	Helpers.SameNameInWi(Trigger.New);  
    }
}
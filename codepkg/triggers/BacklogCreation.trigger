trigger BacklogCreation on Project__c (after insert) {
	
	Helpers.BacklogGenerator();
}
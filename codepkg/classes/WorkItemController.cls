public class WorkItemController {
	
    // combobox
    String status;
    public PageReference processRequest() {
        
        return null;
    }
    public List<SelectOption> getItems(){
        List<SelectOption> options = new List<SelectOption>();
        
        options.add(new SelectOption('NOT STARTED','Not Started'));
        options.add(new SelectOption('IN PROGRESS','In Progress'));
        options.add(new SelectOption('DONE','Done'));
        
        return options;
    }
    public String getStatus(){
        
        return status;
    }
    public void setStatus(String status){
        this.status = status;
    }
    
    private final Work_Item__c wi;
    
    public WorkItemController(ApexPages.StandardController stdController){
        stdController.addFields(new List<String>{'Story_Points__c','Sprint__r.Project__r.Id', 'Status__c'});        
        this.wi = (Work_Item__c)stdController.getRecord();
        system.debug(wi);
    }
    
    public List<Work_Item__c> getWorkItems(){
    	system.debug('el wi dentro del metodo '+wi.Story_Points__c);
        List<Work_Item__c> results = New List<Work_Item__c>();
        for(Work_Item__c w : [SELECT Id,Name FROM Work_Item__c WHERE Story_Points__c = :wi.Story_Points__c
                             AND Sprint__r.Project__r.Id = :wi.Sprint__r.Project__r.Id AND Status__c = :status]){
            results.add(w);
        }
    	return results;
    }   
}
public class Helpers {
	
    // Cuando se crea un proyecto se cree (programáticamente) un record de sprint con nombre “Backlog”
    public static void BacklogGenerator(){
        
        List<Sprint__c> sprintList = new List<Sprint__c>();
    	
    	// por que no dml exception si estoy agregando a lista dentro de loop
    	// y luego hago el insert fuera del loop?
    
    	for(Project__c a : [SELECT Id,Start_Date__c,End_Date__c FROM Project__c WHERE Id IN :Trigger.New]){  
	    	if(a.End_Date__c == null){
        		sprintList.add(new Sprint__c(Name='Backlog', 
                                    Start_Date__c = a.Start_Date__c,
                                    End_Date__c = a.Start_Date__c + 30,
                                    Project__c = a.Id));
        	} else {
        		sprintList.add(new Sprint__c(Name='Backlog', 
                                    Start_Date__c = a.Start_Date__c,
                                    End_Date__c = a.End_Date__c,
                                    Project__c = a.Id));
        	}
   		}
    	if(!sprintList.isEmpty()){
    		insert sprintList;
    	}
	}
    
    // No permitir que se creen dos Work Items con el mismo Título dentro de un proyecto
    public static void SameNameInWi(List<Work_Item__c> myTrigger){
        Work_Item__c miwi = myTrigger.get(0);
        
        //List<Work_Item__c> wiId = new List<Work_Item__c>([SELECT Id,Name,Sprint__c FROM Work_Item__c WHERE Sprint__c = :miwi.Sprint__c]);
        
        List<Sprint__c> sprintId = new List<Sprint__c>([SELECT Id,Project__c from Sprint__c where id = :miwi.Sprint__c]); //obtengo sprint con ID de trigger
        Id referenceProject = sprintId.get(0).Project__c; //obtengo project relacionado
        
        //system.debug('mi lista de wi es '+wiId);
        system.debug('mi lista de sprint es '+ sprintId+ 'and reference project ' +referenceProject);
        
        
        //System.debug('hola estoy en 1 '+ miwi.Sprint__c);
        //System.debug('hola estoy en 2 '+ miwi.Sprint__r.Project__r.Id); // Respuesta NULL
        
        List<Work_Item__c> currentWI = new List<Work_Item__c>([SELECT Id,Name,Sprint__r.Project__r.Id FROM Work_Item__c 
                           WHERE Sprint__r.Project__r.Id = :referenceProject ]);
	    
        System.debug('mi currentWI list ay cucu '+ currentWI);
        
        List<Integer> potentialAdd = new List<Integer>();
        
        system.debug(myTrigger);
     
        // Recorro trigger para verificar que no contenga duplicados en si mismo
        // Si los tiene, agrego error. Si no tiene, agrego indice a lista de referencia
        // (por ahora esto no tiene sentido porque trigger me trae solo un dato)
        for(Integer i=0; i<myTrigger.size(); i++){
            Integer count = 0;
            for(Integer j=0; j<myTrigger.size() && j!=i && count==0; j++){
                if(myTrigger.get(i).Name == myTrigger.get(j).Name){
                    count++;
                    myTrigger.get(i).addError('Record '+ myTrigger.get(i).Name +' cannot be inserted, duplicated in the Batch');
                }
            }
            if (count == 0){
                potentialAdd.add(i);
            }
        }
        // recorro Trigger y comparo con current Records.
        // si existe record, y no hubo mensaje de error previo, doy mensaje de error por este
        for(Integer i=0; i<myTrigger.size(); i++){
            Boolean alreadyThere = False;
            for(Integer j=0; j<currentWI.size() && !alreadyThere; j++){
                if(myTrigger.get(i).Name == currentWI.get(j).Name){
                    alreadyThere = True;
                    if(potentialAdd.contains(i)){
                    	myTrigger.get(i).addError('Record '+ myTrigger.get(i).Name +' cannot be insert. Duplicate in current record');
                    }
                }
            }
        }
        /*
        Set<Id> projectId = new Set<Id>();
        for (Work_Item__c wi : myTrigger){
            projectId.add(wi.Sprint__c);
        }
        Map<Id,Project__c> projectMap = new Map<Id,Project__c>([SELECT Id,Name from Project__c WHERE Id IN :projectId]);
        for(Work_Item__c wi : myTrigger){
            Project__c relatedProject = projectMap.get(wi.Sprint__c);
        }
        
        // a ver que sale
        Work_Item__c miWI = myTrigger.get(0);
        List<Work_Item__c> currentWI = new List<Work_Item__c>([SELECT Id,Name,Sprint__r.Project__r.Id FROM Work_Item__c 
                           WHERE Sprint__r.Project__r.Id = :myTrigger.get(0).Sprint__r.Project__r.Id ]);
	
        List<Integer> potentialAdd = new List<Integer>();
        
        system.debug(myTrigger);
        system.debug(myTrigger.get(0));
        //System.debug([SELECT Sprint__r.Project__r.Id FROM Work_Item__c]);
     
        // Recorro trigger para verificar que no contenga duplicados en si mismo
        // Si los tiene, agrego error. Si no tiene, agrego indice a lista de referencia
        for(Integer i=0; i<myTrigger.size(); i++){
            Integer count = 0;
            for(Integer j=0; j<myTrigger.size() && j!=i && count==0; j++){
                if(myTrigger.get(i).Name == myTrigger.get(j).Name){
                    count++;
                    myTrigger.get(i).addError('Record '+ myTrigger.get(i).Name +' cannot be inserted, duplicated in the batch');
                }
            }
            if (count == 0){
                potentialAdd.add(i);
            }
        }
        // recorro Trigger y comparo con current Records.
        // si existe record, y no hubo mensaje de error previo, doy mensaje de error por este
        for(Integer i=0; i<myTrigger.size(); i++){
            Boolean alreadyThere = False;
            for(Integer j=0; j<currentWI.size() && !alreadyThere; j++){
                if(myTrigger.get(i).Name == currentWI.get(j).Name){
                    alreadyThere = True;
                    if(potentialAdd.contains(i)){
                    	myTrigger.get(i).addError('Record '+ myTrigger.get(i).Name +' cannot be inserted due to duplicated in current record');
                    }
                }
            }
        }*/
    
    }  
}
public with Sharing class ObjectTriggerHandlerforStuentCollege 
{
	private boolean m_isExecuting = false;
    private Integer batchSize = 0;
    
    public ObjectTriggerHandlerforStuentCollege(boolean isExecuting, Integer size)
    {
        m_isExecuting = isExecuting;
        batchSize = size;
    }

	Set<Id> sId = new Set<Id>();    
    public void onAfterInsert(List<Student__c> sList)
    {
		for(Student__c stud : sList)
           sId.add(stud.College__c);
    
        List<College__c> colgList = [select id, Number_of_Students__c from College__c where id in :sId];
        List<Student__c> studList = [select id from Student__c where College__c in :sId];
        
        for(College__c colg : colgList)
        {
            colg.Number_of_Students__c = studList.size();
        }
        update colgList;
    }
    
   
    public void onAfterDelete(List<Student__c> sList)
    {
        for(Student__c stud : sList)
           sId.add(stud.College__c);
    
        List<College__c> colgList = [select id, Number_of_Students__c from College__c where id in :sId];
        List<Student__c> studList = [select id from Student__c where College__c in :sId];
        
        for(College__c colg : colgList)
        {
            colg.Number_of_Students__c = studList.size();
        }
        update colgList;
    }
    
    public void onAfterUndelete(List<Student__c> sList)
    {
        for(Student__c stud : sList)
        {
           sId.add(stud.College__c);
        }
    
        List<College__c> colgList = [select id, Number_of_Students__c from College__c where id in :sId];
        List<Student__c> studList = [select id from Student__c where College__c in :sId];
        
        for(College__c colg : colgList)
        {
            colg.Number_of_Students__c = studList.size();
        }
        update colgList;
    }
    
     public void onAfterUpdate(List<Student__c> sOld, List<Student__c> sNew, Map<Id,Student__c> sMap)
    {
        Set<Id> oldColgId = new Set<Id>();
        
        for(Student__c s : sNew)
        {
            if(s.College__c != sMap.get(s.id).College__C)           
                sId.add(s.College__c);
                oldColgId.add(sMap.get(s.id).College__c);            
        }
        
         if(!sId.isEmpty())
         {
            //for new Colleges
            List<College__c> newColg = [select id, Number_of_Students__c from College__c where id in :sId];
            //For New Students in College
            List<Student__c> newStud = [select id from Student__c where College__c in :sId];
             
            // This is for old student count
            	// for old colleges          
             List<College__c> oldColg = [select id, Number_of_Students__c from College__c where id in :oldColgId];
             
             //for old college students
             sOld = [select id from Student__c where College__c in :oldColgId];
             
             //For New Colleges
            for(College__c colg : newColg)
            {
                colg.Number_of_Students__c = newStud.size();
      		}update newColg;
          	
             //For Old Colleges
             for(College__c colg : oldColg)
            {
                colg.Number_of_Students__c = sOld.size();
      		}update oldColg;
  		}    
	}
    
}
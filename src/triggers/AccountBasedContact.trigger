trigger AccountBasedContact on Case (after insert, after update) 
{
    Set<Id> contactSet = new Set<Id>();
       
    for (Case c: trigger.new)
    {
        contactSet.add(c.contactId);             
    }
                      
     Map<Id, Contact> contactMap = new Map<Id, Contact>([SELECT Id, AccountId FROM Contact where Id in :contactSet]);
     system.debug('Contact map is: ' + contactMap );    
           
    List<Case> caseList = ([select id, accountId, contactid from case where contactid in :contactSet]);
    List<Case> updateCaseList = new List<Case>();
    
    system.debug('case list is: ' + caseList);
    for (Case c: caseList)
    {    
        Contact relatedAccount = contactMap.get(c.contactid);    
        c.accountId = relatedAccount.AccountId;  
        
        updateCaseList.add(c);
    }
          
    for (Case rec: caseList)
    {
        if(checkRecursive.runOnce())
        {
            upsert updateCaseList;
        }
    } 
}
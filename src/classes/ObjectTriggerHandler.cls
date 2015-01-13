public with sharing class ObjectTriggerHandler {
  private boolean m_isExecuting = false;
  private Integer batchSize = 0;
  
  public ObjectTriggerHandler(boolean isExecuting, Integer size) {
    m_isExecuting = isExecuting;
    batchSize = size;
  }
  
  Set<Id> aId = new Set<Id>();
  
  public void OnAfterInsert(List<Contact>  opp) {    
       for(Contact c : opp){
            aId.add(c.AccountId);
        }

        List<Account> acc = [select id,Number_Of_Contacts__c from Account where Id in:aId];
        List<Contact> con = [select id from contact where AccountId in :aId];
        
        for(Account a : acc){
            a.Number_Of_Contacts__c=con.size();
            
        }update acc;
  }
  

  public void OnAfterDelete(List<Contact>  opp) { 
       for(Contact c : opp){
            aId.add(c.AccountId);
        }
       
        List<Account> acc = [select id,Number_Of_Contacts__c from Account where Id in:aId];
        List<Contact> con = [select id from contact where AccountId in :aId];
        
        for(Account a : acc){
            a.Number_Of_Contacts__c=con.size();
            
        }update acc;
  }
  
  public void OnAfterUndelete(List<Contact>  opp) {    
       for(Contact c : opp){
            aId.add(c.AccountId);
        }
       
        List<Account> acc = [select id,Number_Of_Contacts__c from Account where Id in:aId];
        List<Contact> con = [select id from contact where AccountId in :aId];
        
        for(Account a : acc){
            a.Number_Of_Contacts__c=con.size();
            
        }update acc;
  }
  
  public void OnAfterUpdate(List<Contact> OldCon, List<Contact>  opp, Map<Id, Contact> old) {
    Set<Id> OldAId = new Set<Id>(); 
        for(Contact c: opp){
            if(c.AccountId != old.get(c.id).AccountId)
                aId.add(c.AccountId);
                OldAId.add(old.get(c.id).AccountId);
        
        }
        if(!aId.isEmpty()){
        //for new Accounts
        List<Account> acc = [select id,Number_Of_Contacts__c from Account where Id in:aId];
        //For New Account Contacts
        List<Contact> con = [select id from contact where AccountId in :aId];
        
        /*
        This is For Old Contacts Count
                              */
        
        //for Old Accounts
        List<Account> Oldacc = [select id,Number_Of_Contacts__c from Account where Id in:OldAId];
        
        //For Old Account Contacts
        OldCon = [select id from contact where AccountId in :OldAId];
       
        //For New Accounts
        for(Account a : acc){
            a.Number_Of_Contacts__c=con.size();
            
            
        }update acc;
        
        //For Old Accounts
        for(Account a : Oldacc){
            a.Number_Of_Contacts__c=OldCon.size();
            
        }update Oldacc;
        }
  }
  
}
trigger ContactsOnAccount on Contact (after insert, after delete,after undelete,after update) 
{
    
    Set<Id> aId = new Set<Id>();
    
    if(Trigger.isInsert || Trigger.isUndelete){
        for(Contact opp : Trigger.New){
            aId.add(opp.AccountId);
        }
        List<Account> acc = [select id,Number_Of_Contacts__c from Account where Id in:aId];
        List<Contact> con = [select id from contact where AccountId in :aId];
        
        for(Account a : acc){
            a.Number_Of_Contacts__c=con.size();
            
        }update acc;
    }
    
    if(Trigger.isDelete){
        for(Contact opp : Trigger.old){
            aId.add(opp.AccountId);
        }
        List<Account> acc = [select id,Number_Of_Contacts__c from Account where Id in:aId];
        List<Contact> con = [select id from contact where AccountId in :aId];
        
        for(Account a : acc){
            a.Number_Of_Contacts__c=con.size();
            
        }update acc;
    }
   
    if(Trigger.isUpdate){
       Set<Id> OldAId = new Set<Id>(); 
        for(Contact opp : Trigger.new){
        if(opp.AccountId != Trigger.oldMap.get(opp.id).AccountId)
            aId.add(opp.AccountId);
            OldAId.add(Trigger.oldMap.get(opp.id).AccountId);
        
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
        List<Contact> OldCon = [select id from contact where AccountId in :OldAId];
       
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
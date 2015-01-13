trigger ContactSummaryonAccount on Contact (after insert, after update, after delete, after undelete) 
{
     Contact[] cons;
    if (Trigger.isDelete)
        cons = Trigger.old;
    else
        cons = Trigger.new;

    // get list of accounts
    Set<ID> acctIds = new Set<ID>();
    for (Contact con : cons) {
            acctIds.add(con.AccountId);
            acctIds.add(Trigger.oldMap.get(con.Id).AccountId);
    }
   
    Map<ID, Contact> contactsForAccounts = new Map<ID, Contact>([select Id
                                                            ,AccountId
                                                            from Contact
                                                            where AccountId in :acctIds]);

    Map<ID, Account> acctsToUpdate = new Map<ID, Account>([select Id
                                                                 ,Number_of_Contacts__c
                                                                  from Account
                                                                  where Id in :acctIds]);
                                                                
    for (Account acct : acctsToUpdate.values()) {
        Set<ID> conIds = new Set<ID>();
        for (Contact con : contactsForAccounts.values()) {
            if (con.AccountId == acct.Id)
                conIds.add(con.Id);
        }
        if (acct.Number_of_Contacts__c != conIds.size())
            acct.Number_of_Contacts__c = conIds.size();
    }

    update acctsToUpdate.values();  
}
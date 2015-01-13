@istest
public class caseUpdateMailNotificationCodeCoverage{
    static testMethod void validateTest()
    {                        
          
        List<Account> accounts = new List<Account>();
		accounts.add(new Account(Name = 'Interactive Ties', Website = 'http://www.interactiveties.com/'));
		insert accounts;
       
        List<Contact> contacts = new List<Contact>();
		contacts.add(new Contact(AccountId = accounts[0].Id, FirstName = 'Grachus', LastName = 'Dachshund', email='kavita.kale@zensar.in')); //another new Contact detail
		insert contacts;
        
        List<Case> Cases = new List<Case>();
        Cases.add(new Case(AccountId = accounts[0].Id, ContactId = contacts[0].id , Status = 'New', Origin = 'Phone' ));
        insert Cases;
        
         system.debug('accounts is: ' + accounts); 
         system.debug('contacts is: ' + contacts); 
        system.debug('Cases is: ' + Cases); 
        
         String oldstatus =  Cases[0].Status; 
        system.debug('old status is: ' + oldstatus); 
		
        test.startTest();
        
        for (Case c : Cases)
        {
            Cases[0].status = 'Medium'; 
            
        }    

        update Cases;
        
		test.stopTest();   
     }
   
}
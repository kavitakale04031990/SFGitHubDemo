public class MyController {

    public Id selectedaccount{get; set;}
    public List<Contact> contactsInformation{get; set;}
    
   public List<Account> getMyAccounts() {
        return [SELECT Id, Name, AccountNumber FROM Account ORDER BY
                LastModifiedDate DESC LIMIT 10];
    }
    
    public void accountclicked()
    {
        contactsInformation = [SELECT FirstName, LastName FROM Contact WHERE AccountID = :selectedAccount];
    }
}
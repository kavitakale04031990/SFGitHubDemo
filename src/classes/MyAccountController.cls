public class MyAccountController {

    public List<Account> getMyAccounts() {
        return [select id, name, accountNumber, billingcity, phone from account order by lastModifiedDate Desc];
    }
    
}
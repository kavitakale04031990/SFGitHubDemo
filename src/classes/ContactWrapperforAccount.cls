public class ContactWrapperforAccount {
    public boolean checked{get;set;}
    public Contact con {get;set;}
    
    public ContactWrapperforAccount()
    {
        con = new Contact();
        checked = false;
    }
     public ContactWrapperforAccount(Contact c)
    {
        con = c;
        checked = false;
    }
    
}
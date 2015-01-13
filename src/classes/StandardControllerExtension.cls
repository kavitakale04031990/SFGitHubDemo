public class StandardControllerExtension {

    Account acct;

    public StandardControllerExtension(ApexPages.StandardController std) {
        acct = (Account)std.getRecord();
    }
    
    public List<Opportunity> getchildOpps()
    {
        return [select id, Name, amount, stagename, closedate from opportunity
           where AccountId= :acct.id
           AND (IsWon = true or IsClosed = false)];
    }

}
/*  Test commit on Jan 14, 2014
Added by Kavita Kale  on Jan 13, 2015
*/

public with sharing class AccountConPagination {
    Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}
    
    Integer Fetch1_count = 10;
    Integer Fetch2_count = 20;
     Integer push1_count = 30;
    
    public ApexPages.StandardSetController setCon {
        get{
            if(setCon == null){
                size = 10;
                string queryString = 'Select Name, Type, BillingCity, BillingState, BillingCountry from Account order by Name';
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
            }
            return setCon;
        }set;
    }
     
    Public List<Account> getAccounts(){
        List<Account> accList = new List<Account>();
        for(Account a : (List<Account>)setCon.getRecords())
            accList.add(a);
        return accList;
    }
     
    public pageReference refresh() {
        setCon = null;
        getAccounts();
        setCon.setPageNumber(1);
        return null;
    }
     
    public Boolean hasNext {
        get {
            return setCon.getHasNext();
        }
        set;
    }
    public Boolean hasPrevious {
        get {
            return setCon.getHasPrevious();
        }
        set;
    }
  
    public Integer pageNumber {
        get {
            return setCon.getPageNumber();
        }
        set;
    }
  
    public void first() {
        setCon.first();
    }
  
    public void last() {
        setCon.last();
    }
  
    public void previous() {
        setCon.previous();
    }
  
    public void next() {
        setCon.next();
    }
}
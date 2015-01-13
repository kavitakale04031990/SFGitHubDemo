public with sharing class AccountRelatedContactPagination_v1 {

	Integer push_count = 10;
    Integer fetch_count = 10;
	
    public AccountRelatedContactPagination_v1() {

    }


    List<ContactWrapperforAccount> categories{get; set;}
    
    public AccountRelatedContactPagination_v1(ApexPages.StandardController controller) {

    }

    Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}
    public ApexPages.StandardSetController setCon {
        get{
            if(setCon == null){
                size = 10;
                List<Contact> queryString = [select id, name from Contact WHERE AccountId =: ApexPages.CurrentPage().getparameters().get('id') offset 4];                       
                setCon = new ApexPages.StandardSetController(queryString );
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
            }
            return setCon;
        }set;
    }
    
    public List<Contact> getAccountsRelatedContacts() {
        List<Contact> conList = new List<Contact>();
        for(Contact c: (List<Contact>)setCon.getRecords())
            conList.add(c);
        return conList;
    }
    
    public pageReference refresh() {
        setCon = null;
        getAccountsRelatedContacts();
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
    
     // returns a list of wrapper objects for the sObjects in the current page set
    public List<ContactWrapperforAccount> getCategories() {
        categories = new List<ContactWrapperforAccount>();
        for (Contact category : (List<Contact>)setCon.getRecords())
            categories.add(new ContactWrapperforAccount(category));

        return categories;
    }

    // displays the selected items
     public PageReference process() {
         for (ContactWrapperforAccount cw : categories) {
             if (cw.checked)
                 ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,cw.con.name));
         }
         return null;
     }
     
}
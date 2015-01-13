public with sharing class CCW_WrapperSampleController {
 
    /*
    *   The list of ContactWrappers
    */
    public List<ContactWrapper> contactList{get;set;}
 
    /*
    *   Message displayed to the page
    */
    public String message{get;set;}
 
    /*
    *   Controller
    */
    public CCW_WrapperSampleController(){
 
        this.message = 'Please select one or more Contacts.';
 
        //initialize the ContactWrapper container
        this.contactList  = new List<ContactWrapper>();
 
        loadContacts();
 
    }
 
    /*
    *   Process the record selection
    */
    public void doProcessSelection(){
 
        Integer selectedCount = 0;
 
        for(ContactWrapper cw : this.contactList){
 
            if(cw.selected==true)
                selectedCount++;
        }
 
        this.message = 'You have selected '+selectedCount+' records.';
 
    }
 
    /*
    *   Load contact records for display
    */
    private void loadContacts(){
 
        //select 50 contacts for sample display
        for(Contact c : [SELECT Id, FirstName, LastName, Email, Phone FROM Contact LIMIT 10]){
 
            this.contactList.add( new ContactWrapper(c) );
 
        }
 
    }
 
    /*
    *   This wrapper class encapsulates a contact record.
    *   An additional property 'selected' tracks whether
    *   the record has been selected.
    */
    public class ContactWrapper{
 
        //the contact record
        public Contact tContact{get;set;}
 
        //whether the record is selected
        public Boolean selected{get;set;}
 
        /*
        *   Constructor
        *   initializes the Contact reference
        */
        public ContactWrapper(Contact c){
            this.tContact = c;
            this.selected = false;
        }
 
    }
 
}
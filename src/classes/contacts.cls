public class contacts {
    public class mcontact { 
  contact c; string emailType; boolean selected; 
  
  public String getEmailType() {
      return emailType;
  }
  public void setemailType(String emailType){
      this.emailType= emailType;
  }
  public mcontact( contact con) { c=con;}
  public Contact getContact() { return c; }
  
  public boolean getSelected() { return selected; }
  public void setSelected(boolean sb) { selected = sb; }
  
  public List<SelectOption> getEmails(){
   List<SelectOption> options = new List<SelectOption>();
   options.add(new SelectOption('','-None-'));
   options.add(new SelectOption('Renewal Notice','Renewal Notice'));
   options.add(new SelectOption('White Paper','White Paper'));
   options.add(new SelectOption('Phone Call Follow Up','Phone Call Follow Up'));
   return options; 
  }
 } 
    
    mContact [] Contacts;

    public List<mContact> getContacts(){
        if(contacts == null){
         contacts = new mContact[]{};
            for( Contact c: [select Id, Name, Phone, MailingCity, Email from Contact limit 10]) {
             contacts.add( new mContact(c) );  
            }    
        } 
        return Contacts;
    }
}
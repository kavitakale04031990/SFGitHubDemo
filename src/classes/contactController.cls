public class contactController {

    String s = 'detail';

    public String getString() {
        return s;
    }

    public void setString(String s) {
        this.s = s;
    }

    public PageReference test() {
            return null;
        }
   
   public List<Contact> getContacts() {
      return [SELECT Id, Name, Account.Name, Phone, Email
              FROM Contact
              ORDER BY LastModifiedDate DESC LIMIT 10];
   }

   public Contact getContact() {
      Id id = System.currentPageReference().getParameters().get('id');
      return id == null ? new Contact() : [SELECT Id, Name
                                             FROM Contact
                                            WHERE Id = :id];
   }
}
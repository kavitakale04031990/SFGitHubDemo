trigger caseUpdationMailNotification on Case (after update) {    
    Set<Id> conIds = new Set<Id>();
    Set<Id> conOwnerIds= new Set<Id>();
    
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

    for (Case c: trigger.new) {
        conIds.add(c.ContactId);
        conOwnerIds.add(c.OwnerId);
       
    }
    Map<Id, Contact> conMap = new Map<Id, Contact>([SELECT Id, Email FROM Contact WHERE Id In :conIds]);
    
    Map<Id, User> conOwnerMap = new Map<Id, User>([SELECT Id,  Email FROM user WHERE Id In :conOwnerIds]);
    
     
    EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'Case_Email_Alert'];     
    try{
        for (Case c : trigger.new) {
            Contact relatedCaseContact = conMap.get(c.ContactId);
            User caseOwner = conOwnerMap.get(c.OwnerId);                    
           
            Messaging.SingleEmailMessage CaseNotificationmail = new Messaging.SingleEmailMessage();                   
            
            String oldStatus = trigger.oldMap.get(c.id).status;        
            
                if (c.status != oldStatus) {              
                    CaseNotificationmail.setToAddresses(new List<String> { relatedCaseContact.Email });               
                    CaseNotificationmail.setCcAddresses(new List<String> { caseOwner.Email });
                    CaseNotificationmail.setSenderDisplayName('Salesforce Trigger Tester');
                        
                    CaseNotificationmail.setSenderDisplayName('Salesforce Support- Apex Trigger');  
                    CaseNotificationmail.setSubject(' Case Status updation for Case Number:' + c.CaseNumber);
                    CaseNotificationmail.setPlainTextBody(' Case Status updation : ' + 'Changed to ' + c.status + '. Case Number:' + c.CaseNumber);              
            }      
           mails.add(CaseNotificationmail); 
     }
    Messaging.sendEmail(mails);
    }
    catch(Exception Ex){
        system.debug(Ex); 
          for(Case caseError: trigger.new)
              caseError.addError(Ex.getMessage());
      }   
}
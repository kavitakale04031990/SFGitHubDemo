trigger test1 on Contact (after update) {
        Messaging.reserveSingleEmailCapacity(trigger.size);
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        Contact toRecipient = [SELECT id, Email FROM Contact WHERE Id = '0039000000NXqakAAD' LIMIT 1];
        Contact ccRecipient = [SELECT id, Email FROM Contact WHERE Id = '0039000000w4mmMAAQ' LIMIT 1];
        Contact bccRecipient = [SELECT id, Email FROM Contact WHERE Id = '0039000000NXqJ2AAL' LIMIT 1];
        EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'Contact_Email_Alert_Cc_Bcc'];
        for (Contact c : trigger.new) { 
            Contact old = trigger.oldMap.get(c.Id); 
            if (old.Email != c.Email ) { 
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
           
                email.setToAddresses(new String[] {toRecipient.email} );                
                email.setTargetObjectId(c.id);         
                email.setCcAddresses(new String[] {ccRecipient.email} );
                email.setBccAddresses(new String[] {bccRecipient.email} );            
                email.setSenderDisplayName('Salesforce Trigger Tester');
                email.setTemplateId(et.id);
        
                emails.add(email); 
            }
        }
        Messaging.sendEmail(emails);
}
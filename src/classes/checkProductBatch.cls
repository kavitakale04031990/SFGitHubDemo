global class checkProductBatch implements Database.Batchable<SObject>, Schedulable
{   
    global Database.queryLocator start(Database.BatchableContext ctx) {
        Datetime d = (Datetime.now()).addHours(-2);
        String dFormat = d.format('hh:mm:ss');
        
        return Database.getQueryLocator([select id, name, createdDate, systemModStamp 
                                         from OpportunityLineItem 
                                 where createdDate =: Date.today() and systemModStamp >= :d]);
    }
    
    global void execute(Database.BatchableContext BC, List<OpportunityLineItem> scope) 
    {       
         for(OpportunityLineItem o : scope)
        {
            system.debug('Product added to OpportunityLineItem:- ' + o.id + ' Name:- ' + o.name + ' Opportunity Id:- ' + o.OpportunityId);          
            String emailContent = 'Product added to OpportunityLineItem:- ' + o.id + ' Name:- ' + o.name + ' Opportunity Id:- ' + o.OpportunityId;
            sendEmail('kavita.kale213@gmail.com', emailContent);
        }
    }    
    
    global void finish(Database.BatchableContext BC) {          
        system.debug('In Finish Method');
    }
    
    public void sendEmail(String emailId, String emailContent)
    {
         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        system.debug('before send email');
        mail.setToAddresses(new List<String> {emailId});
        mail.setReplyTo('kavita.kale@zensar.in');
        mail.setSenderDisplayName('Salesforce OpportunityLineItem Added');
        mail.setSubject('Product has been added to the opportunity');
        mail.setPlainTextBody(emailContent);
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
    } 
    
    global void execute(SchedulableContext ctx)
    {
        checkProductBatch c = new checkProductBatch();
        Database.executeBatch(c);
    }
}
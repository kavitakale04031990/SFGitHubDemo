global class BatchOpportunityTraining implements Database.Batchable<SObject>{
    global Database.queryLocator start(Database.BatchableContext ctx) {
        date d = (Date.today()).addDays(-15);
        return Database.getQueryLocator([select id, OwnerId, name, lastModifiedDate from Opportunity where lastModifiedDate < :d limit 5]); 
    }
    
    global void execute(Database.BatchableContext BC, List<Opportunity> scope) {    
        Set<Id> oppSet = new Set<Id>();
        Set<Id> oppIDSet = new Set<Id>();
            
        system.debug('Opportunity List in Scope is: ' + scope);
        
       List<Task> tk = new List<Task>();
        for(Opportunity o : scope)
        {     
            Task u = new Task();
            oppSet.add(o.OwnerId);       
            oppIDSet.add(o.Id);
            u.ownerId = o.OwnerId; 
            u.Subject = 'Run Test Trigger';
            u.Status = 'Not Started';
            u.Priority = 'Normal';  
            tk.add(u);
        }insert tk;    
        system.debug('Task Created is:- ' + tk);
        Map<Id, User> oppOwnerMap = new Map<Id, User>([SELECT Id,  Email FROM user WHERE Id In :oppSet]);
        system.debug('oppOwnerMap is:- ' + oppOwnerMap);
       
        for(Opportunity o : scope)
        {
            String emailContent = 'Opportunity Id is:- ' + o.Id + 'Opportunity Name is:- ' + o.Name;
            String [] emailId = new String[] {oppOwnerMap.get(o.OwnerId).Email};
            sendEmail(emailId,emailContent);
        }
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
    
    public void sendEmail(String[] toAddress, String emailContent)
    {
        system.debug('inside sendEmail function');
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        system.debug('before send email');
        mail.setToAddresses(toAddress);
        mail.setCcAddresses(new List<String> {'kavita.kale213@gmail.com'});
        mail.setReplyTo('kavita.kale@zensar.in');
        mail.setSenderDisplayName('Salesforce Opportunity Update');
        mail.setSubject('You need to update the opportunity');
        mail.setPlainTextBody('You have not updated your opportunity for the past 15 days- ' + emailContent);
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });        
    }
}
global class BatchAccount implements Database.Batchable<SObject> {
    
    global Database.queryLocator start(Database.BatchableContext ctx) {
    	return Database.getQueryLocator([select id from Account]);
	}
	global void execute(Database.BatchableContext BC, List<sObject> scope) {
    	
    } 	 
    
	global void finish(Database.BatchableContext BC) {
		AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems
     			 FROM AsyncApexJob WHERE Id =: BC.getJobId()];
        Integer i = a.TotalJobItems;
        Integer j = a.NumberOfErrors;
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		system.debug('before send email');
        mail.setToAddresses(new String[] {'kavita.kale213@gmail.com'});
        mail.setReplyTo('kavita.kale@zensar.in');
        mail.setSenderDisplayName('Batch Processing');
        mail.setSubject('Batch Process Completed');
        mail.setPlainTextBody('Batch Process has completed- ' + i);
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

}
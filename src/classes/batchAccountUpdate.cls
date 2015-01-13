global class batchAccountUpdate implements Database.Batchable<sObject> 
{
	global Database.Querylocator start(Database.BatchableContext BC)
	{
		String query = 'select id, name from Account';
		return Database.getQueryLocator(query);
		
	}
	
	global void execute(Database.BatchableContext BC, List<Account> accList)
	{
		for (account a: accList)
		{
            // a.Name = a.Name + 'Updated';
            a.Name = a.Name.remove('updatedupdated');
            system.debug('a.Name : ' + a.Name);
		}
		update accList;
	}
	
	global void finish(Database.BatchableContext BC)
	{
		
	}
	

}
trigger LeadOwnerinDesc on Lead (before insert, before update) 
{
	Set<Id> leadID = new Set<Id>();
   
    for(Lead l : Trigger.new)
    {
        leadID.add(l.OwnerId);
    }
    
    Map<Id, User> owners = new Map<Id, User>([select Id, Name from User where id in :leadId]);
    
     if(Trigger.isInsert)
     {         
       for(Lead opp : Trigger.new)
        {
            opp.Description = owners.get(opp.OwnerId).Name + ' - ' + owners.get(opp.OwnerId).Id; 
        }         
     }
    
     else if(Trigger.isUpdate)
     {         
       for(Lead opp : Trigger.new)
        {
            opp.Description = opp.Description + '\r\n' + owners.get(opp.OwnerId).Name + ' - ' + owners.get(opp.OwnerId).Id;
        }   
         
     }
}
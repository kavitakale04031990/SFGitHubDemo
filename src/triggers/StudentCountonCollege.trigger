trigger StudentCountonCollege on Student__c (after insert, after update, after delete, after undelete) 
{
	ObjectTriggerHandlerforStuentCollege handler = new ObjectTriggerHandlerforStuentCollege(Trigger.isExecuting, Trigger.size);
    
    if(Trigger.isInsert)
    {
        handler.onAfterInsert(Trigger.new);
    }
    
    else if(Trigger.isUpdate)
    {
        handler.onAfterUpdate(Trigger.old, Trigger.new, Trigger.oldMap);
    }
    
    else if(Trigger.isDelete) 
    {
        handler.onAfterDelete(Trigger.old);
  	}
    
    else if(Trigger.isUndelete) 
    {
        handler.onAfterUndelete(Trigger.new);
  	}
}
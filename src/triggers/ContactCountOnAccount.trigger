trigger ContactCountOnAccount on Contact(after delete, after insert, after undelete,after update) 
{
   ObjectTriggerHandler handler = new ObjectTriggerHandler(Trigger.isExecuting, Trigger.size);
  
  if(Trigger.isInsert) {
          handler.OnAfterInsert(Trigger.new);
    }
   else if(Trigger.isDelete) {
          handler.OnAfterDelete(Trigger.old);
    }
   else if(Trigger.isUndelete) {
        handler.OnAfterUndelete(Trigger.new);
  }
  else if(Trigger.isUpdate) {
       handler.OnAfterUpdate(Trigger.old, Trigger.new, Trigger.oldMap);
  }
}
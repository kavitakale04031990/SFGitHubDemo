trigger zensarAcct on Account (before insert,before update) {
 if(Trigger.isInsert){
      for(Account a:Trigger.new){
         if(a.name.contains('zensar'))
             a.description='This is a zensar Account.';
 }
 }
 if(Trigger.isUpdate){
          for(Account a:Trigger.new){
             if(Trigger.oldMap.get(a.id).name.contains('zensar')&& ! Trigger.newMap.get(a.id).name.contains('zensar'))
                 a.description='This Was a zensar Account.';
             else if(!Trigger.oldMap.get(a.id).name.contains('zensar')&& Trigger.newMap.get(a.id).name.contains('zensar'))
                 a.description='This is Now a zensar Account.';
             }
       }
}
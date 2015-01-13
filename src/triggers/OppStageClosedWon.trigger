trigger OppStageClosedWon on Opportunity (after update, after insert) {
     for (Opportunity opp : Trigger.New) {
        if (opp.StageName== 'Closed Won') {
           Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
           req1.setComments('Automatic record lock.');
           req1.setObjectId(opp.id);
           
           Approval.ProcessResult result = Approval.process(req1);
       }     
      }      
}
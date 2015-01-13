public with sharing class searchLeadsByCompany {

    public List<Lead> leadList{get;set;}
    public String searchLead{get;set;}
    
    public Integer myInt { get; set; }   
        
    
     public searchLeadsByCompany(ApexPages.StandardController controller)
    {
       
    } 
   
    public void Search() {   
        String searchQuery = 'select id, name, status, IsConverted, Company from lead where Company like \'%'+searchLead+'%\' Limit 20';        
        leadList= Database.Query(searchQuery);        
    }
    
    public void closedConverted(){
        for(Lead l : leadList){
            system.debug('inside for loop- ' + l.Name);
            if(l.IsConverted == false)
            {
                system.debug('lead is not converted- ' + l.Name);
                if(l.Status != 'Closed - Converted' && l.Status != 'Closed - Not Converted')
                {
                    l.status = 'Closed - Converted';
                    
                }
            }
        } update leadList;
        ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.INFO, 'Total Number of Records Updated- ' + leadlist.size());
        apexpages.addmessage(msg);
    }   
}
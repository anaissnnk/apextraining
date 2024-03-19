//not bulk
trigger MyTriggerNotBulk on Account(before insert) {
    Account a = Trigger.new[0];
    a.Description = 'New description';
}

//bulk
trigger MyTriggerBulk on Account(before insert) {
    for(Account a : Trigger.new) {
        a.Description = 'New description';
    }
}

//to avoid
trigger SoqlTriggerNotBulk on Account(after update) {   
    for(Account a : Trigger.new) {
        // Get child records for each account
        // Inefficient SOQL query as it runs once for each account!
        Opportunity[] opps = [SELECT Id,Name,CloseDate 
                             FROM Opportunity WHERE AccountId=:a.Id];
        // Do some other processing
    }
}

//best practice
trigger SoqlTriggerBulk on Account(after update) {  
    // Perform SOQL query once.    
    // Get the accounts and their related opportunities.
    List<Account> acctsWithOpps = 
        [SELECT Id,(SELECT Id,Name,CloseDate FROM Opportunities) 
         FROM Account WHERE Id IN :Trigger.new];
    // Iterate over the returned accounts    
    for(Account a : acctsWithOpps) { 
        Opportunity[] relatedOpps = a.Opportunities;  
        // Do some other processing
    }
}
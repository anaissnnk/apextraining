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

//getting all related records
trigger SoqlTriggerBulk on Account(after update) {  
    // Perform SOQL query once.    
    // Get the related opportunities for the accounts in this trigger.
    List<Opportunity> relatedOpps = [SELECT Id,Name,CloseDate FROM Opportunity
        WHERE AccountId IN :Trigger.new];
    // Iterate over the related opportunities    
    for(Opportunity opp : relatedOpps) { 
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


List<Opportunity> toProcess = new List<Opportunity>();

switch on Trigger.operationType {
    when AFTER_INSERT {
        toProcess = Trigger.new;
    }
    when AFTER_UPDATE {
        // Use a separate query for updated opportunities
        toProcess = [SELECT Id, Stage FROM Opportunity WHERE Id IN :Trigger.new];
    }
}

//bulk trigger solution
trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    List<Task> taskList = new List<Task>();
    for(Opportunity opp : [SELECT Id, StageName FROM Opportunity WHERE StageName='Closed Won' AND Id IN : Trigger.New]){
        taskList.add(new Task(Subject='Follow Up Test Task', WhatId = opp.Id));
    }
    
    if(taskList.size()>0){
        insert tasklist;
    }
}

//bulk trigger exercise
trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    for(Opportunity opp: [SELECT Id FROM Opportunity
                          WHERE StageName = 'Closed Won']) {
                              Task newTask = new Task();
                              newTask.Subject = 'Follow Up Test Task';
                              newTask.WhatId = opp.Id;
                              insert newTask;
    }
}


trigger ClosedOpportunityTrigger on Opportunity(after insert, after update) {
    List<Opportunity> toProcess = new List<Opportunity>();
    switch on Trigger.operationType {
        when AFTER_INSERT {
            toProcess = Trigger.New;
        }
        when AFTER_UPDATE {
            toProcess =  [SELECT Id, Stage FROM Opportunity
                         WHERE Id IN :Trigger.New]
        }
    }
    for (Opportunity opp : toProcess) {
        if (opp.Stage == 'Closed Won') {
            Task newTask = new Task();
            newTask.Subject = 'Follow Up Test Task';
            newTask.WhatId = opp.Id;
            insert newTask;
        }
    }
}


trigger ClosedOpportunityTrigger on Opportunity(after insert, after update) {  
    List<Opportunity> closedWonOpportnities = 
        [SELECT Id,(SELECT Id FROM Opportunities) 
         FROM Opportunity WHERE Id IN :Trigger.new];
    for(Opportunity opp : closedWonOpportnities) { 
        if (opp.Stage = 'Closed Won') {
            Task newTask = new Task();
            newTask.Subject = 'Follow Up Test Task';
            newTask.WhatID = opp.Id;
            insert newTask;
        }
    }
}


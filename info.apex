//apex basics
public class AccountHandler {
    public static Account insertNewAccount(String accountName) {
        try {
            Account acct = new Account();
            acct.Name = accountName;
            insert acct;
            return acct;
        } catch (DmlException e) {
            return null;
        }
    }
}

//apex trigger
//trigger syntax
trigger TriggerName on ObjectName (trigger_events) {
   code_block
}

//exercise A trigger to set postal code
trigger AccountAddressTrigger on Account (before insert, before update) {
    for(Account a : Trigger.new) {
        if (a.Match_Billing_Address__c == true) {
        a.ShippingAddress = a.Match_Billing_Address__c;
    }
}
}

//Exercise A solution - using correct object
trigger AccountAddressTrigger on Account (before insert, before update) {
    for(Account a : Trigger.new) {
        if (a.Match_Billing_Address__c == true) {
        a.ShippingPostalCode = a.BillingPostalCode;
    }
}
    }

//to avoid
trigger DmlTriggerNotBulk on Account(after update) {   
    // Get the related opportunities for the accounts in this trigger.        
    List<Opportunity> relatedOpps = [SELECT Id,Name,Probability FROM Opportunity
        WHERE AccountId IN :Trigger.new];          
    // Iterate over the related opportunities
    for(Opportunity opp : relatedOpps) {      
        // Update the description when probability is greater 
        // than 50% but less than 100% 
        if ((opp.Probability >= 50) && (opp.Probability < 100)) {
            opp.Description = 'New description for opportunity.';
            // Update once for each opportunity -- not efficient!
            update opp;
        }
    }    
}

//best practice
trigger DmlTriggerBulk on Account(after update) {   
    // Get the related opportunities for the accounts in this trigger.        
    List<Opportunity> relatedOpps = [SELECT Id,Name,Probability FROM Opportunity
        WHERE AccountId IN :Trigger.new];
    List<Opportunity> oppsToUpdate = new List<Opportunity>();
    // Iterate over the related opportunities
    for(Opportunity opp : relatedOpps) {      
        // Update the description when probability is greater 
        // than 50% but less than 100% 
        if ((opp.Probability >= 50) && (opp.Probability < 100)) {
            opp.Description = 'New description for opportunity.';
            oppsToUpdate.add(opp);
        }
    }
    // Perform DML on a collection
    update oppsToUpdate;
}

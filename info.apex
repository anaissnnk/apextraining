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

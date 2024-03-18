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

/*the following retrieves all account records with two fields
Name and Phone, and returns an array of Account sObjects.*/
Account[] accts = [SELECT Name,Phone FROM Account];

//basic SOQL syntax
SELECT fields FROM ObjectName [WHERE Condition];

//SOQL exercise
public class ContactSearch {
    public static List<Contact> searchForContacts(String lastName, String mailingPostalCode) {
        List<Contact> selectedContacts = [SELECT ID, Name
                                     FROM Contact
                                     WHERE LastName = :lastName
                                    AND MailingPostalCode = :mailingPostalCode];
        return selectedContacts;
    }
}

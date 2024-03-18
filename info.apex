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

//SOSL - searches for accounts and contacts that have any fields with the word 'SFDC'.
List<List<SObject>> searchList = [FIND 'SFDC' IN ALL FIELDS 
                                      RETURNING Account(Name), Contact(FirstName,LastName)];

//basic SOSL
FIND 'SearchQuery' [IN SearchGroup] [RETURNING ObjectsAndFields]


//SOQL exercise
public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads (String searchedName) {
        List<List<SObject>> searchList = [FIND :searchedName IN ALL FIELDS 
                                      RETURNING Contact(LastName), Lead(LastName)];
        return searchList;
    }
}





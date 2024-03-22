@isTest
private class TestVerifyDate {
    @isTest
    static void CheckDates() {
    Date returnSecondDate = VerifyDate.getCheckDates();
    System.assertEquals(Date, returnSecondDate)
    }
    @isTest
  	static void DateWithin30Days() {
    Date date2Within30DaysOfDate1 = VerifyDate.getDateWithin30Days();
    System.assertEquals(getDateWithin30Days(), date2Within30DaysOfDate1);
    }
    @isTest
  //method to return the end of the month of a given date
  	static void SetEndOfMonthDate() {
    Date endOfTheMonth = VerifyDate.getSetEndOfMonthDate();
    System.assertEquals(getSetEndOfMonthDate(, endOfTheMonth));
  }
}

//exercise answer
@isTest
public class TestVerifyDate 
{
    static testMethod void testMethod1() 
    {
        Date d = VerifyDate.CheckDates(System.today(),System.today()+1);
        Date d1 = VerifyDate.CheckDates(System.today(),System.today()+60);
    }
}

//apex trigger testing
@isTest
private class TestRestrictContactByName {

    static testMethod void  metodoTest() 
    {
    
        List<Contact> listContact= new List<Contact>();
        Contact c1 = new Contact(FirstName='Francesco', LastName='Riggio' , email='Test@test.com');
        Contact c2 = new Contact(FirstName='Francesco1', LastName = 'INVALIDNAME',email='Test@test.com');
        listContact.add(c1);
        listContact.add(c2);
        
        Test.startTest();
            try
            {
                insert listContact;
            }
            catch(Exception ee)
            {
            }
        
        Test.stopTest();       
    }  
}

//My attempt
public class RandomContactFactory {
    public static List<Contact> generateRandomContacts (Integer numberOfGeneratedContact, String commonLastName) {
        List<Contact> toProcess = new List<Contact>();
        for(Integer i=0;i<numberOfGeneratedContact;i++) 
           Contact newContact = new Contact();
            newContact.LastName = 'Test' + numberOfGeneratedContact;
            toProcess.add(newContact);
            System.debug(newContact);
        }
    return toProcess;
}

//answer
public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numContactsToGenerate, String FName) {
        List<Contact> contactList = new List<Contact>();
    for(Integer i=0;i<numContactsToGenerate;i++) {
            Contact c = new Contact(FirstName=FName + ' ' + i, LastName = 'Contact '+i);
            contactList.add(c);
            System.debug(c);
        }
        //insert contactList;
        System.debug(contactList.size());
        return contactList;
    }

}

//apex
public class AnimalLocator {
    
    public static String getAnimalNameById (Integer i) {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+ i);
    request.setMethod('GET');
    HttpResponse response = http.send(request);
        
        if(response.getStatusCode()==200) {
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
    		Map<String, Object> animal = (Map<String, Object>) result.get('animal');
            System.debug('name: '+string.valueOf(animal.get('animal')));
    		return string.valueOf(animal.get('name'));
        } else {
            return null;
        }
    }
}
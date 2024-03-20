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
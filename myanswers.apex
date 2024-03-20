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
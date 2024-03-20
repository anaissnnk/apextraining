//test method syntax
@isTest static void testName() {
  // code_block
}

//test class with test method
@isTest
private class MyTestClass {
  @isTest static void myTest() {
    // code_block
  }
}

//test temperature
/*The TemperatureConverterTest test class verifies that the method works as expected
The verifications are done by calling the System.assertEquals() method, which takes two parameters:
the first is the expected value, and the second is the actual value.
There is another version of this method that takes a third parameter—a string
that describes the comparison being done, which is used in testBoilingPoint().
This optional string is logged if the assertion fails*/

@isTest
private class TemperatureConverterTest {
  @isTest static void testWarmTemp() {
    Decimal celsius = TemperatureConverter.FahrenheitToCelsius(70);
    System.assertEquals(21.11,celsius);
  }
  @isTest static void testFreezingPoint() {
    Decimal celsius = TemperatureConverter.FahrenheitToCelsius(32);
    System.assertEquals(0,celsius);
  }
  @isTest static void testBoilingPoint() {
    Decimal celsius = TemperatureConverter.FahrenheitToCelsius(212);
    System.assertEquals(100,celsius,'Boiling point temperature is not expected.');
  }
  @isTest static void testNegativeTemp() {
    Decimal celsius = TemperatureConverter.FahrenheitToCelsius(-10);
    System.assertEquals(-23.33,celsius);
  }
}


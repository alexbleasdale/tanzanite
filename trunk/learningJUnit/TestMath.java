package learningJUnit;
import junit.framework.*;

public class TestMath extends TestCase {

  public void testAdd() {
        int num1 = 3;
        int num2 = 2;
        int total = 5;
        int sum = 0;
        sum = Math.add(num1, num2);
        assertEquals(sum, total);
  }
  
  public void testSubtract(){
	  int num1 = 5;
	  int num2 = 2;
	  int total = 3;
	  int sum = 0;
	  sum = Math.subtract(num1, num2);
	  assertEquals(sum, total);
  }
  
  public void testDivide(){
	  int num1 = 6;
	  int num2 = 2;
	  int total = 3;
	  int sum = 0;
	  sum = Math.divide(num1, num2);
	  assertEquals(sum, total);
  }
  
  public void testRemainder(){
	  int num1 = 5;
	  int num2 = 2;
	  int total = 1;
	  int sum = 0;
	  sum = Math.remainder(num1, num2);
	  assertEquals(sum, total);
  }
  
} 
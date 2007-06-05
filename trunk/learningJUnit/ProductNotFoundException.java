package learningJUnit;
/**
 * Exception thrown when a product is not found
 * in a shopping cart as described in the
 * JUnit Primer.
 *
 * @author Mike Clark, http://clarkware.com 
 */

public class ProductNotFoundException extends Exception {
    
    public ProductNotFoundException() {
	super();
    }
}

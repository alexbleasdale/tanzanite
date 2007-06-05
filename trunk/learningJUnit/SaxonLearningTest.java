package learningJUnit;
import junit.framework.*;
import net.sf.saxon.*;
import net.sf.saxon.xpath.*;
import javax.xml.transform.sax.*;

public class SaxonLearningTest extends TestCase {

	 public void testXSLTransformation() {
	      /* initialize the variables
	        (or do this in setUp if used in many tests) */
	      String processMePath = "/path/to/file.xml";
	      String stylesheetPath = "/path/to/stylesheet.xsl";
	      String outputFilePath = "/path/to/output.xml";
	      //do the work
	      Transform.main(new String[] {
	        processMePath,
	        stylesheetPath,
	        "-o", outputFilePath } );
	      //check the work
	      assertTrue(checkOutputFile(outputFilePath));
	    }
	 
	    public void testXPathEvaluation() {
	        //initialize
	        XPathEvaluator xpe = new XPathEvaluator(
	          new SAXSource(new InputSource("/path/to/file.xml")));
	        XPathExpression findLine =
	          xpe.createExpression("/some/xpath[expression]");
	        //work
	        List matches = findLine.evaluate();
	        //check
	        assertTrue(matches.count() > 0);
	      }
	
	
}

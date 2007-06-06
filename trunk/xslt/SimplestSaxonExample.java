package xslt;
import java.io.File;
//import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.xml.sax.SAXException;

public class SimplestSaxonExample {
/* this is the simplest example i can get for making saxon work within a class */

	public static void main(String args[]) {
		// these are the void main bits we need to get something up and running

		// set the TransformFactory to use the Saxon TransformerFactoryImpl method 
		System.setProperty("javax.xml.transform.TransformerFactory",
				"net.sf.saxon.TransformerFactoryImpl");
		
		// reading an input xml file
		String foo_xml = "xml/foo.xml";
//		 reading an input xsl file
		String foo_xsl = "xsl/foo.xsl";

		try {
			exampleTransformer (foo_xml, foo_xsl);
		} catch (Exception ex) {
			handleException(ex);
		}

	}

	
	
	public static void exampleTransformer (String sourceID, String xslID)
			throws TransformerException, TransformerConfigurationException {

		// Create a transform factory instance.
		TransformerFactory tfactory = TransformerFactory.newInstance();

		// Create a transformer for the stylesheet.
		Transformer transformer = tfactory.newTransformer(new StreamSource(
				new File(xslID)));

	//	transformer.setParameter("a-param", "hello to you!");

		// Transform the source XML to System.out.
		transformer.transform(new StreamSource(new File(sourceID)),
				new StreamResult(System.out));
		//System.out.println("\n=========\n");
		// transformer.setParameter("a-param", "hello to me!");
		//transformer.setOutputProperty(OutputKeys.INDENT, "yes");

		// Transform the source XML to System.out.
		//transformer.transform(new StreamSource(new File(sourceID)),
			//	new StreamResult(System.out));
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	/* generic saxon exception handling routine - needs to be here so all the try/catch stuff is routed, but can be ignored for the purposes of using saxon as an xslt processor*/ 
	
	private static void handleException(Exception ex) {

		System.out.println("EXCEPTION: " + ex);
		ex.printStackTrace();

		if (ex instanceof TransformerConfigurationException) {
			System.out.println();
			System.out.println("Test failed");

			Throwable ex1 = ((TransformerConfigurationException) ex)
					.getException();

			if (ex1 != null) { // added by MHK
				ex1.printStackTrace();

				if (ex1 instanceof SAXException) {
					Exception ex2 = ((SAXException) ex1).getException();

					System.out.println("Internal sub-exception: ");
					ex2.printStackTrace();
				}
			}
		}
	}

}

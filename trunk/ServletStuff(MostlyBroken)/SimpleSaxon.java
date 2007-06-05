import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import org.xml.sax.SAXException;
 
/**
 * A simple demo of SAXON. This code was originally written using
 * SAXON 5.5.1.
 */
public class SimpleSaxon {
 
    /**
     * Accept two command line arguments: the name of an XML file, and
     * the name of an XSLT stylesheet. The result of the transformation
     * is written to stdout.
     */
    public static void main(String[] args)
            throws MalformedURLException, IOException, SAXException {
        if (args.length != 2) {
            System.err.println("Usage:");
            System.err.println("  java " + SimpleSaxon.class.getName(  )
                    + " xmlFileName xsltFileName");
            System.exit(1);
        }
 
        String xmlFileName = args[0];
        String xsltFileName = args[1];
 
        String xmlSystemId = new File(xmlFileName).toURL().toExternalForm(  );
        String xsltSystemId = new File(xsltFileName).toURL().toExternalForm(  );
 
        com.icl.saxon.trax.Processor processor =
                com.icl.saxon.trax.Processor.newInstance("xslt");
 
        // unlike Xalan, SAXON uses the SAX InputSource.  Xalan
        // uses its own class, XSLTInputSource
        org.xml.sax.InputSource xmlInputSource =
                new org.xml.sax.InputSource(xmlSystemId);
        org.xml.sax.InputSource xsltInputSource =
                new org.xml.sax.InputSource(xsltSystemId);
 
        com.icl.saxon.trax.Result result =
                new com.icl.saxon.trax.Result(System.out);
 
        // create a new compiled stylesheet
        com.icl.saxon.trax.Templates templates =
                processor.process(xsltInputSource);
 
        // create a transformer that can be used for a single transformation
        com.icl.saxon.trax.Transformer trans = templates.newTransformer(  );
        trans.transform(xmlInputSource, result);
    }
}
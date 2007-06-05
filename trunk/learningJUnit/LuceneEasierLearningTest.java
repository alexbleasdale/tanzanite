package learningJUnit;
import junit.framework.*;
//import org.apache.lucene.*;
import org.apache.lucene.search.*; 
import org.apache.lucene.store.*;
import org.apache.lucene.index.*;
import org.apache.lucene.document.*;
import org.apache.lucene.analysis.standard.*;
//import org.apache.lucene.queryParser.*;

public class LuceneEasierLearningTest extends TestCase {

	    

	    public void testIndexedSearch() throws Exception {

	   

	        //

	        // Prepare a writer to store documents in an in-memory index.

	        //

	        Directory indexDirectory = new RAMDirectory();

	        IndexWriter writer = 

	            new IndexWriter(indexDirectory, new StandardAnalyzer(), true);



	        //

	        // Create a document to be searched and add it to the index.

	        //

	        Document document = new Document();

	        document.add(Field.Text("contents", "Learning tests build confidence!"));

	        writer.addDocument(document);

	        writer.close();



	        //

	        // Search for all indexed documents that contain a search term.

	        //

	        IndexSearcher searcher = new IndexSearcher(indexDirectory);

	        Query query = new TermQuery(new Term("contents", "confidence"));

	        

	        Hits hits = searcher.search(query);

	        assertEquals(1, hits.length());

	    }

	
	
	
}

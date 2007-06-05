package learningJUnit;
import junit.framework.*;
//import org.apache.lucene.*;
import org.apache.lucene.search.*; 
import org.apache.lucene.store.*;
import org.apache.lucene.index.*;
import org.apache.lucene.document.*;
import org.apache.lucene.analysis.standard.*;
import org.apache.lucene.queryParser.*;

public class LuceneLearningTest extends TestCase {

    private IndexSearcher searcher;
    
    public void setUp() throws Exception {
        Directory indexDirectory = new RAMDirectory();
        IndexWriter writer = 
            new IndexWriter(indexDirectory, new StandardAnalyzer(), true);

        Document document = new Document();
        document.add(Field.Text("contents", "Learning tests build confidence!"));
        writer.addDocument(document);
        writer.close();
        
        searcher = new IndexSearcher(indexDirectory);
    }

    public void testSingleTermQuery() throws Exception {
        Query query = new TermQuery(new Term("contents", "confidence"));
        
        Hits hits = searcher.search(query);
        assertEquals(1, hits.length());
    }
    
    public void testBooleanQuery() throws Exception {
        Query query = 
            QueryParser.parse("tests AND confidence", "contents", new StandardAnalyzer());
        
        Hits hits = searcher.search(query);
        assertEquals(1, hits.length());
    }

    public void testWildcardQuery() throws Exception {
        Query query = 
            QueryParser.parse("test*", "contents", new StandardAnalyzer());
        
        Hits hits = searcher.search(query);
        assertEquals(1, hits.length());
    }
}
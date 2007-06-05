import java.lang.*;
import java.io.*;
import java.net.*;
import org.mortbay.util.*;
import org.mortbay.http.*;
import org.mortbay.jetty.servlet.*;
import org.mortbay.http.handler.*;
import org.mortbay.servlet.*;     
      
public class SimpleServer
{
  public static void main (String[] args)
    throws Exception
  {
    // Create the server
    HttpServer server=new HttpServer();
      
    // Create a port listener
    SocketListener listener=new SocketListener();
    listener.setPort(8181);
    server.addListener(listener);

    // Create a context 
    HttpContext context = new HttpContext();
    context.setContextPath("/mystuff/*");
    server.addContext(context);
      
    // Create a context 
    HttpContext context2 = new HttpContext();
    context2.setContextPath("/yourstuff/*");
    server.addContext(context2);
    
    // Create a servlet container
    ServletHandler servlets = new ServletHandler();
    context.addHandler(servlets);

    // Map a servlet onto the container
    servlets.addServlet("Dump","/Dump/*","org.mortbay.servlet.Dump");
      
    // Serve static content from the context
    String home = System.getProperty("jetty.home",".");
    context.setResourceBase(home+"/demo/webapps/jetty/tut/");
    context.addHandler(new ResourceHandler());

    // Start the http server
    server.start ();
  }
}
import java.lang.*;
import java.io.*;
import java.net.*;
import org.mortbay.util.*;
import org.mortbay.http.*;
import org.mortbay.jetty.servlet.*;
import org.mortbay.http.handler.*;
import org.mortbay.servlet.*;     

public class SimpleServer2 {

	  public static void main (String[] args)
	    throws Exception
	  {
	HttpServer server = new HttpServer();
	SocketListener listener = new SocketListener();
	listener.setPort(8080);
	server.addListener(listener);

	HttpContext context = new HttpContext();
	context.setContextPath("/");
	context.setResourceBase("./docroot/");
	context.addHandler(new ResourceHandler());
	server.addContext(context);

	server.start();
	  }
}

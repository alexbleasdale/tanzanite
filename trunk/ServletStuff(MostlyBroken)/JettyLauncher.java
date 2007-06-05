	import org.mortbay.jetty.Server;
	import org.mortbay.jetty.servlet.ServletHolder;
	import org.mortbay.jetty.servlet.Context;
	import org.mortbay.jetty.servlet.DefaultServlet;

	public class JettyLauncher {
	    public static void main(String[] args) throws Exception {
	        Server server = new Server(8089);
	        Context root = new Context(server, "/", Context.SESSIONS);
	        root.setResourceBase(".");
	        root.addServlet(new ServletHolder(new HelloServlet("Ciao")), "/hello/*");
	        root.addServlet(new ServletHolder(new DefaultServlet()),"/");
	        server.start();
	    }
	}


To compile and run:

1. Download Sun's JAXP 1.1 API from:
   http://java.sun.com/xml/xml_jaxp.html

2. Install JAXP. This is merely a matter of unzipping the
   JAXP zip file, then adding the following JAR files
   to the CLASSPATH:

    jaxp.jar, xalan.jar, crimson.jar

3. Compile:

   $  javac Transform.xml

4. Run:
   
   $  java Transform schedule.xml schedule.xslt


The output can be redirected to a file as follows:
   $  java Transform schedule.xml schedule.xslt > schedule.html


TROUBLESHOOTING
---------------
Any problems are likely a CLASSPATH issue. The most common
culprit is an older version of JAXP or some XML parser
on the CLASSPATH or in the Java optional packages
directory (jre/lib/ext). Look for things like "parser.jar"
or "jaxp.jar". These commonly collide with the newer
jaxp.jar included with JAXP 1.1.

To fix, remove the older files from the jre/lib/ext directory,
then make sure the latest JAXP and its related files
are listed FIRST on your CLASSPATH.


<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/> 



<xsl:template match="planets">
  <html>
  <body>
  	<h2>Hello World Example</h2>
	<p>choose a greeting from the dropdown below:</p>  
  		<select>
			<xsl:apply-templates select="planet" />
		</select>
	
	<!-- after you've done that, fill these -->
	
			<div id="other-info-box">
				<xsl:apply-templates select="planet" mode="second" />
			</div> 	
	</body>
  </html>
</xsl:template>





<xsl:template match="planet">
  <option>
  	
	<xsl:call-template name="replace-and-lower">
		<xsl:with-param name="id" select="value" />
    </xsl:call-template>
	 
  	<xsl:apply-templates select="name" />
  </option>
</xsl:template>

<xsl:template match="planet" mode="second">

	<div>
		<xsl:call-template name="replace-and-lower">
			<xsl:with-param name="id" select="id"/>
    	</xsl:call-template>
		
		<div class="greeting"><xsl:apply-templates select="greeting" /></div>
		<div class="contact"><xsl:apply-templates select="contact" /></div>	
	</div>

</xsl:template>

<xsl:template name="replace-and-lower">
	<xsl:param name="id" />
	<xsl:variable name="foo" select="{$id}"/>
	<!-- selects the name node and stores (in lower-case as a variable called $var --> 
	<xsl:variable name="var" select="lower-case(name)"/>
	<!-- runs a simple translation on that variable replacing the space with a hyphen and writes out an attribute -->
	<xsl:attribute name="{$foo}" select="translate($var, ' ', '-')"/>
</xsl:template>

<xsl:template match="name">
  <xsl:value-of select="." />
</xsl:template>

<xsl:template match="greeting">
	<xsl:value-of select="." />
</xsl:template>

<xsl:template match="contact">
	<xsl:value-of select="." />
</xsl:template>

<!-- </xsl:output> -->
</xsl:stylesheet>
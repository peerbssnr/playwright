<?xml version="1.0" encoding="UTF-8"?>
	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:lxslt="http://xml.apache.org/xslt"
    xmlns:redirect="http://xml.apache.org/xalan/redirect"
    xmlns:stringutils="xalan://org.apache.tools.ant.util.StringUtils"
    extension-element-prefixes="redirect">
<xsl:output method="html" indent="yes" encoding="US-ASCII"/>

    <!--
	 @author sandeep lati
	-->

						<!-- NO FRAME ALF REPORTING -->


<xsl:variable name="CSSPath">./resources/reportStyle.css</xsl:variable>
    <xsl:template match="/">
    	        <!-- create the stylesheet.css -->
		<xsl:call-template name="reportStyle.css"/>
				<!-- create the PResults.css for QTP report -->
		<xsl:call-template name="PResults.css"/>
        <html>
            <head>
                <title>ALF Report</title>
                <link rel="stylesheet" type="text/css">
                	<xsl:attribute name="href"><xsl:value-of select="$CSSPath"/></xsl:attribute>
                </link>
            </head>
            <body>
      			<a name="top"/>
      			<xsl:variable name="BackAndBreak">
			 	<tr><td colspan="7"><br/><i><a href="#top">Back to Top</a></i> </td></tr>
			    <tr><td colspan="7" ><hr size="1"  /></td></tr>
			    </xsl:variable>
	           <xsl:apply-templates select="*" mode="controller"/>
	           <table width="100%">
	           <tr><td colspan="5" ><hr size="1"  /></td></tr>
	           <tr>
	           		<th align="middle" width="10%"><a href="#Component"><font color="maroon">Component</font></a> </th>
	           		<th align="middle" width="10%"><a href="#Feature"><font color="maroon">Feature</font></a> </th>
	           		<th align="middle" width="10%"><a href="#Scenario"><font color="maroon">Scenario</font></a> </th>
	           		<th align="middle" width="10%"><a href="#TestCase"><font color="maroon">TestCase</font></a> </th>
	           		<th align="middle" width="10%"><a href="#Action"><font color="maroon">Action</font></a> </th>
	           		<tr><td colspan="5"><br/></td></tr>
	           </tr>
	           </table>
	           <table width="100%">
	           <tr><td colspan="7" ><b><font size="3">Summary</font></b></td></tr>
	           <tr>
	           		<th align="left" width="10%">Tests </th>
	           		<th align="left" width="10%">Success </th>
	           		<th align="left" width="10%">Failures </th>
	           		<th align="left" width="10%">Success rate </th>
	           		<th align="left" width="10%">Time </th>
	           </tr>
	           <tr>
	           		<xsl:variable name="totalTCcount"><xsl:value-of select="sum(current()//..//testcase//count/@total)"/></xsl:variable>
         			<td><xsl:value-of select="$totalTCcount"/></td>
				    <xsl:variable name="passTCcount"><xsl:value-of select="sum(current()//..//testcase//count/@pass)"/></xsl:variable>
			        <td><xsl:value-of select="$passTCcount"/></td>
			        <xsl:variable name="failTCcount"><xsl:value-of select="$totalTCcount - $passTCcount"/></xsl:variable>
					<td><xsl:value-of select="$failTCcount"/></td>
					<xsl:variable name="successRate" select="($totalTCcount - $failTCcount) div $totalTCcount"/>
	           		<td><xsl:value-of select="format-number($successRate,'0.00%')"/></td>
	           		<xsl:variable name="timeCount" select="sum(current()//..//testcase//count/@timecount)"/>
	           		  <td><xsl:call-template name="SetTime">
				 	    	<xsl:with-param name="time"  select="$timeCount" />
				            </xsl:call-template>
				       </td>
	           </tr>
	             <tr><td colspan="5"><br/></td></tr>
	             <tr><td colspan="5" ><hr size="1"  /></td></tr>
	           </table>
       		 <table width="100%">
       		 	<tr><td colspan="7" ><b><font size="3">Component<a name="Component"/></font></b></td></tr>
				<tr>
					  <xsl:call-template name="AddHeadColumns">
            				   <xsl:with-param name="head2"  select="''" />
           			  </xsl:call-template>
				</tr>
			  <xsl:apply-templates select="*" mode="component" />
			  <xsl:copy-of select="$BackAndBreak" />
			  <tr><td colspan="7" ><b><font size="3">Feature<a name="Feature"/></font></b></td></tr>
			 	<tr>
			 		<xsl:call-template name="AddHeadColumns">
            				   <xsl:with-param name="head2"  select="'Component'" />
           			  </xsl:call-template>
			 	 </tr>
	          <xsl:apply-templates select="*" mode="feature" />
	          <xsl:copy-of select="$BackAndBreak" />
	             <tr><td colspan="7" ><b><font size="3">Scenario<a name="Scenario"/></font></b></td></tr>
	             <tr>
	             		<xsl:call-template name="AddHeadColumns">
            				   <xsl:with-param name="head2"  select="'Feature'" />
           			  </xsl:call-template>
	             </tr>
	         <xsl:apply-templates select="*" mode="scenario" />
	         <xsl:copy-of select="$BackAndBreak" />
	         <tr><td colspan="7" ><b><font size="3">TestCase<a name="TestCase"/></font></b></td></tr>
	             <tr>
	             		<xsl:call-template name="AddHeadColumns">
            				   <xsl:with-param name="head2"  select="'Scenario'" />
           			  </xsl:call-template>
	              </tr>
	          <xsl:apply-templates select="*" mode="testcase" />
	          </table>
	          <xsl:copy-of select="$BackAndBreak" />
	         <table width="100%">
	         <tr><td colspan="7" ><b><font size="3">Action<a name="Action"/></font></b></td></tr>
	             <tr>
	              <th align="left">  Name   </th>
	              <th align="center">  Tool Report   </th>
	              <th align="center">  Action Type   </th>
	              <th align="center">  Data row   </th>
	             <th align="left" width="40%">  Remarks   </th>
	              <th align="left">  Status   </th>
	             <th align="left" >  Time  </th>
	           </tr>
	          <xsl:apply-templates select="*" mode="actionName" />
	         </table>
	         <br/>
	         <br/>
	         <a href="#top">Back to Top</a>
	         <table width="100%">
	              <tr> <td width="100%" align="middle">COPYRIGHT &#169; 2009 SOFTWARE AG</td> </tr>
	         </table>
           </body>
        </html>
    </xsl:template>

<xsl:template match="controller" mode="controller">

		<table width="100%" cellspacing="0">
		<tr>
			<td>
				<font size="4" color="#000080" STYLE="display: 'block'; font-family: 'arial'; color: '#000080'; font-weight: '400'; font-size: '20'; margin-top: '12pt'"><b>ALF Report</b></font><br/>
		   		<i>(<xsl:value-of select="@startTime"/>)</i>
			</td>
		<td align="right">
			<img width="30%" alt="logo">
				<xsl:attribute name="src">./resources/images/logo.gif</xsl:attribute>
			</img>
		</td>
		</tr>
		</table>
		<br/>
		<br/>

</xsl:template>

<xsl:template match="component" mode="component">
       <tr>
        <td><xsl:value-of select="@name"/></td>
         <td></td>
         <xsl:variable name="totalTCcount"><xsl:value-of select="sum(current()//feature//scenario//testcase//count/@total)"/></xsl:variable>
         <td><xsl:value-of select="$totalTCcount"/></td>
         <xsl:variable name="passTCcount"><xsl:value-of select="sum(current()//feature//scenario//testcase//count/@pass)"/></xsl:variable>
         <td><xsl:value-of select="$passTCcount"/></td>
		 <td><xsl:value-of select="$totalTCcount - $passTCcount"/></td>
	     <td>
  			<xsl:choose>
			  <xsl:when test="($totalTCcount - $passTCcount) != 0">
				<xsl:call-template name="SetImage">
 	    	   <xsl:with-param name="size"  select="'18%'" />
               <xsl:with-param name="status"  select="'fail'" />
            </xsl:call-template>
			  </xsl:when>
			  <xsl:otherwise>
	    	<xsl:call-template name="SetImage">
 	    	   <xsl:with-param name="size"  select="'18%'" />
               <xsl:with-param name="status"  select="'pass'" />
            </xsl:call-template>
			  </xsl:otherwise>
			</xsl:choose>
	     </td>
		 <xsl:variable name="timeCount" select="sum(current()//feature//scenario//testcase//count/@timecount)"/>
           		<td><xsl:call-template name="SetTime">
 	    	<xsl:with-param name="time"  select="$timeCount" />
            </xsl:call-template>
       </td>
		</tr>
</xsl:template>


<xsl:template match="feature" mode="feature">
  <tr>
        <td><xsl:value-of select="@name"/></td>
         <td> <a> <xsl:value-of select="../@name"/> </a> </td>
          <xsl:variable name="totalTCcount"><xsl:value-of select="sum(current()//scenario//testcase//count/@total)"/></xsl:variable>
         <td><xsl:value-of select="$totalTCcount"/></td>
         <xsl:variable name="passTCcount"><xsl:value-of select="sum(current()//scenario//testcase//count/@pass)"/></xsl:variable>
         <td><xsl:value-of select="$passTCcount"/></td>
		 <td><xsl:value-of select="$totalTCcount - $passTCcount"/></td>
	     <td>
  			<xsl:choose>
			  <xsl:when test="($totalTCcount - $passTCcount) != 0">
	    	<xsl:call-template name="SetImage">
 	    	   <xsl:with-param name="size"  select="'18%'" />
               <xsl:with-param name="status"  select="'fail'" />
            </xsl:call-template>
			  </xsl:when>
			  <xsl:otherwise>
	    	<xsl:call-template name="SetImage">
 	    	   <xsl:with-param name="size"  select="'18%'" />
               <xsl:with-param name="status"  select="'pass'" />
            </xsl:call-template>
			  </xsl:otherwise>
			</xsl:choose>
	     </td>
		 <xsl:variable name="timeCount" select="sum(current()//scenario//testcase//count/@timecount)"/>

           		<td><xsl:call-template name="SetTime">
 	    	<xsl:with-param name="time"  select="$timeCount" />
            </xsl:call-template>
       </td>
		</tr>
</xsl:template>


<xsl:template match="scenario" mode="scenario">
   		 <tr>
       	 <td>
               <a>
                <xsl:attribute name="href">#<xsl:value-of select="@scenarioName"/></xsl:attribute>
                 <xsl:value-of select="@scenarioName"/>
            </a>
         </td>
        <td> <a> <xsl:value-of select="../@name"/> </a> </td>
         <xsl:variable name="totalTCcount"><xsl:value-of select="sum(current()//testcase//count/@total)"/></xsl:variable>
         <td><xsl:value-of select="$totalTCcount"/></td>
         <xsl:variable name="passTCcount"><xsl:value-of select="sum(current()//testcase//count/@pass)"/></xsl:variable>
         <td><xsl:value-of select="$passTCcount"/></td>
		 <td><xsl:value-of select="$totalTCcount - $passTCcount"/></td>
	     <td>
  			<xsl:choose>
			  <xsl:when test="($totalTCcount - $passTCcount) != 0">
	    	<xsl:call-template name="SetImage">
 	    	   <xsl:with-param name="size"  select="'18%'" />
               <xsl:with-param name="status"  select="'fail'" />
            </xsl:call-template>
			  </xsl:when>
			  <xsl:otherwise>
	    	<xsl:call-template name="SetImage">
 	    	   <xsl:with-param name="size"  select="'18%'" />
               <xsl:with-param name="status"  select="'pass'" />
            </xsl:call-template>
			  </xsl:otherwise>
			</xsl:choose>
	     </td>
		 <xsl:variable name="timeCount" select="sum(current()//testcase//count/@timecount)"/>

          <td><xsl:call-template name="SetTime">
 	    	<xsl:with-param name="time"  select="$timeCount" />
            </xsl:call-template>
       </td>
	  </tr>
</xsl:template>


<xsl:template match="testcase" mode="testcase">

       <tr>
        <td>
             <a>
                <xsl:attribute name="href" >#<xsl:value-of select="../@scenarioName"/> >> <xsl:value-of select="@name"/></xsl:attribute>
                 <xsl:value-of select="@name"/>
            </a>
         </td>
        <td> <a> <xsl:value-of select="../@scenarioName"/> </a> </td>
        <td><xsl:value-of select="count(current()//result)"/></td>
        <td><xsl:value-of select="count(current()//result[@value='true'])"/></td>
        <xsl:variable name="falsecount"><xsl:value-of select="count(current()//result[@value='false'])"/></xsl:variable>
        <td><xsl:value-of select="$falsecount"/></td>
  		<td>
  			<xsl:choose>
			  <xsl:when test="$falsecount != 0">
	    	<xsl:call-template name="SetImage">
 	        	<xsl:with-param name="size"  select="'18%'" />
               <xsl:with-param name="status"  select="'fail'" />
            </xsl:call-template>
			  </xsl:when>
			  <xsl:otherwise>
			   <xsl:call-template name="SetImage">
	 	    	<xsl:with-param name="size"  select="'18%'" />
	               <xsl:with-param name="status"  select="'pass'" />
	            </xsl:call-template>
			  </xsl:otherwise>
			</xsl:choose>
  		</td>
  		<xsl:variable name="timeCount" select="sum(current()//result/@timetaken)"/>
  		<td><xsl:call-template name="SetTime">
 	    	<xsl:with-param name="time"  select="$timeCount" />
            </xsl:call-template>
       </td>
       </tr>
</xsl:template>

 <xsl:template match="action" mode="actionName">
    	  	<xsl:variable name="type1"> <xsl:value-of select="preceding-sibling::action/../../../@scenarioName"/> </xsl:variable>
			<xsl:variable name="type2"> <xsl:value-of select="../../../@scenarioName"/> </xsl:variable>
		 <xsl:if test="$type1 != $type2 ">
           <tr><td colspan="7">
                 <a>
           			<xsl:attribute name="name" ><xsl:value-of select="$type2"/></xsl:attribute>
           		</a>
           		<a>
           			<xsl:attribute name="name" ><xsl:value-of select="$type2"/> >> <xsl:value-of select="../../@name"/></xsl:attribute>
           		</a>
           <b><h5><xsl:value-of select="$type2"/> >> <xsl:value-of select="../../@name"/></h5></b>
           </td></tr>
         </xsl:if>
  		 <tr>
  		   <td>
  		    <xsl:choose>

	<xsl:when test="@actionLanguage = 'QTP'">
  		<xsl:variable name="path"><xsl:value-of select="../../../../../@name"/>/<xsl:value-of select="../../../../@name"/>/<xsl:value-of select="../../../@scenarioId"/>/<xsl:value-of select="../../@name"/>/<xsl:value-of select="@id"/></xsl:variable>
  		   	<a>
  		   		<xsl:attribute name="href"><xsl:value-of select="concat('./',$path,'/screen-report.html')"/></xsl:attribute>
  		   		<xsl:attribute name="target">_blank</xsl:attribute>
  		   		<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
  		   		<xsl:value-of select="@name"/>
  		   	</a>
  		<xsl:call-template name="GenerateScreenReport"/>
  	</xsl:when>

	<xsl:when test="@actionLanguage = 'SELENIUM'">
  		<xsl:variable name="path"><xsl:value-of select="../../../../../@name"/>/<xsl:value-of select="../../../../@name"/>/<xsl:value-of select="../../../@scenarioId"/>/<xsl:value-of select="../../@name"/>/<xsl:value-of select="@id"/></xsl:variable>
  		   	<a>
  		   		<xsl:attribute name="href"><xsl:value-of select="concat('./',$path,'/screen-report.html')"/></xsl:attribute>
  		   		<xsl:attribute name="target">_blank</xsl:attribute>
  		   		<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
  		   		<xsl:value-of select="@name"/>
  		   	</a>
  		<xsl:call-template name="GenerateScreenReport"/>
  	</xsl:when>

	<xsl:when test="@actionLanguage = 'CNL'">
  		<xsl:variable name="path"><xsl:value-of select="../../../../../@name"/>/<xsl:value-of select="../../../../@name"/>/<xsl:value-of select="../../../@scenarioId"/>/<xsl:value-of select="../../@name"/>/<xsl:value-of select="@id"/></xsl:variable>
  		   	<a>
  		   		<xsl:attribute name="href"><xsl:value-of select="concat('./',$path,'/screen-report.html')"/></xsl:attribute>
  		   		<xsl:attribute name="target">_blank</xsl:attribute>
  		   		<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
  		   		<xsl:value-of select="@name"/>
  		   	</a>
  		<xsl:call-template name="GenerateScreenReport"/>
  	</xsl:when>

	<xsl:when test="@actionLanguage = 'FEST'">
  		<xsl:variable name="path"><xsl:value-of select="../../../../../@name"/>/<xsl:value-of select="../../../../@name"/>/<xsl:value-of select="../../../@scenarioId"/>/<xsl:value-of select="../../@name"/>/<xsl:value-of select="@id"/></xsl:variable>
  		   	<a>
  		   		<xsl:attribute name="href"><xsl:value-of select="concat('./',$path,'/screen-report.html')"/></xsl:attribute>
  		   		<xsl:attribute name="target">_blank</xsl:attribute>
  		   		<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
  		   		<xsl:value-of select="@name"/>
  		   	</a>
  		<xsl:call-template name="GenerateScreenReport"/>
  	</xsl:when>

			<xsl:when test="@actionLanguage = 'IS_Service'">
  		   		<xsl:value-of select="@name"/>
  		   	</xsl:when>
  		   	<xsl:when test="@actionLanguage = 'VENUS'">
  		   		<xsl:value-of select="@name"/>
  		   	</xsl:when>
  		   	<xsl:otherwise>
  		   		<xsl:value-of select="@name"/>
			</xsl:otherwise>
  		   	 </xsl:choose>
  		   </td>
  		   <td align="center">
  		   <xsl:variable name="toolreport"><xsl:value-of select="result/@toolSpecificReport"/></xsl:variable>
  		   <xsl:if test="$toolreport != 'null'">
  		   	  <a>
  		   	    <xsl:attribute name="href"><xsl:value-of select="concat('.',$toolreport,'?actionid=',@id)"/></xsl:attribute>
  		   	    <xsl:attribute name="target">_blank</xsl:attribute>
  		   		<xsl:value-of select="@actionLanguage"/>
  		   	  </a>
  		   	</xsl:if>

  		   	<xsl:if test="$toolreport = 'null'">
  		   		<xsl:value-of select="@actionLanguage"/>
  		   	</xsl:if>
  		   </td>
  		   <td align="center"><xsl:value-of select="@mode"/> </td>
  		   <td align="center">
  		   <xsl:variable name="datareport"><xsl:value-of select="datarow/@file"/></xsl:variable>
           <a>
  		   		<xsl:attribute name="href"><xsl:value-of select="concat('.',$datareport)"/></xsl:attribute>
  		   	    <xsl:attribute name="target">_blank</xsl:attribute>
  		   			<xsl:value-of select="@dataRow"/>
  		   		</a>
  		    </td>
  		   <td ><xsl:value-of select="result/@remarks"/> </td>
   	  	   <xsl:apply-templates select="*" mode="actionstatus" />
		</tr>
 </xsl:template>

 <xsl:template match="result" mode="actionstatus">
       <xsl:if test="@value = 'true'">
       		<td>
			<xsl:call-template name="SetImage">
			<xsl:with-param name="size"  select="'30%'" />
               <xsl:with-param name="status"  select="'pass'" />
            </xsl:call-template>
			</td>
      </xsl:if>
  		<xsl:if test="@value = 'false'">
       		<td>
 	    	<xsl:call-template name="SetImage">
 	    	<xsl:with-param name="size"  select="'30%'" />
               <xsl:with-param name="status"  select="'fail'" />
            </xsl:call-template>
       		</td>
      </xsl:if>
      <td><xsl:call-template name="SetTime">
 	    	<xsl:with-param name="time"  select="@timetaken" />
            </xsl:call-template>
       </td>

</xsl:template>

<xsl:template name="GenerateScreenReport">
	 <xsl:variable name="path">../<xsl:value-of select="../../../../../@name"/>/<xsl:value-of select="../../../../@name"/>/<xsl:value-of select="../../../@scenarioId"/>/<xsl:value-of select="../../@name"/>/<xsl:value-of select="@id"/></xsl:variable>
	  <redirect:write file="{$path}/screen-report.html">
         <html>
         	<head><title>ALF ScreenShot Report</title></head>
         	      <link rel="stylesheet" type="text/css">
                	<xsl:attribute name="href">../../../../../<xsl:value-of select="$CSSPath"/></xsl:attribute>
                </link>
         	<body>
         		<table width="100%">
         			<tr><td><b><font size="2">ALF ScreenShot Report >> <xsl:value-of select="../@name"/></font></b></td></tr>
         			<tr><td width="100%" ><hr size="1"  /></td></tr>
         		</table>
         		<table width="100%">
         			<tr><td></td></tr>
         			<tr align="left"><th>TimeStamp</th><th>Description</th><th>Status</th><th>Image</th></tr>
         			<tr><td colspan="4"><h5>No of setps avilable are : <xsl:value-of select="count(current()/step)"/></h5></td></tr>
				<xsl:apply-templates select="*" mode="screenshots"/>
		</table>
         	</body>
         </html>
      </redirect:write>
</xsl:template>

<xsl:template match="step" mode="screenshots">

         			<tr>
         			<td align="left"><xsl:value-of select="@timestamp"/></td>
         				<td width="60%"><xsl:value-of select="@description"/></td>
         				<td align="middle">
         				   <xsl:choose>
					         <xsl:when test="@result = 'PASS'">
					        	 <img align="middle" width="30%" alt="PassArrow">
					        	 	<xsl:attribute name="src">../../../../../resources/images/passArrow.jpeg</xsl:attribute>
					        	 </img>
					         </xsl:when>
					         <xsl:when test="@result = 'FAIL'">
					        	 <img align="middle" width="30%" alt="FailArrow">
					        	 	<xsl:attribute name="src">../../../../../resources/images/failArrow.jpeg</xsl:attribute>
					        	 </img>
					         </xsl:when>
					         <xsl:when test="@result = 'WARNING'">
					        	<img align="middle" width="30%" alt="WarningArrow">
					        		<xsl:attribute name="src">../../../../../resources/images/warningArrow.jpeg</xsl:attribute>
					        	 </img>
					         </xsl:when>
					         <xsl:otherwise>
								<xsl:value-of select="@result"/>
							 </xsl:otherwise>
					      </xsl:choose>
        				</td>
         				<td>
         				<a>
         					<xsl:attribute name="href"><xsl:value-of select="@snapshot"/></xsl:attribute>
         					<xsl:attribute name="target">_blank</xsl:attribute>
         					<img align="left" width="8%" alt="ScreenShot">
         				    	<xsl:attribute name="src"><xsl:value-of select="@snapshot"/></xsl:attribute>
         					</img>
         			    </a>
         				</td>
         			</tr>
</xsl:template>

<xsl:template name="AddHeadColumns">
   <xsl:param name="head2"/>
	   <xsl:choose>
         <xsl:when test="$head2 = ''">
        	<th align="left" colspan="2"> Name  </th>
        	<th align="left"> Tests  </th>
         </xsl:when>
         <xsl:otherwise>
         	<th align="left"> Name  </th>
		    <th align="left"> <xsl:value-of select="$head2"/>  </th>
		    	   	  <xsl:choose>
				         <xsl:when test="$head2 = 'Scenario'">
				        	<th align="left"> Actions  </th>
				         </xsl:when>
				         <xsl:otherwise>
				         	<th align="left"> Tests  </th>
						 </xsl:otherwise>
				      </xsl:choose>
		 </xsl:otherwise>
      </xsl:choose>
 		<th align="left"> Success  </th>
		<th align="left"> Failures </th>
		<th align="left"> Status </th>
		<th align="left"> Time </th>
</xsl:template>

<xsl:template name="reportStyle.css">
    <redirect:write file="reportStyle.css">

body {
    font:normal 68% verdana,arial,helvetica;
    color:#000000;
    }

table tr td, table tr th {
    font-size: 75%;
    }
table tr th {
    font-size: 85%;
    font-style:bold;
    background:#a6caf0;
    }
table tr td {
    font-size: 80%;
    background:#eeeee0;
    }
table.details tr th{
    font-weight: bold;
    text-align:left;
    background:#a6caf0;
}
table.details tr td{
    background:#eeeee0;
        }

p {
    line-height:1.5em;
    margin-top:0.5em; margin-bottom:1.0em;
}
h1 {
    margin: 0px 0px 5px; font: 165% verdana,arial,helvetica
}
h2 {
    margin-top: 1em; margin-bottom: 0.5em; font: bold 125% verdana,arial,helvetica
}
h3 {
    margin-bottom: 0.5em; font: bold 115% verdana,arial,helvetica
}
h4 {
    margin-bottom: 0.5em; font: bold 100% verdana,arial,helvetica
}
h5 {
				   font-weight: bold;
				   color: maroon;
				   font:size:95%;
				   margin-bottom: 0.1em;
				   background:#D4D0C8;
				}
h6 {
    margin-bottom: 0.5em; font: bold 100% verdana,arial,helvetica
}
a { text-decoration:none }
.Error {
    font-weight:bold; color:red;
}
.Failure {
    font-weight:bold; color:purple;
}
.Properties {
  text-align:right;
}

    </redirect:write>
</xsl:template>

<xsl:template name="PResults.css">
    <redirect:write file="PResults.css">
     .hl_qt  { color: white; font-size: 24pt; font-family: Mic Shell Dlg; background-color: #666; text-align: center; padding: 0px 3px 3px }
.hl0
 { color: #999; font-weight: bold; font-size: 18pt; font-family: Mic Shell Dlg; text-align: center; padding: 2px 3px; border-bottom: 3px dotted #999 }
.hl0_name { color: #999; font-weight: normal; font-size: 18pt; font-family: Mic Shell Dlg; text-align: center; padding: 2px 3px; border-bottom: 3px dotted #999 }
.hl1
{
    COLOR: #669;
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 16pt;
    FONT-WEIGHT: bold
}
.hl2
{
    COLOR: #669;
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 13pt;
    FONT-WEIGHT: bold
}
.hl3 { color: #666; font-weight: bold; font-size: 10pt; font-family: Mic Shell Dlg; height: 28px }
.hl1name
{
    COLOR: #669;
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 16pt;
    FONT-WEIGHT: normal
}
.bg_yellow
{
    BACKGROUND-COLOR: #fc0
}
.bg_gray_eee
{
    BACKGROUND-COLOR: #eee
}
.bg_gray_ccc { background-color: #ccc }
.bg_gray_999 { background-color: #999 }
.bg_midblue
{
    BACKGROUND-COLOR: #99c
}
.bg_ligtblue
{
    BACKGROUND-COLOR: #ccf
}
.bg_darkblue
{
    BACKGROUND-COLOR: #669
}
.text
 { font-size: 10pt; font-family: Mic Shell Dlg }
.text_small
{
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 8pt
}
.text_pitzi
{
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 6.5pt
}
.text_bold
{
    FONT-FAMILY: Mic Shell Dlg;
    FONT-WEIGHT: bold
}


.Failed
{
    COLOR: #f03;
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 10pt;
    FONT-WEIGHT: bold
}
.FailedLow
{
    COLOR: #f03;
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 10pt;
}

.FailedHigh
{
    COLOR: #f03;
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 16pt;
    FONT-WEIGHT: bold
}
.Passed
{
    COLOR: #096;
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 10pt;
    FONT-WEIGHT: bold
}
.PassedHigh
{
    COLOR: #096;
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 16pt;
    FONT-WEIGHT: bold
}

.Done
{
    COLOR: #999;
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 10pt;
    FONT-WEIGHT: bold
}
.DoneHigh
 { color: #999; font-weight: bold; font-size: 16pt; font-family: Mic Shell Dlg }
.Information
{
    COLOR: #999;
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 10pt;
    FONT-WEIGHT: bold
}
.InformationHigh
{
    COLOR: #999;
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 16pt;
    FONT-WEIGHT: bold
}
.Warning
{
    COLOR: #f96;
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 10pt;
    FONT-WEIGHT: bold
}
.WarningHigh
{
    COLOR: #f96;
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 16pt;
    FONT-WEIGHT: bold
}
.tablehl
{
    BACKGROUND-COLOR: #eee;
    COLOR: #669;
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 10pt;
    FONT-WEIGHT: bold;
    LINE-HEIGHT: 14pt
}
A
{
    COLOR: #33f;
    FONT-FAMILY: Mic Shell Dlg
}
A:hover
{
    COLOR: #f03;
    FONT-FAMILY: Mic Shell Dlg;
    FONT-WEIGHT: bold
}
.Condition
{
    COLOR: #333399;
    FONT-FAMILY: Mic Shell Dlg;
    FONT-SIZE: 10pt;
    FONT-WEIGHT: bold
}
body { font-family: Mic Shell Dlg }


.tooltiptitle{COLOR: #FFFFFF; TEXT-DECORATION: none; CURSOR: Default; font-family: arial; font-weight: bold; font-size: 8pt}
.tooltipcontent{COLOR: #000000; TEXT-DECORATION: none; CURSOR: Default; font-family: arial; font-size: 8pt}

#ToolTip{position:absolute; width: 100px; top: 0px; left: 0px; z-index:4; visibility:hidden;}
.brake { font-size: 1px; font-family: Mic Shell Dlg; background-color: #366; border-top: 15px solid white; border-bottom: 15px solid white; width: 100%; height: 35px }
.iteration_border { padding-top: 5px; padding-bottom: 5px; padding-left: 10px; border-top: 3px solid #999; border-bottom: 3px solid #999; border-left: 3px solid #999 }
.iteration_head { color: white; font-weight: bold; font-size: 12px; font-family: Mic Shell Dlg; background-color: #999; text-align: center; padding: 3px 3px 1px }
.action_border  { padding-top: 5px; padding-bottom: 5px; padding-left: 10px; border-top: 3px solid #ccc; border-bottom: 3px solid #ccc; border-left: 3px solid #ccc }
.action_head  { color: black; font-weight: bold; font-size: 12px; font-family: Mic Shell Dlg; background-color: #ccc; text-align: center; padding: 3px 3px 1px }
.table_frame { padding: 3px; border: solid 1px #669 }
.table_hl   { color: #669; font-weight: bold; font-size: 10pt; line-height: 14pt; font-family: Mic Shell Dlg; padding-right: 2px; padding-left: 2px; border-top: 1px solid #669; border-bottom: 1px solid #669 }
.table_cell  { vertical-align: top; padding: 3px; border-bottom: 1px solid #eee; overflow: visible }
p { font-size: 8pt; font-family: Mic Shell Dlg }
td { font-size: 8pt; font-family: Mic Shell Dlg }
ul { font-size: 8pt; font-family: Mic Shell Dlg }

    </redirect:write>
</xsl:template>



<xsl:template name="SetImage">
   <xsl:param name="size"/>
   <xsl:param name="status"/>
		<xsl:choose>
         <xsl:when test="$status = 'pass'">
        	<img align="middle" src="./resources/images/right.bmp" alt="pass">
        		<xsl:attribute name="width"><xsl:value-of select="$size"/> </xsl:attribute>
        	</img>
         </xsl:when>
         <xsl:when test="$status = 'fail'">
        	<img align="middle" src="./resources/images/failMark.JPG" alt="pass">
        	   		<xsl:attribute name="width"><xsl:value-of select="$size"/> </xsl:attribute>
        	</img>
         </xsl:when>
         <xsl:otherwise>
         	   <xsl:value-of select="$status"/>
		 </xsl:otherwise>
      </xsl:choose>
</xsl:template>

	<!-- Sets the time in specific format(HH MM SS)-->
<xsl:template name="SetTime">
   <xsl:param name="time"/>
   <xsl:choose>
   	    <xsl:when test="floor($time div 60) > '59'">
   	    	<xsl:value-of select="concat(floor($time div 3600),'h ',floor(($time div 60) mod 60),'m ',$time mod 60,'s')"/>
   	    </xsl:when>
   	    <xsl:when test="floor($time div 60) > '0'">
   	    	<xsl:value-of select="concat(floor($time div 60),'m ',$time mod 60,'s')"/>
   	    </xsl:when>
   	    <xsl:otherwise>
   			<xsl:value-of select="concat($time mod 60,'s')"/>
   	    </xsl:otherwise>
   </xsl:choose>

</xsl:template>
</xsl:stylesheet>
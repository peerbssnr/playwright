<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:redirect="http://xml.apache.org/xalan/redirect"
	xmlns:stringutils="xalan://org.apache.tools.ant.util.StringUtils"
	extension-element-prefixes="redirect dyn" xmlns:dyn="http://exslt.org/dynamic">


	<xsl:output method="html" indent="yes" encoding="US-ASCII" />
	<xsl:variable name="CSSPath">
		../resources/reportStyle.css
	</xsl:variable>
	<xsl:template name="logo">
		<xsl:param name="backdir" />
		<table width="100%">
			<tr>
				<th>
					<h2>ALF Report</h2>
				</th>
				<td align="right">
					<img width="20%">
						<xsl:attribute name="src">
							<xsl:value-of select="$backdir" />/images/logo.gif</xsl:attribute>
					</img>
				</td>
			</tr>
			
		</table>
	</xsl:template>
	<xsl:variable name="copyright">
		<table border="0" width="100%" height="100%">
			<tr>
				<td />
			</tr>
		</table>
		<table width="100%" align="center" class="alfTable table table-hover">
			<tr>
				<td width="100%" align="middle">COPYRIGHT &#169; 2016 SOFTWARE AG</td>
			</tr>
		</table>
	</xsl:variable>
	<xsl:template match="/">
	
	
	
		<!-- Create Style Sheet -->
		<redirect:write file="./reportStyle.css">
			<xsl:call-template name="reportStyle.css" />
		</redirect:write>


		<!-- Create Style Sheet -->
		<redirect:write file="./PResults.css">
			<xsl:call-template name="PResults.css" />
		</redirect:write>

		<!-- Create project-overview.html -->
		<redirect:write file="./project-overview.html">
			<xsl:call-template name="project-overview.html" />
		</redirect:write>

		<!-- Create index.html -->
		<html>
			<head>
				<title>ALF Report</title>
			</head>
			<frameset cols="100%">
				<frame src="./resources/project-overview.html" name="rightFrame" />
				<noframes>
					<h2>Frame Alert</h2>
					<p>
						This document is designed to be viewed using the frames feature.
						If you see this message,
						you are
						using a non-frame-capable web
						client.
					</p>
				</noframes>
			</frameset>
		</html>
	</xsl:template>

	<xsl:template name="project-overview.html">
		<html>
			<head>
				<title>ALF Report</title>
				<link rel="stylesheet" type="text/css" href="reportStyle.css" />
				<link rel="stylesheet" type="text/css" href="lib/bootstrap.min.css" />
				<link rel="stylesheet" type="text/css" href="lib/alfReport.css" />
			</head>
			<body>
			
				<xsl:call-template name="logo">
					<xsl:with-param name="backdir" select="'.'" />
				</xsl:call-template>
<table align="center">
<tr>
			<td align="middle" valign="middle">
				<b>
					<h1>
						<a>
							<xsl:attribute name="href">./project-overview.html</xsl:attribute>
							<xsl:attribute name="target">rightFrame</xsl:attribute>
							<xsl:value-of select="RecorderExecutionReport/@name" />
						</a>
					</h1>
				</b>
			</td>
		</tr>
		<tr>
			<td align="middle">
				<i>
					<h6>
						<sup>
							ALF Version:
							<xsl:value-of select="RecorderExecutionReport/@alfVersion" />
						</sup>
					</h6>
				</i>
			</td>
		</tr>
		<tr>
			<td align="middle">
				<i>
					<h6>
						<sup>
							Execution Start Time:
							<xsl:value-of select="RecorderExecutionReport/@startTime" />
						</sup>
					</h6>
				</i>
			</td>
		</tr>
		</table>
				<div align="right"><a style="font-size: 13;">
				<xsl:attribute name="target">blank</xsl:attribute>
				<xsl:attribute name="href">../../reports_backup</xsl:attribute>
				See Previous Reports
				</a></div>
				<br/>
				<table width="100%" class="alfTable table table-hover">
					<thead class="trhead">
						<th align="left" width="10%">Actions </th>
						<th align="left" width="10%">Success </th>
						<th align="left" width="10%">Failures </th>
						<th align="left" width="10%">Success rate </th>
						<th align="left" width="10%">Time </th>
					</thead>

					<tr>

						<!-- testcases such as before suite/ after suite are not considered 
							while counting the total number of cases -->
						<xsl:variable name="totalTCcount">
							<xsl:value-of
								select="count(//teststep)" />
						</xsl:variable>
						<xsl:variable name="passTCcount">
							<xsl:value-of
								select="count(//teststep[@status='true'])" />
						</xsl:variable>
						<xsl:variable name="failTCcount">
							<xsl:value-of
								select="$totalTCcount - $passTCcount" />
						</xsl:variable>
						<xsl:variable name="successRate"
							select="($totalTCcount - $failTCcount) div $totalTCcount" />
						<xsl:variable name="timeCount"
							select="sum(current()//..//teststep/@timeCount)" />

						<xsl:attribute name="class">
							<xsl:value-of select="''" />
						</xsl:attribute>

						<td>
							<xsl:value-of select="$totalTCcount" />
						</td>
						<td>
							<xsl:value-of select="$passTCcount" />
						</td>
						<td>
							<xsl:value-of select="$failTCcount" />
						</td>
						<td>
							<xsl:value-of select="format-number($successRate,'0.00%')" />
						</td>
						<td>
							<xsl:call-template name="SetTime">
								<xsl:with-param name="time" select="$timeCount" />
							</xsl:call-template>
						</td>
					</tr>
				</table>
				<br />
				<br />

				<!-- Setting the headings -->

				<xsl:call-template name="set.heading">
					<xsl:with-param name="heading" select="'CNL Actions'" />
				</xsl:call-template>
				<table width="100%" class="alfTable table table-hover">
					<xsl:call-template name="AddHeadColumns" >
							<xsl:with-param name="type" select="testcase"></xsl:with-param>
					</xsl:call-template>

					<!-- List test suites -->

					<xsl:apply-templates
						select="/RecorderExecutionReport/teststep"
						mode="childTestStepListing">
						<xsl:with-param name="resourcesFolderPath" select="'./'" />
					</xsl:apply-templates>
				</table>
				<br />
				<br />
				<xsl:copy-of select="$copyright" />
			</body>
		</html>
	</xsl:template>

	<xsl:template match="teststep" mode="childTestStepListing">
		<xsl:param name="parentFolderPath" />
		<xsl:param name="resourcesFolderPath" />

		<xsl:variable name="actionLanguage"
			select="translate(@actionLanguage, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" />

		<xsl:variable name="toolSpecificReport">
			<xsl:value-of select="@toolSpecificReport" />
		</xsl:variable>

		<xsl:variable name="status" select="@status" />

		<xsl:variable name="timeCount" select="@timeCount" />

		<xsl:variable name="remarks" select="@remarks" />

		<tr>
			<xsl:attribute name="class">
				<xsl:value-of select="''" />
			</xsl:attribute>
			<td>
						<a>
							<xsl:attribute name="href">../<xsl:value-of
								select="@name" />/screen-report.html</xsl:attribute>
							<xsl:attribute name="target">_blank</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="@description" />
							</xsl:attribute>
							<xsl:value-of select="@name" />
						</a>
						<xsl:call-template name="GenerateScreenReport">
							<xsl:with-param name="parentFolderPath" select="$parentFolderPath" />
							<xsl:with-param name="resourcesFolderPath"
								select="concat('../', $resourcesFolderPath,'resources')" />
						</xsl:call-template>
			</td>
			<td align="left">
				<xsl:value-of select="@description" />
			</td>
			<td align="center">
					<a>
						<xsl:attribute name="href">../<xsl:value-of
							select="@name" />/<xsl:value-of select="$toolSpecificReport" />
						</xsl:attribute>
						<xsl:attribute name="target">_blank</xsl:attribute>
						<xsl:value-of select="$actionLanguage" />
					</a>
			</td>
			<td>
				<xsl:call-template name="SetImage">
					<xsl:with-param name="size" select="'16%'" />
					<xsl:with-param name="resourcesFolderPath"
						select="$resourcesFolderPath" />
					<xsl:with-param name="status" select="$status" />
				</xsl:call-template>
			</td>
			<td>
				<xsl:call-template name="SetTime">
					<xsl:with-param name="time" select="@timeCount" />
				</xsl:call-template>
			</td>
			<td style="white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-wrap: break-word;"><xsl:call-template name="getRemarks"> 
			<xsl:with-param name="text" select="$remarks"/></xsl:call-template></td>
		</tr>
	</xsl:template>
	
	<xsl:template name="getRemarks">
  		 <xsl:param name="text"/>
		   <xsl:variable name="startText" select="substring-before(concat($text,'&amp;#10;'),'&amp;#10;')" />
   			<xsl:variable name="nextText" select="substring-after($text,'&amp;#10;')"/>
   			<xsl:if test="normalize-space($startText)">
       <xsl:value-of select="$startText"/>
       <xsl:if test="normalize-space($nextText)">
         <br />
      </xsl:if>
   </xsl:if>

   <xsl:if test="contains($text,'&amp;#10;')">
      <xsl:call-template name="getRemarks">
         <xsl:with-param name="text" select="$nextText"/>
	</xsl:call-template>
   </xsl:if>
</xsl:template>

	<xsl:template name="GenerateScreenReport">
		<xsl:param name="parentFolderPath" />
		<xsl:param name="resourcesFolderPath" />

		<redirect:write file="{$parentFolderPath}/../{@name}/screen-report.html">
			<html>
				<head>
					<title>ALF ScreenShot Report</title>
				</head>
				<link>
					<xsl:attribute name="rel">stylesheet</xsl:attribute>
					<xsl:attribute name="type">text/css</xsl:attribute>
					<xsl:attribute name="href">
						<xsl:value-of select="$resourcesFolderPath" />/reportStyle.css</xsl:attribute>
				</link>
				<link>
					<xsl:attribute name="rel">stylesheet</xsl:attribute>
					<xsl:attribute name="type">text/css</xsl:attribute>
					<xsl:attribute name="href">
						<xsl:value-of select="$resourcesFolderPath" />lib/bootstrap.min.css</xsl:attribute>
				</link>
				<link>
					<xsl:attribute name="rel">stylesheet</xsl:attribute>
					<xsl:attribute name="type">text/css</xsl:attribute>
					<xsl:attribute name="href">
						<xsl:value-of select="$resourcesFolderPath" />lib/alfReport.css</xsl:attribute>
				</link>
				<body>
					<table width="100%">
						<tr>
							<td>
								<b>
									<font size="2">
										ALF ScreenShot Report >>
										<xsl:value-of select="../@id" />
									</font>
								</b>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<hr size="1" />
							</td>
						</tr>
					</table>
					<table width="100%" class="screen">
						<tr>
							<td />
						</tr>
						<tr align="left">
							<th>Timestamp</th>
							<th>Description</th>
							<th>Status</th>
							<th>Image</th>
						</tr>
						<tr>
							<td colspan="4">
								<h5>
									No of steps avilable are :
									<xsl:value-of select="count(current()/step)" />
								</h5>
							</td>
						</tr>
						<xsl:apply-templates select="step" mode="screenshots">
							<xsl:with-param name="resourcesFolderPath">
								<xsl:value-of select="$resourcesFolderPath" />
							</xsl:with-param>
						</xsl:apply-templates>
					</table>
					<xsl:copy-of select="$copyright" />
				</body>
			</html>
		</redirect:write>
	</xsl:template>

	<xsl:template match="step" mode="screenshots">
		<xsl:param name="resourcesFolderPath" />
		<tr>
			<xsl:attribute name="class">
				<xsl:value-of select="@result" />
			</xsl:attribute>
			<td align="left">
				<xsl:value-of select="@timestamp" />
			</td>
			<td align="left" style="word-break: break-word;">
				<xsl:value-of select="@description" />
			</td>
			<td align="middle">
				<xsl:choose>
					<xsl:when test="@result = 'PASS'">
						<img align="middle" width="30%" alt="PassArrow">
							<xsl:attribute name="src">
								<xsl:value-of select="$resourcesFolderPath" />/images/passArrow.jpeg</xsl:attribute>
						</img>
					</xsl:when>
					<xsl:when test="@result = 'FAIL'">
						<img align="middle" width="30%" alt="FailArrow">
							<xsl:attribute name="src">
								<xsl:value-of select="$resourcesFolderPath" />/images/failArrow.jpeg</xsl:attribute>
						</img>
					</xsl:when>
					<xsl:when test="@result = 'WARNING'">
						<img align="middle" width="30%" alt="WarningArrow">
							<xsl:attribute name="src">
								<xsl:value-of select="$resourcesFolderPath" />/images/warningArrow.jpeg</xsl:attribute>
						</img>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@result" />
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td align="left">
				<xsl:if test="(@snapshot != 'none') and not(contains(@description, '[ REST Command ='))">
				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="@snapshot" />
					</xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>
					<img align="left" width="90px" alt="ScreenShot">
						<xsl:attribute name="src">
							<xsl:value-of select="@snapshot" />
						</xsl:attribute>
					</img>
				</a>
				</xsl:if>
				<xsl:if test="(@snapshot != 'none') and (contains(@description, '[ REST Command ='))">
				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="@snapshot" />
					</xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>RestReport
				</a>
				</xsl:if>
			</td>
		</tr>
	</xsl:template>
	
		<xsl:template name="setTimeStatus">
	<xsl:param name="timeStatus"/>
	<xsl:if test="$timeStatus > 0">
	<label style="color:red;" title="Execution took more time than the average execution time of this asset on this machine"> +
	<xsl:choose>
			<xsl:when test="floor($timeStatus div 60) > '59'">
				<xsl:value-of
					select="concat(floor($timeStatus div 3600),'h ',floor(($timeStatus div 60) mod 60),'m ',$timeStatus mod 60,'s')" />
			</xsl:when>
			<xsl:when test="floor($timeStatus div 60) > '0'">
				<xsl:value-of select="concat(floor($timeStatus div 60),'m ',$timeStatus mod 60,'s')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($timeStatus mod 60,'s')" />
			</xsl:otherwise>
		</xsl:choose>
		</label>
	</xsl:if>
	<xsl:if test="$timeStatus &lt; 1">
	<label style="color:green;" title="Execution took less time than the average execution time of this asset on this machine"> 
	<xsl:choose>
			<xsl:when test="floor($timeStatus div 60) > '59'">
				<xsl:value-of
					select="concat(floor($timeStatus div 3600),'h ',floor(($timeStatus div 60) mod 60),'m ',$timeStatus mod 60,'s')" />
			</xsl:when>
			<xsl:when test="floor($timeStatus div 60) > '0'">
				<xsl:value-of select="concat(floor($timeStatus div 60),'m ',$timeStatus mod 60,'s')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($timeStatus mod 60,'s')" />
			</xsl:otherwise>
		</xsl:choose>
		</label>
	</xsl:if>
	</xsl:template>
	


	<xsl:template name="set.heading">
		<xsl:param name="heading" />
		<table width="100%">
			<tr>
				<td colspan="10">
					<b>
						<h3>
							<xsl:value-of select="$heading" />
						</h3>
					</b>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="SetImage">
		<xsl:param name="status" />
		<xsl:param name="size" />
		<xsl:param name="resourcesFolderPath" />

		<xsl:choose>
			<xsl:when test="$status = 'pass'">
				<img align="middle" alt="pass" title="Success">
					<xsl:attribute name="src">
						<xsl:value-of select="$resourcesFolderPath" />/images/right.png</xsl:attribute>
					<xsl:attribute name="width">
						<xsl:value-of select="$size" />
					</xsl:attribute>
				</img>
			</xsl:when>
			<xsl:when test="$status = 'fail'">
				<img align="middle" alt="fail" title="Failed">
					<xsl:attribute name="src">
						<xsl:value-of select="$resourcesFolderPath" />/images/failMark.png</xsl:attribute>
					<xsl:attribute name="width">
						<xsl:value-of select="$size" />
					</xsl:attribute>
				</img>
			</xsl:when>
			<xsl:when test="$status = 'skipped'">
				<img align="middle" alt="skipped" title="Skipped">
					<xsl:attribute name="src">
						<xsl:value-of select="$resourcesFolderPath" />/images/skipped.png</xsl:attribute>
					<xsl:attribute name="width">
						<xsl:value-of select="$size" />
					</xsl:attribute>
				</img>
			</xsl:when>
			<xsl:when test="$status = 'disabled'">
				<img align="middle" alt="disabled" title="Disabled">
					<xsl:attribute name="src">
						<xsl:value-of select="$resourcesFolderPath" />/images/Disabled.png</xsl:attribute>
					<xsl:attribute name="width">
						<xsl:value-of select="$size" />
					</xsl:attribute>
				</img>
			</xsl:when>
			<xsl:when test="$status = 'excluded'">
				<img align="middle" alt="excluded" title="Excluded">
					<xsl:attribute name="src">
						<xsl:value-of select="$resourcesFolderPath" />/images/Excluded.png</xsl:attribute>
					<xsl:attribute name="width">
						<xsl:value-of select="$size" />
					</xsl:attribute>
				</img>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$status" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="AddHeadColumns">
		<xsl:param name="type" />
		<thead class="trhead">
			<th align="left"> Action Name  </th>
			<th align="left" title="Action Description"> Action Description</th>
			<th align="left" title="Detailed tool report"> Tool Report</th>
			<th align="left" title="Status of the asset"> Status </th>
			<th align="left" title="Total time taken for execution"> Time </th>
			<th align="left" title="Execution remarks"> Remarks </th>
		</thead>
	</xsl:template>

	<!-- Sets the time in specific format(HH MM SS) -->
	<xsl:template name="SetTime">
		<xsl:param name="time" />
		<xsl:choose>
			<xsl:when test="floor($time div 60) > '59'">
				<xsl:value-of
					select="concat(floor($time div 3600),'h ',floor(($time div 60) mod 60),'m ',$time mod 60,'s')" />
			</xsl:when>
			<xsl:when test="floor($time div 60) > '0'">
				<xsl:value-of select="concat(floor($time div 60),'m ',$time mod 60,'s')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($time mod 60,'s')" />
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>



	<!-- templates for generating the breadcrump structure in Report -->

	<xsl:template name="generateLink">
		<xsl:param name="totalCount" />
		<xsl:param name="LevelCounter" />
		<!-- evaluate and recurse -->

		<xsl:if test="$LevelCounter > 0">
			<xsl:call-template name="generateIndiavidualLink">
				<xsl:with-param name="increaseCounter" select="0" />
				<xsl:with-param name="LevelCounter" select="$LevelCounter" />
				<xsl:with-param name="link" select="''" />
				<xsl:with-param name="totalCount" select="$totalCount" />
			</xsl:call-template>
			<xsl:call-template name="generateLink">
				<xsl:with-param name="totalCount" select="$totalCount" />
				<xsl:with-param name="LevelCounter" select="$LevelCounter - 1" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>


	<xsl:template name="generateIndiavidualLink">
		<xsl:param name="increaseCounter" />
		<xsl:param name="LevelCounter" />
		<xsl:param name="link" />
		<xsl:param name="totalCount" />
		<xsl:choose>
			<xsl:when test="($increaseCounter) &lt; ($LevelCounter)">
				<xsl:call-template name="generateIndiavidualLink">
					<xsl:with-param name="increaseCounter" select="$increaseCounter+1" />
					<xsl:with-param name="LevelCounter" select="$LevelCounter" />
					<xsl:with-param name="link" select="concat($link,'../')" />
					<xsl:with-param name="totalCount" select="$totalCount" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$LevelCounter = $totalCount">
					<xsl:call-template name="getNodeName">
						<xsl:with-param name="linkTo"
							select="concat($link,'../resources/project-overview.html')" />
						<xsl:with-param name="path" select="$link" />
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$LevelCounter != $totalCount">
					<xsl:call-template name="getNodeName">
						<xsl:with-param name="linkTo"
							select="concat($link,'testsuite-report.html')" />
						<xsl:with-param name="path" select="$link" />
					</xsl:call-template>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="getNodeName">
		<xsl:param name="linkTo" />
		<xsl:param name="path" />
		<xsl:variable name="nodeName" select="dyn:evaluate(concat($path,'/@name'))" />
		<xsl:call-template name="addLink">
			<xsl:with-param name="nodePath" select="$nodeName" />
			<xsl:with-param name="link" select="$linkTo" />
		</xsl:call-template>
	</xsl:template>


	<xsl:template name="addLink">
		<xsl:param name="nodePath" />
		<xsl:param name="link" />
		<a>
			<xsl:attribute name="class">
				<xsl:value-of select="'breadcrump'" />
			</xsl:attribute>
			<xsl:attribute name="href">
				<xsl:value-of select="$link" />
			</xsl:attribute>
			<xsl:value-of select="$nodePath" />
			>>

		</a>
	</xsl:template>
		
		
	<!-- Style Sheet for the QTP Report report "Results.xml" -->
	<xsl:template name="PResults.css">
		.hl_qt { color: white; font-size: 24pt; font-family: Mic Shell Dlg;
		background-color: #666;
		text-align: center; padding: 0px 3px 3px }
		.hl0
		{ color: #999; font-weight: bold; font-size: 18pt;
		font-family: Mic
		Shell Dlg; text-align: center;
		padding: 2px 3px; border-bottom: 3px
		dotted #999 }
		.hl0_name { color: #999; font-weight: normal; font-size:
		18pt; font-family: Mic Shell Dlg;
		text-align:
		center; padding: 2px 3px;
		border-bottom: 3px dotted #999 }
		.hl1
		{
		COLOR: #669;
		FONT-FAMILY: Mic
		Shell Dlg;
		FONT-SIZE: 16pt;
		FONT-WEIGHT: bold
		}
		.hl2
		{
		COLOR: #669;
		FONT-FAMILY: Mic
		Shell Dlg;
		FONT-SIZE: 13pt;
		FONT-WEIGHT: bold
		}
		.hl3 {
		color: #666; font-weight: bold; font-size:
		10pt; font-family: Mic Shell
		Dlg; height: 28px }
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
		.bg_gray_ccc { background-color:
		#ccc }
		.bg_gray_999 { background-color:
		#999 }
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
		{ font-size: 10pt;
		font-family: Mic Shell Dlg }
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
		FONT-FAMILY: Mic
		Shell Dlg;
		FONT-SIZE: 10pt;
		FONT-WEIGHT:
		bold
		}
		.FailedLow
		{
		COLOR: #f03;
		FONT-FAMILY: Mic Shell Dlg;
		FONT-SIZE:
		10pt;
		}

		.FailedHigh
		{
		COLOR: #f03;
		FONT-FAMILY: Mic Shell Dlg;
		FONT-SIZE:
		16pt;
		FONT-WEIGHT:
		bold
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
		FONT-WEIGHT:
		bold
		}
		.DoneHigh
		{ color: #999; font-weight:
		bold; font-size: 16pt;
		font-family: Mic Shell Dlg }
		.Information
		{
		COLOR: #999;
		FONT-FAMILY: Mic
		Shell
		Dlg;
		FONT-SIZE: 10pt;
		FONT-WEIGHT: bold
		}
		.InformationHigh
		{
		COLOR:
		#999;
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
		FONT-WEIGHT:
		bold;
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


		.tooltiptitle{COLOR: #FFFFFF; TEXT-DECORATION: none; CURSOR: Default;
		font-family: arial;
		font-weight: bold;
		font-size: 8pt}
		.tooltipcontent{COLOR: #000000; TEXT-DECORATION: none; CURSOR:
		Default; font-family: arial; font-size: 8pt}

		#ToolTip{position:absolute; width: 100px; top: 0px;
		left: 0px;
		z-index:4; visibility:hidden;}
		.brake { font-size: 1px; font-family:
		Mic Shell Dlg;
		background-color: #366; border-top: 15px
		solid white;
		border-bottom: 15px solid white; width: 100%;
		height: 35px }
		.iteration_border { padding-top: 5px; padding-bottom: 5px;
		padding-left: 10px;
		border-top: 3px solid #999;
		border-bottom: 3px solid
		#999; border-left: 3px solid #999 }
		.iteration_head { color: white;
		font-weight: bold; font-size: 12px; font-family: Mic Shell Dlg;
		background-color:
		#999; text-align: center; padding: 3px 3px 1px }
		.action_border { padding-top:
		5px; padding-bottom: 5px; padding-left:
		10px; border-top: 3px solid #ccc;
		border-bottom: 3px solid
		#ccc;
		border-left: 3px solid #ccc }
		.action_head { color: black; font-weight:
		bold; font-size:
		12px; font-family: Mic Shell Dlg; background-color:
		#ccc; text-align: center; padding: 3px 3px 1px
		}
		.table_frame { padding:
		3px; border: solid 1px #669 }
		.table_hl { color: #669; font-weight:
		bold;
		font-size: 10pt; line-height: 14pt; font-family: Mic Shell Dlg;
		padding-right: 2px; padding-left:
		2px; border-top: 1px solid #669;
		border-bottom: 1px solid #669 }
		.table_cell { vertical-align: top;
		padding: 3px; border-bottom: 1px solid #eee; overflow: visible
		}
		p {
		font-size: 8pt; font-family:
		Mic Shell Dlg }
		td { font-size: 8pt;
		font-family: Mic Shell Dlg }
		ul { font-size: 8pt; font-family:
		Mic Shell
		Dlg }
	</xsl:template>

	<xsl:template name="reportStyle.css">
		body {
		font:normal 68% verdana,arial,helvetica;
		color:#000000;
		}
		.lineOverFlow{
		text-overflow: ellipsis;
		width: 150px !important;
		overflow: hidden;
		display: inline-block;
		white-space: nowrap;
		}
		.totalcount{
		font:normal 85%
		verdana,arial,helvetica;
		font-size:85%;
		font-weight: bold;
		color:black !important;
		}
		.passedcount{
		font:normal 85%
		verdana,arial,helvetica;
		font-size:85%;
		font-weight: bold;
		color:green
		!important;
		}
		.failedcount{
		font:normal 85%
		verdana,arial,helvetica;
		font-size:85%;
		font-weight: bold;
		color:red !important;
		}
		.skippedcount{
		font:normal 85%
		verdana,arial,helvetica;
		font-size:85%;
		font-weight:
		bold;
		color:gray !important;
		}

		table tr
		th {
		font:normal 85%
		verdana,arial,helvetica;
		text-align:left;
		font-weight: bold;
		color:#233356;
		}
		table tr td {
		font:normal
		85%
		verdana,arial,helvetica;
		}
		table.details tr th{
		font-weight: bold;
		font:size:85%;
		text-align:left;
		background:#9ac4f1;
		}
		table.details2 tr th{
		font-weight: bold;
		font:size:85%;
		text-align:left;
		background:#d4e9ff;
		}
		table.details tr td{
		background:#eeeee0;
		font:normal 75% verdana,arial,helvetica;
		color:black;
		}
		table.details2 tr td{
		background:#f7f7ed;
		font:normal 75%
		verdana,arial,helvetica;
		color:black;
		}
		table.backpath tr td{
		font:normal
		75%
		verdana,arial,helvetica;
		font-weight: bold;
		color:#81F7F3;
		}
		table.screen
		tr th{
		font-weight: bold;
		font:size:85%;
		text-align:middle;
		background:#E6E6E6;
		}
		table.screen
		tr.PASS{
		background:#eeeee0;
		}
		table.screen
		tr.FAIL{
		background:red;
		}
		table.screen tr.WARNING{
		background:yellow;
		}
		table.screen td{
		font:normal 75%
		verdana,arial,helvetica;
		}
		tr.strikeout td {
		position:relative
		}
		tr.strikeout td:before {
		content: " ";
		position:
		absolute;
		top: 50%;
		left:
		0;
		border-bottom: 1px solid #111;
		width: 100%;
		}
		p {
		line-height:1.5em;
		margin-top:0.5em; margin-bottom:1.0em;
		}
		h1 {
		font-weight: bold;
		color:#000080;
		margin: 0px 0px 5px; font: 175%
		verdana,arial,helvetica;
		}
		h2 {
		margin-top: 1em; margin-bottom:
		0.5em;
		font: bold 120%
		verdana,arial,helveticach
		}
		.breadcrump{
		margin-top: 1em; margin-bottom:
		0.5em;
		font: bold 120%
		verdana,arial,maroon
		}
		h3 {
		margin-bottom: 0.5em;
		font: bold 115%
		verdana,arial,helvetica
		}
		h4 {
		margin-bottom: 0.5em; font:
		bold 100%a
		verdana,arial,helvetica
		}
		h5 {
		font-weight: bold;
		color: maroon;
		font:size:95%;
		margin-bottom: 0.1em;
		background:#D4D0C8;
		}
		h6 {
		margin-bottom: 0.5em; font: bold 90% verdana,arial,helvetica
		}
		a {
		text-decoration:none }
		.Error {
		font-weight:bold;
		color:red;"reports/resources/ALFWebFrames.xsl"
		}
		.Failure {
		font-weight:bold; color:purple;
		}
		.Properties {
		text-align:right;
		}
		a:link
		{ color: #02A1B7 }
		a:visited { color: #2200CC }
		a:active { color:
		#FF00FF }
		.tooltip {
		position: relative;
		display: inline-block;
		border-bottom: 1px dotted black;
		}
		.tooltip .tooltiptext {
		display:block;
		line-height:
		20px;
		font-size:100%;
		font-weight: bold;
		visibility: hidden;
		text-align: center;
		padding: 8px;
		background-color:
		#f7f7f7;
		color: #fff;
		text-align: center;
		border-radius: 6px;
		white-space: nowrap;
		/* Position the tooltip */
		position: absolute;
		z-index: 1;
		top: -5px;
		left: 105%;
		}
		.tooltip:hover .tooltiptext {
		visibility: visible;
		border: 4px solid #4184cc;
		background-color: #fff;
		}
		.tctooltip{
		color:#6092f1;
		}.tstooltip{
		color:#2166ea;
		}.ptooltip{
		color:280ef1;
		}
	</xsl:template>
</xsl:stylesheet>
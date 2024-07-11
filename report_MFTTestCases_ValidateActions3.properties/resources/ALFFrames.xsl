<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
	xmlns:lxslt="http://xml.apache.org/xslt" xmlns:redirect="http://xml.apache.org/xalan/redirect"
	xmlns:stringutils="xalan://org.apache.tools.ant.util.StringUtils" extension-element-prefixes="redirect">

	<!--
	 @author sandeep lati
	-->
	<!-- MULTIPLE FRAME ALF REPORTING -->


	<xsl:output method="html" indent="yes" encoding="US-ASCII"/>
	<xsl:variable name="CSSPath">../resources/reportStyle.css</xsl:variable>
	<xsl:template name="logo">
		<xsl:param name="backdir"/>
		<table width="100%" >
			<tr><th><h2>ALF Report</h2></th><td align="right" >
					<img width="20%">
						<xsl:attribute name="src"><xsl:value-of select="$backdir"/>images/logo.gif</xsl:attribute>
					</img>
				</td></tr>
			<tr><td colspan="2"><hr/></td></tr>
		</table>
	</xsl:template>
	<xsl:variable name="copyright">
		<table border="0" width="100%"  height="100%">
			<tr><td></td></tr>
		</table>
		<table width="100%" align="center" class="details">
			<tr> <td width="100%" align="middle">COPYRIGHT &#169; 2009 SOFTWARE AG</td> </tr>
		</table>
	</xsl:variable>
	<xsl:template match="/">
		<!-- Create Style Sheet -->
		<redirect:write file="./reportStyle.css">
			<xsl:call-template name="reportStyle.css"/>
		</redirect:write>

		<!-- Create Style Sheet -->
		<redirect:write file="./PResults.css">
			<xsl:call-template name="PResults.css"/>
		</redirect:write>

		<!-- Create component-frame.html -->
		<redirect:write file="./component-frame.html">
			<xsl:call-template name="component-frame.html"/>
		</redirect:write>

		<!-- Create allSummary-frame.html -->
		<redirect:write file="./allSummary-frame.html">
			<xsl:call-template name="allSummary-frame.html"/>
		</redirect:write>

		<!-- Create overview-summary.html -->
		<redirect:write file="./overview-summary.html">
			<xsl:call-template name="overview-summary.html"/>
		</redirect:write>

		<!-- Create index.html -->
		<html>
			<head>
				<title>ALF Report</title>
			</head>
			<frameset cols="20%,80%">
				<frameset rows="40%,60%">
					<frame src="./resources/component-frame.html" name="ComponentFrame"/>
					<frame src="./resources/allSummary-frame.html" name="ComponentDescFrame"/>
				</frameset>
				<frame src="./resources/overview-summary.html" name="TotalSummary"/>
				<noframes>
					<h2>Frame Alert</h2>
					<p>
			                This document is designed to be viewed using the frames feature. If you see this message, you are using a non-frame-capable web client.
					</p>
				</noframes>
			</frameset>
		</html>
	</xsl:template>


	<xsl:template name="component-frame.html">
		<html>
			<head>
				<title>Component Report</title>
				<link rel="stylesheet" type="text/css" href="reportStyle.css"/>
			</head>
			<body>
				<table width="100%" align="center" nowrap="nowrap">
					<xsl:apply-templates select="*" mode="main"/>
				</table>
			</body>
		</html>
	</xsl:template>

	<!--  Frame 2. Have "All ****" links -->
	<xsl:template name="allSummary-frame.html">
		<html>
			<head>
				<title>All Features</title>
				<link rel="stylesheet" type="text/css" href="reportStyle.css"/>
			</head>
			<body>
				<table>
					<tr><th><h2>Summary</h2></th></tr>
					<tr><td></td></tr>
					<tr><td>
							<xsl:call-template name="createAll">
								<xsl:with-param name="type" select="'Features'"/>
							</xsl:call-template>
							<a>
								<xsl:attribute name="href">./all-Features.html</xsl:attribute>
								<xsl:attribute name="target">TotalSummary</xsl:attribute>
								<li>All Features</li>
							</a>
						</td></tr>
					<tr><td>
							<xsl:call-template name="createAll">
								<xsl:with-param name="type" select="'Scenarios'"/>
							</xsl:call-template>
							<a>
								<xsl:attribute name="href">./all-Scenarios.html</xsl:attribute>
								<xsl:attribute name="target">TotalSummary</xsl:attribute>
								<li>All Scenarios</li>
							</a>
						</td></tr>
					<tr><td>
							<xsl:call-template name="createAll">
								<xsl:with-param name="type" select="'Tests'"/>
							</xsl:call-template>
							<a>
								<xsl:attribute name="href">./all-Tests.html</xsl:attribute>
								<xsl:attribute name="target">TotalSummary</xsl:attribute>
								<li>All Tests</li>
							</a>
						</td></tr>
					<tr><td>
							<xsl:call-template name="createAll">
								<xsl:with-param name="type" select="'Actions'"/>
							</xsl:call-template>
							<a>
								<xsl:attribute name="href">./all-Actions.html</xsl:attribute>
								<xsl:attribute name="target">TotalSummary</xsl:attribute>
								<li>All Actions</li>
							</a>
						</td></tr>
				</table>

			</body>
		</html>
	</xsl:template>

	<xsl:template name="createAll">
		<xsl:param name="type"/>
		<xsl:variable name="filename">./all-<xsl:value-of select="$type"/>.html</xsl:variable>
		<redirect:write file="{$filename}">
			<html>
				<head>
					<title>Full ALF Report</title>
					<link rel="stylesheet" type="text/css" href="reportStyle.css"/>
				</head>
				<body>
					<xsl:call-template name="logo">
						<xsl:with-param name="backdir" select="'./'"/>
					</xsl:call-template>
					<xsl:call-template name="set.heading">
						<xsl:with-param name="heading" select="concat('All ',$type,'Summary')"/>
					</xsl:call-template>
					<table width="100%" class="details">
						<xsl:choose>
							<xsl:when test="$type = 'Actions'">
								<tr>
									<th align="left">  Name   </th>
									<th align="left">  Description   </th>
									<th align="center">  Tool Report   </th>
									<th align="center">  Server Logs   </th>
									<th align="center">  Action Type   </th>
									<th align="center">  Data row   </th>
									<th align="left" width="40%">  Remarks   </th>
									<th align="left">  Status   </th>
									<th align="left" >  Time  </th>
								</tr>
								<xsl:apply-templates select="*" mode="AllActions"/>
							</xsl:when>
							<xsl:otherwise>
								<tr>
									<th align="left"> Name  </th>
									<xsl:choose>
										<xsl:when test="$type = 'Features'">
											<th align="left"> Component Name  </th>
											<th align="left"> Tests  </th>
										</xsl:when>
										<xsl:when test="$type = 'Scenarios'">
											<th align="left"> Feature Name  </th>
											<th align="left"> Tests  </th>
										</xsl:when>
										<xsl:when test="$type = 'Tests'">
											<th align="left"> Scenario Name  </th>
											<th align="left"> Actions  </th>
										</xsl:when>
									</xsl:choose>

									<th align="left"> Success  </th>
									<th align="left"> Skipped </th>
									<th align="left"> Failures </th>
									<th align="left"> Status </th>
									<th align="left"> Time </th>
								</tr>
								<xsl:choose>
									<xsl:when test="$type = 'Features'">
										<xsl:apply-templates select="*" mode="AllFeatures"/>
									</xsl:when>
									<xsl:when test="$type = 'Scenarios'">
										<xsl:apply-templates select="*" mode="AllScenarios"/>
									</xsl:when>
									<xsl:when test="$type = 'Tests'">
										<xsl:apply-templates select="*" mode="AllTests"/>
									</xsl:when>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</table>
					<xsl:copy-of select="$copyright"/>
				</body>
			</html>
		</redirect:write>
	</xsl:template>


	<!-- Start of ALL REPORT  -->
	<xsl:template match="feature" mode="AllFeatures">
		<xsl:variable name="totalTCcount"><xsl:value-of select="sum(current()//scenario//testcase//count/@total)"/></xsl:variable>
		<xsl:variable name="passTCcount"><xsl:value-of select="sum(current()//scenario//testcase//count/@pass)"/></xsl:variable>
		<xsl:variable name="skipTCcount"><xsl:value-of select="sum(current()//scenario//testcase//count/@skipped)"/></xsl:variable>

		<tr>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="$skipTCcount = $totalTCcount">
						<xsl:value-of select="'strikeout'" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="''" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<td><xsl:value-of select="@name"/></td>
			<td> <a> <xsl:value-of select="../@name"/> </a> </td>
			<td><xsl:value-of select="$totalTCcount"/></td>
			<td><xsl:value-of select="$passTCcount"/></td>
			<td><xsl:value-of select="$skipTCcount"/></td>
			<td><xsl:value-of select="$totalTCcount - $passTCcount - $skipTCcount"/></td>
			<td>
				<xsl:choose>
					<xsl:when test="($totalTCcount - $passTCcount - $skipTCcount) > 0">
						<xsl:call-template name="SetImage">
							<xsl:with-param name="size"  select="'16%'" />
							<xsl:with-param name="path"  select="'./images'" />
							<xsl:with-param name="status"  select="'fail'" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="($totalTCcount - $passTCcount ) = 0">
						<xsl:call-template name="SetImage">
							<xsl:with-param name="size"  select="'16%'" />
							<xsl:with-param name="path"  select="'./images'" />
							<xsl:with-param name="status"  select="'pass'" />
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="SetImage">
							<xsl:with-param name="size"  select="'16%'" />
							<xsl:with-param name="path"  select="'./images'" />
							<xsl:with-param name="status"  select="'skipped'" />
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

	<xsl:template match="scenario" mode="AllScenarios">
		<xsl:variable name="totalTCcount"><xsl:value-of select="sum(current()//testcase//count/@total)"/></xsl:variable>
		<xsl:variable name="passTCcount"><xsl:value-of select="sum(current()//testcase//count/@pass)"/></xsl:variable>
		<xsl:variable name="skipTCcount"><xsl:value-of select="sum(current()//testcase//count/@skipped)"/></xsl:variable>

		<tr>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="$skipTCcount = $totalTCcount">
						<xsl:value-of select="'strikeout'" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="''" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

			<td><xsl:value-of select="@scenarioName"/></td>
			<td> <a> <xsl:value-of select="../@name"/> </a> </td>
			<td><xsl:value-of select="$totalTCcount"/></td>
			<td><xsl:value-of select="$passTCcount"/></td>
			<td><xsl:value-of select="$skipTCcount"/></td>
			<td><xsl:value-of select="$totalTCcount - $passTCcount - $skipTCcount"/></td>
			<td>
				<xsl:choose>
					<xsl:when test="($totalTCcount - $passTCcount - $skipTCcount) > 0">
						<xsl:call-template name="SetImage">
							<xsl:with-param name="size"  select="'16%'" />
							<xsl:with-param name="path"  select="'./images'" />
							<xsl:with-param name="status"  select="'fail'" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="($totalTCcount - $passTCcount ) = 0">
						<xsl:call-template name="SetImage">
							<xsl:with-param name="size"  select="'16%'" />
							<xsl:with-param name="path"  select="'./images'" />
							<xsl:with-param name="status"  select="'pass'" />
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="SetImage">
							<xsl:with-param name="size"  select="'16%'" />
							<xsl:with-param name="path"  select="'./images'" />
							<xsl:with-param name="status"  select="'skipped'" />
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

	<xsl:template match="testcase" mode="AllTests">
		<xsl:variable name="totalTCcount"><xsl:value-of select="count(current()//result)"/></xsl:variable>
		<xsl:variable name="passTCcount"><xsl:value-of select="count(current()//result[@value='true'])"/></xsl:variable>
		<xsl:variable name="skipTCcount"><xsl:value-of select="count(current()//result[@value='skipped'])"/></xsl:variable>
		<xsl:variable name="falsecount"><xsl:value-of select="count(current()//result[@value='false'])"/></xsl:variable>

		<tr>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="$skipTCcount = $totalTCcount">
						<xsl:value-of select="'strikeout'" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="''" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

			<td> <xsl:value-of select="@name"/> </td>
			<td> <a> <xsl:value-of select="../@scenarioName"/> </a> </td>
			<td><xsl:value-of select="$totalTCcount"/></td>
			<td><xsl:value-of select="$passTCcount"/></td>
			<td><xsl:value-of select="$skipTCcount"/></td>
			<td><xsl:value-of select="$falsecount"/></td>
			<td>
				<xsl:choose>
					<xsl:when test="($totalTCcount - $passTCcount - $skipTCcount) > 0">
						<xsl:call-template name="SetImage">
							<xsl:with-param name="size"  select="'16%'" />
							<xsl:with-param name="path"  select="'./images'" />
							<xsl:with-param name="status"  select="'fail'" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="($totalTCcount - $passTCcount ) = 0">
						<xsl:call-template name="SetImage">
							<xsl:with-param name="size"  select="'16%'" />
							<xsl:with-param name="path"  select="'./images'" />
							<xsl:with-param name="status"  select="'pass'" />
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="SetImage">
							<xsl:with-param name="size"  select="'16%'" />
							<xsl:with-param name="path"  select="'./images'" />
							<xsl:with-param name="status"  select="'skipped'" />
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


	<xsl:template match="action" mode="AllActions">
		<xsl:variable name="type1"><xsl:value-of select="preceding-sibling::action/../../../@scenarioName"/> </xsl:variable>
		<xsl:variable name="type2"><xsl:value-of select="../../../@scenarioName"/> </xsl:variable>

		<xsl:if test="$type1 != $type2 ">
			<tr><td colspan="8">
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
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="result/@value = 'skipped'">
						<xsl:value-of select="'strikeout'" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="''" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

			<td>
			<xsl:choose>
				<xsl:when test="@actionLanguage = 'QTP'">
					<xsl:variable name="path"><xsl:value-of select="../../../../../@name"/>/<xsl:value-of select="../../../../@name"/>/<xsl:value-of select="../../../@scenarioId"/>/<xsl:value-of select="../../@name"/>/<xsl:value-of select="@id"/></xsl:variable>
					<a>
						<xsl:attribute name="href"><xsl:value-of select="concat('../',$path,'/screen-report.html')"/></xsl:attribute>
						<xsl:attribute name="target">_blank</xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
						<xsl:value-of select="@name"/>
					</a>
				</xsl:when>
				<xsl:when test="@actionLanguage = 'SELENIUM'">
					<xsl:variable name="path"><xsl:value-of select="../../../../../@name"/>/<xsl:value-of select="../../../../@name"/>/<xsl:value-of select="../../../@scenarioId"/>/<xsl:value-of select="../../@name"/>/<xsl:value-of select="@id"/></xsl:variable>
					<a>
						<xsl:attribute name="href"><xsl:value-of select="concat('../',$path,'/screen-report.html')"/></xsl:attribute>
						<xsl:attribute name="target">_blank</xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
						<xsl:value-of select="@name"/>
					</a>
				</xsl:when>
				<xsl:when test="@actionLanguage = 'WEBDRIVER'">
					<xsl:variable name="path"><xsl:value-of select="../../../../../@name"/>/<xsl:value-of select="../../../../@name"/>/<xsl:value-of select="../../../@scenarioId"/>/<xsl:value-of select="../../@name"/>/<xsl:value-of select="@id"/></xsl:variable>
					<a>
						<xsl:attribute name="href"><xsl:value-of select="concat('../',$path,'/screen-report.html')"/></xsl:attribute>
						<xsl:attribute name="target">_blank</xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
						<xsl:value-of select="@name"/>
					</a>
				</xsl:when>
				<xsl:when test="@actionLanguage = 'CNL'">
					<xsl:variable name="path"><xsl:value-of select="../../../../../@name"/>/<xsl:value-of select="../../../../@name"/>/<xsl:value-of select="../../../@scenarioId"/>/<xsl:value-of select="../../@name"/>/<xsl:value-of select="@id"/></xsl:variable>
					<a>
						<xsl:attribute name="href"><xsl:value-of select="concat('../',$path,'/screen-report.html')"/></xsl:attribute>
						<xsl:attribute name="target">_blank</xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
						<xsl:value-of select="@name"/>
					</a>
				</xsl:when>

				<xsl:when test="@actionLanguage = 'FEST'">
					<xsl:variable name="path"><xsl:value-of select="../../../../../@name"/>/<xsl:value-of select="../../../../@name"/>/<xsl:value-of select="../../../@scenarioId"/>/<xsl:value-of select="../../@name"/>/<xsl:value-of select="@id"/></xsl:variable>
					<a>
						<xsl:attribute name="href"><xsl:value-of select="concat('../',$path,'/screen-report.html')"/></xsl:attribute>
						<xsl:attribute name="target">_blank</xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
						<xsl:value-of select="@name"/>
					</a>
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
	<td align="left"><xsl:value-of select="@description"/> </td>
	<td>
		<xsl:variable name="toolreport"><xsl:value-of select="result/@toolSpecificReport"/></xsl:variable>
		<xsl:variable name="path"><xsl:value-of select="../../../../../@name"/>/<xsl:value-of select="../../../../@name"/>/<xsl:value-of select="../../../@scenarioId"/>/<xsl:value-of select="../../@name"/>/<xsl:value-of select="@id"/></xsl:variable>
		<xsl:if test="$toolreport != 'null'">
			<a>
				<xsl:attribute name="href"><xsl:value-of select="concat('../',$path,'/',$toolreport,'?actionid=',@id)"/></xsl:attribute>
				<xsl:attribute name="target">_blank</xsl:attribute>
				<xsl:value-of select="@actionLanguage"/>
			</a>
		</xsl:if>

		<xsl:if test="$toolreport = 'null'">
			<xsl:value-of select="@actionLanguage"/>
		</xsl:if>
	</td>
	<td align="center">
		<xsl:variable name="path"><xsl:value-of select="../../../../../@name"/>/<xsl:value-of select="../../../../@name"/>/<xsl:value-of select="../../../@scenarioId"/>/<xsl:value-of select="../../@name"/>/<xsl:value-of select="@id"/></xsl:variable>
		<a>
			<xsl:attribute name="href"><xsl:value-of select="concat('../',$path,'/serverLogs.html')"/></xsl:attribute>
			<xsl:attribute name="target">_blank</xsl:attribute>
			Server Logs
		</a>
	</td>
	<td align="center"><xsl:value-of select="@mode"/> </td>
	<td align="center">
		<xsl:variable name="datareport"><xsl:value-of select="datarow/@file"/></xsl:variable>
		<xsl:variable name="path"><xsl:value-of select="../../../../../@name"/>/<xsl:value-of select="../../../../@name"/>/<xsl:value-of select="../../../@scenarioId"/>/<xsl:value-of select="../../@name"/>/<xsl:value-of select="@id"/></xsl:variable>
		<a>
			<xsl:attribute name="href"><xsl:value-of select="concat('../', $path,'/', $datareport)"/></xsl:attribute>
			<xsl:attribute name="target">_blank</xsl:attribute>
			<xsl:value-of select="@dataRow"/>
		</a>
	</td>
	<td><xsl:value-of select="result/@remarks"/> </td>
	<xsl:apply-templates select="*" mode="actionstatus" >
		<xsl:with-param name="path1" select="'./images'"/>
	</xsl:apply-templates>
</tr>
</xsl:template>




<!-- End of ALL REPORT  -->

<xsl:template name="overview-summary.html">
	<html>
		<head>
			<title>Full ALF Report</title>
			<link rel="stylesheet" type="text/css" href="reportStyle.css"/>
		</head>
		<body>
			<xsl:call-template name="logo">
				<xsl:with-param name="backdir" select="'./'"/>
			</xsl:call-template>
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading" select="'Summary'"/>
			</xsl:call-template>
			<table width="100%" class="details">
				<tr>
					<th align="left" width="10%">Tests </th>
					<th align="left" width="10%">Success </th>
					<th align="left" width="10%">Skipped </th>
					<th align="left" width="10%">Failures </th>
					<th align="left" width="10%">Success rate </th>
					<th align="left" width="10%">Time </th>
				</tr>

				<tr>
				<xsl:variable name="totalTCcount"><xsl:value-of select="sum(current()//..//testcase//count/@total)"/></xsl:variable>
				<xsl:variable name="passTCcount"><xsl:value-of select="sum(current()//..//testcase//count/@pass)"/></xsl:variable>
				<xsl:variable name="skipTCcount"><xsl:value-of select="sum(current()//..//testcase//count/@skipped)"/></xsl:variable>
				<xsl:variable name="failTCcount"><xsl:value-of select="$totalTCcount - $passTCcount - $skipTCcount"/></xsl:variable>
				<xsl:variable name="successRate" select="($totalTCcount - $failTCcount - $skipTCcount) div $totalTCcount"/>
				<xsl:variable name="timeCount" select="sum(current()//..//testcase//count/@timecount)"/>

					<xsl:attribute name="class">
						<xsl:choose>
							<xsl:when test="$skipTCcount = $totalTCcount">
								<xsl:value-of select="'strikeout'" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="''" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>

					<td><xsl:value-of select="$totalTCcount"/></td>
					<td><xsl:value-of select="$passTCcount"/></td>
					<td><xsl:value-of select="$skipTCcount"/></td>
					<td><xsl:value-of select="$failTCcount"/></td>
					<td><xsl:value-of select="format-number($successRate,'0.00%')"/></td>
					<td><xsl:call-template name="SetTime">
							<xsl:with-param name="time"  select="$timeCount" />
						</xsl:call-template>
					</td>
				</tr>
				<tr><td></td></tr>
				<tr><td colspan="6" ><hr size="1"  /></td></tr>
			</table>
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading" select="'Component'"/>
			</xsl:call-template>
			<table width="100%" class="details">
				<xsl:call-template name="AddHeadColumns"/>
				<xsl:apply-templates select="*" mode="summary"/>
			</table>
			<xsl:copy-of select="$copyright"/>
		</body>
	</html>
</xsl:template>

<xsl:template match="controller" mode="main">
	<tr><td align="middle" valign="middle"><b>
				<h1> <a>
						<xsl:attribute name="href">./overview-summary.html</xsl:attribute>
						<xsl:attribute name="target">TotalSummary</xsl:attribute>
						<xsl:value-of select="@name"/>
					</a>
				</h1>
			</b>
		</td></tr>
	<tr><td align="middle"><i><h6><sup>ALF Version: <xsl:value-of select="@alf.version"/></sup></h6></i></td></tr>
	<tr><td align="middle"><i><h6><sup>Execution Start Time:  <xsl:value-of select="@startTime"/></sup></h6></i></td></tr>
	<tr><td><br/></td></tr>
	<tr><th><h2>Component</h2></th></tr>
	<tr><td><ol>
				<xsl:for-each select="current()/component">
					<li>
						<a>
							<xsl:attribute name="href">../<xsl:value-of select="@name"/>/feature-report.html</xsl:attribute>
							<xsl:attribute name="target">TotalSummary</xsl:attribute>
							<xsl:value-of select="@name"/>
						</a>
					</li>
				</xsl:for-each>
			</ol></td></tr>
</xsl:template>

<!-- Component summary details -->
<xsl:template match="component" mode="summary">
	<xsl:variable name="totalTCcount"><xsl:value-of select="sum(current()//feature//scenario//testcase//count/@total)"/></xsl:variable>
	<xsl:variable name="passTCcount"><xsl:value-of select="sum(current()//feature//scenario//testcase//count/@pass)"/></xsl:variable>
	<xsl:variable name="skipTCcount"><xsl:value-of select="sum(current()//feature//scenario//testcase//count/@skipped)"/></xsl:variable>

	<tr>
		<xsl:attribute name="class">
			<xsl:choose>
				<xsl:when test="$skipTCcount = $totalTCcount">
					<xsl:value-of select="'strikeout'" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>

		<td>
			<xsl:call-template name="feature.report"/>
			<a>
				<xsl:attribute name="href">../<xsl:value-of select="@name"/>/feature-report.html</xsl:attribute>
				<xsl:value-of select="@name"/>
			</a>
		</td>

		<td><xsl:value-of select="$totalTCcount"/></td>
		<td><xsl:value-of select="$passTCcount"/></td>
		<td><xsl:value-of select="$skipTCcount"/></td>
		<td><xsl:value-of select="$totalTCcount - $passTCcount - $skipTCcount "/></td>
		<td>
			<xsl:choose>
				<xsl:when test="($totalTCcount - $passTCcount - $skipTCcount) > 0">
					<xsl:call-template name="SetImage">
						<xsl:with-param name="size"  select="'16%'" />
						<xsl:with-param name="path"  select="'./images'" />
						<xsl:with-param name="status"  select="'fail'" />
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="($totalTCcount - $passTCcount ) = 0">
					<xsl:call-template name="SetImage">
						<xsl:with-param name="size"  select="'16%'" />
						<xsl:with-param name="path"  select="'./images'" />
						<xsl:with-param name="status"  select="'pass'" />
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="SetImage">
						<xsl:with-param name="size"  select="'16%'" />
						<xsl:with-param name="path"  select="'./images'" />
						<xsl:with-param name="status"  select="'skipped'" />
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

<!-- Create freature wise report -->
<xsl:template name="feature.report">
	<xsl:variable name="CompName"><xsl:value-of select="@name"/></xsl:variable>
	<redirect:write file="../{$CompName}/feature-report.html">
		<html>
			<head>
				<title>Freature Report</title>
				<link rel="stylesheet" type="text/css" href="../resources/reportStyle.css"/>
			</head>
			<body>
				<xsl:call-template name="logo">
					<xsl:with-param name="backdir" select="'../resources/'"/>
				</xsl:call-template>
				<table width="100%" class="backpath">
					<tr><td colspan="4" >
							<a>
								<xsl:attribute name="href">../resources/overview-summary.html</xsl:attribute>
	    			Component
							</a>
						</td></tr>
				</table>
				<br/>
				<xsl:call-template name="set.heading">
					<xsl:with-param name="heading" select="'Feature'"/>
				</xsl:call-template>
				<table width="100%" class="details">
					<xsl:call-template name="AddHeadColumns"/>
					<xsl:apply-templates select="*" mode="Featuresummary"/>
				</table>
				<xsl:copy-of select="$copyright"/>
			</body>
		</html>
	</redirect:write>
</xsl:template>

<xsl:template match="feature" mode="Featuresummary">
	<xsl:variable name="totalTCcount"><xsl:value-of select="sum(current()//scenario//testcase//count/@total)"/></xsl:variable>
	<xsl:variable name="passTCcount"><xsl:value-of select="sum(current()//scenario//testcase//count/@pass)"/></xsl:variable>
	<xsl:variable name="skipTCcount"><xsl:value-of select="sum(current()//scenario//testcase//count/@skipped)"/></xsl:variable>

	<tr>
		<xsl:attribute name="class">
			<xsl:choose>
				<xsl:when test="$skipTCcount = $totalTCcount">
					<xsl:value-of select="'strikeout'" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<td>
			<xsl:call-template name="scenario.report"/>
			<a>
				<xsl:attribute name="href">./<xsl:value-of select="@name"/>/scenario-report.html</xsl:attribute>
				<xsl:value-of select="@name"/>
			</a>
		</td>

		<td><xsl:value-of select="$totalTCcount"/></td>
		<td><xsl:value-of select="$passTCcount"/></td>
		<td><xsl:value-of select="$skipTCcount"/></td>
		<td><xsl:value-of select="$totalTCcount - $passTCcount - $skipTCcount"/></td>
		<td>
			<xsl:choose>
				<xsl:when test="($totalTCcount - $passTCcount - $skipTCcount) > 0">
					<xsl:call-template name="SetImage">
						<xsl:with-param name="size"  select="'16%'" />
						<xsl:with-param name="path"  select="'../resources/images'" />
						<xsl:with-param name="status"  select="'fail'" />
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="($totalTCcount - $passTCcount ) = 0">
					<xsl:call-template name="SetImage">
						<xsl:with-param name="size"  select="'16%'" />
						<xsl:with-param name="path"  select="'../resources/images'" />
						<xsl:with-param name="status"  select="'pass'" />
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="SetImage">
						<xsl:with-param name="size"  select="'16%'" />
						<xsl:with-param name="path"  select="'../resources/images'" />
						<xsl:with-param name="status"  select="'skipped'" />
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

<!-- Create scenario wise report -->
<xsl:template name="scenario.report">

	<redirect:write file="../{../@name}/{@name}/scenario-report.html">
		<html>
			<head>
				<title>Scenario Report</title>
				<link rel="stylesheet" type="text/css" href="../../resources/reportStyle.css"/>
			</head>
			<body>
				<xsl:call-template name="logo">
					<xsl:with-param name="backdir" select="'../../resources/'"/>
				</xsl:call-template>

				<table width="100%" class="backpath">
					<tr><td colspan="4" >
							<a>
								<xsl:attribute name="href">../feature-report.html</xsl:attribute>
								<xsl:value-of select="../@name"/>
							</a>
							<xsl:text disable-output-escaping="no"> >> </xsl:text>
					<xsl:value-of select="@name"/>
				</td></tr>
		</table>
		<br/>
		<xsl:call-template name="set.heading">
			<xsl:with-param name="heading" select="'Scenario'"/>
		</xsl:call-template>
		<table width="100%" class="details">
			<xsl:call-template name="AddHeadColumns"/>
			<xsl:apply-templates select="*" mode="scenariosummary"/>
		</table>
		<xsl:copy-of select="$copyright"/>
	</body>
</html>
</redirect:write>
</xsl:template>

<xsl:template match="scenario" mode="scenariosummary">
	<xsl:variable name="totalTCcount"><xsl:value-of select="sum(current()//testcase//count/@total)"/></xsl:variable>
	<xsl:variable name="passTCcount"><xsl:value-of select="sum(current()//testcase//count/@pass)"/></xsl:variable>
	<xsl:variable name="skipTCcount"><xsl:value-of select="sum(current()//testcase//count/@skipped)"/></xsl:variable>

	<tr>
		<xsl:attribute name="class">
			<xsl:choose>
				<xsl:when test="$skipTCcount = $totalTCcount">
					<xsl:value-of select="'strikeout'" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>

		<td>
			<xsl:call-template name="TestCase.report"/>
			<a>
				<xsl:attribute name="href">./<xsl:value-of select="@scenarioId"/>/TestCase-report.html</xsl:attribute>
				<xsl:value-of select="@scenarioName"/>
			</a>
		</td>

		<td><xsl:value-of select="$totalTCcount"/></td>
		<td><xsl:value-of select="$passTCcount"/></td>
		<td><xsl:value-of select="$skipTCcount"/></td>
		<td><xsl:value-of select="$totalTCcount - $passTCcount - $skipTCcount"/></td>
		<td>
			<xsl:choose>
				<xsl:when test="($totalTCcount - $passTCcount - $skipTCcount) > 0">
					<xsl:call-template name="SetImage">
						<xsl:with-param name="size"  select="'16%'" />
						<xsl:with-param name="path"  select="'../../resources/images'" />
						<xsl:with-param name="status"  select="'fail'" />
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="($totalTCcount - $passTCcount ) = 0">
					<xsl:call-template name="SetImage">
						<xsl:with-param name="size"  select="'16%'" />
						<xsl:with-param name="path"  select="'../../resources/images'" />
						<xsl:with-param name="status"  select="'pass'" />
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="SetImage">
						<xsl:with-param name="size"  select="'16%'" />
						<xsl:with-param name="path"  select="'../../resources/images'" />
						<xsl:with-param name="status"  select="'skipped'" />
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


<!-- Create TestCase wise report -->
<xsl:template name="TestCase.report">

	<redirect:write file="../{../../@name}/{../@name}/{@scenarioId}/TestCase-report.html">
		<html>
			<head>
				<title>Scenario Report</title>
				<link rel="stylesheet" type="text/css" href="../../../resources/reportStyle.css"/>
			</head>
			<body>
				<xsl:call-template name="logo">
					<xsl:with-param name="backdir" select="'../../../resources/'"/>
				</xsl:call-template>
				<xsl:call-template name="set.heading">
					<xsl:with-param name="heading" select="@name"/>
				</xsl:call-template>

				<table width="100%" class="backpath">
					<tr><td colspan="4" >
							<a>
								<xsl:attribute name="href">../../feature-report.html</xsl:attribute>
								<xsl:value-of select="../../@name"/>
							</a>
							<xsl:text disable-output-escaping="no"> >> </xsl:text>
					<a>
						<xsl:attribute name="href">../scenario-report.html</xsl:attribute>
						<xsl:value-of select="../@name"/>
					</a>
					<xsl:text disable-output-escaping="no"> >> </xsl:text>
			<xsl:value-of select="@scenarioName"/>
		</td></tr>
</table>
<br/>
<xsl:call-template name="set.heading">
	<xsl:with-param name="heading" select="'TestCase'"/>
</xsl:call-template>
<table width="100%" class="details">
	<xsl:call-template name="AddHeadColumns">
		<xsl:with-param name="type" select="'Actions'"/>
	</xsl:call-template>
	<xsl:apply-templates select="*" mode="TestCasesummary"/>
</table>
<xsl:copy-of select="$copyright"/>
</body>
</html>
</redirect:write>
</xsl:template>

<xsl:template match="testcase" mode="TestCasesummary">
	<xsl:variable name="totalTCcount"><xsl:value-of select="count(current()//result)"/></xsl:variable>
	<xsl:variable name="passTCcount"><xsl:value-of select="count(current()//result[@value='true'])"/></xsl:variable>
	<xsl:variable name="skipTCcount"><xsl:value-of select="count(current()//result[@value='skipped'])"/></xsl:variable>

	<tr>
		<xsl:attribute name="class">
			<xsl:choose>
				<xsl:when test="$skipTCcount = $totalTCcount">
					<xsl:value-of select="'strikeout'" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<td>
			<xsl:call-template name="Action.report"/>
			<a>
				<xsl:attribute name="href">./<xsl:value-of select="@name"/>/Action-report.html</xsl:attribute>
				<xsl:value-of select="@name"/>
			</a>
		</td>
		<td><xsl:value-of select="$totalTCcount"/></td>
		<td><xsl:value-of select="$passTCcount"/></td>
		<td><xsl:value-of select="$skipTCcount"/></td>
		<td><xsl:value-of select="$totalTCcount - $passTCcount - $skipTCcount"/></td>
		<td>
			<xsl:choose>
				<xsl:when test="($totalTCcount - $passTCcount - $skipTCcount) > 0">
					<xsl:call-template name="SetImage">
						<xsl:with-param name="size"  select="'16%'" />
						<xsl:with-param name="path"  select="'../../../resources/images'" />
						<xsl:with-param name="status"  select="'fail'" />
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="($totalTCcount - $passTCcount ) = 0">
					<xsl:call-template name="SetImage">
						<xsl:with-param name="size"  select="'16%'" />
						<xsl:with-param name="path"  select="'../../../resources/images'" />
						<xsl:with-param name="status"  select="'pass'" />
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="SetImage">
						<xsl:with-param name="size"  select="'16%'" />
						<xsl:with-param name="path"  select="'../../../resources/images'" />
						<xsl:with-param name="status"  select="'skipped'" />
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</td>
		<xsl:variable name="timeCount" select="sum(current()//count/@timecount)"/>

		<td><xsl:call-template name="SetTime">
				<xsl:with-param name="time"  select="$timeCount" />
			</xsl:call-template>
		</td>
	</tr>
</xsl:template>

<!-- Create Action wise report -->
<xsl:template name="Action.report">
	<redirect:write file="../{../../../@name}/{../../@name}/{../@scenarioId}/{@name}/Action-report.html">
		<html>
			<head>
				<title>Scenario Report</title>
				<link rel="stylesheet" type="text/css" href="../../../../resources/reportStyle.css"/>
			</head>
			<body>
				<xsl:call-template name="logo">
					<xsl:with-param name="backdir" select="'../../../../resources/'"/>
				</xsl:call-template>

				<table width="100%" class="backpath">
					<tr>
						<td colspan="4" >
							<a>
								<xsl:attribute name="href">../../../feature-report.html</xsl:attribute>
								<xsl:value-of select="../../../@name"/>
							</a>
							<xsl:text disable-output-escaping="no"> >> </xsl:text>
							<a>
								<xsl:attribute name="href">../../scenario-report.html</xsl:attribute>
								<xsl:value-of select="../../@name"/>
							</a>
							<xsl:text disable-output-escaping="no"> >> </xsl:text>
							<a>
								<xsl:attribute name="href">../TestCase-report.html</xsl:attribute>
								<xsl:value-of select="../@scenarioName"/>
							</a>
							<xsl:text disable-output-escaping="no"> >> </xsl:text>
							<xsl:value-of select="@name"/>
						</td>
					</tr>
				</table>
				<xsl:call-template name="set.heading">
					<xsl:with-param name="heading" select="'Action'"/>
				</xsl:call-template>
				<table width="100%" class="details">
					<tr>
						<th align="left">  Name   </th>
						<th align="left">  Description   </th>
						<th align="center">  Tool Report   </th>
						<th align="center">  DataRow   </th>
						<th align="center">  Server Logs   </th>
						<th align="center">  Mode   </th>
						<th align="left">  Status   </th>
						<th align="left">  Time  </th>
						<th align="left">  Remarks   </th>
					</tr>
					<xsl:apply-templates select="*" mode="Actionsummary"/>
				</table>
				<xsl:copy-of select="$copyright"/>
			</body>
		</html>
	</redirect:write>
</xsl:template>



<xsl:template match="action" mode="Actionsummary">
	<xsl:variable name="actionLanguage" select="translate(@actionLanguage, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>

	<tr>
		<xsl:attribute name="class">
			<xsl:choose>
				<xsl:when test="result/@value = 'skipped'">
					<xsl:value-of select="'strikeout'" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<td>
			<xsl:choose>
				<xsl:when test="$actionLanguage = 'QTP'">
					<a>
						<xsl:attribute name="href">./<xsl:value-of select="@id"/>/screen-report.html</xsl:attribute>
						<xsl:attribute name="target">_blank</xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
						<xsl:value-of select="@name"/>
					</a>
					<xsl:call-template name="GenerateScreenReport"/>
				</xsl:when>
				<xsl:when test="$actionLanguage = 'SELENIUM'">
					<a>
						<xsl:attribute name="href">./<xsl:value-of select="@id"/>/screen-report.html</xsl:attribute>
						<xsl:attribute name="target">_blank</xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
						<xsl:value-of select="@name"/>
					</a>
					<xsl:call-template name="GenerateScreenReport"/>
				</xsl:when>
				<xsl:when test="$actionLanguage = 'WEBDRIVER'">
					<a>
						<xsl:attribute name="href">./<xsl:value-of select="@id"/>/screen-report.html</xsl:attribute>
						<xsl:attribute name="target">_blank</xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
						<xsl:value-of select="@name"/>
					</a>
					<xsl:call-template name="GenerateScreenReport"/>
				</xsl:when>
				<xsl:when test="$actionLanguage = 'CNL'">
					<a>
						<xsl:attribute name="href">./<xsl:value-of select="@id"/>/screen-report.html</xsl:attribute>
						<xsl:attribute name="target">_blank</xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
						<xsl:value-of select="@name"/>
					</a>
					<xsl:call-template name="GenerateScreenReport"/>
				</xsl:when>

				<xsl:when test="$actionLanguage = 'FEST'">
					<a>
						<xsl:attribute name="href">./<xsl:value-of select="@id"/>/screen-report.html</xsl:attribute>
						<xsl:attribute name="target">_blank</xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
						<xsl:value-of select="@name"/>
					</a>
					<xsl:call-template name="GenerateScreenReport"/>
				</xsl:when>
				<xsl:when test="$actionLanguage = 'IS_SERVICE'">
					<xsl:value-of select="@name"/>
				</xsl:when>
				<xsl:when test="$actionLanguage = 'VENUS'">
					<xsl:value-of select="@name"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@name"/>
				</xsl:otherwise>
			</xsl:choose>
		</td>
		<td align="left"><xsl:value-of select="@description"/> </td>
		<td align="center">
			<xsl:variable name="toolreport"><xsl:value-of select="result/@toolSpecificReport"/></xsl:variable>
			<xsl:if test="$toolreport != 'null'">
				<a>
					<xsl:attribute name="href">./<xsl:value-of select="@id"/>/<xsl:value-of select="concat($toolreport,'?actionid=',@id)"/></xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>
					<xsl:value-of select="@actionLanguage"/>
				</a>
			</xsl:if>

			<xsl:if test="$toolreport = 'null'">
				<xsl:value-of select="@actionLanguage"/>
			</xsl:if>
		</td>

		<td align="center">
			<xsl:variable name="datareport"><xsl:value-of select="datarow/@file"/></xsl:variable>
			<a>
				<xsl:attribute name="href">./<xsl:value-of select="@id"/>/<xsl:value-of select="$datareport"/></xsl:attribute>
				<xsl:attribute name="target">_blank</xsl:attribute>
				<xsl:value-of select="@dataRow"/>
			</a>
		</td>

		<td align="center">
			<a>
				<xsl:attribute name="href">./<xsl:value-of select="@id"/>/serverLogs.html</xsl:attribute>
				<xsl:attribute name="target">_blank</xsl:attribute>
				Server Logs
			</a>
			<xsl:call-template name="GenerateServerLogsReport"/>
		</td>

		<td align="center"><xsl:value-of select="@mode"/> </td>
		<xsl:apply-templates select="*" mode="actionstatus" >
			<xsl:with-param name="path1" select="'../../../../resources/images'"/>
		</xsl:apply-templates>
		<td><xsl:value-of select="result/@remarks"/> </td>
	</tr>
</xsl:template>


<xsl:template match="result" mode="actionstatus">
	<xsl:param name="path1" />
	<td align="middle">
		<xsl:if test="@value = 'true'">
			<xsl:call-template name="SetImage">
				<xsl:with-param name="status"  select="'pass'" />
				<xsl:with-param name="path"  select="$path1" />
				<xsl:with-param name="size"  select="'30%'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="@value = 'false'">
			<xsl:call-template name="SetImage">
				<xsl:with-param name="status"  select="'fail'" />
				<xsl:with-param name="path"  select="$path1" />
				<xsl:with-param name="size"  select="'30%'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="@value = 'skipped'">
			<xsl:call-template name="SetImage">
				<xsl:with-param name="status"  select="'skipped'" />
				<xsl:with-param name="path"  select="$path1" />
				<xsl:with-param name="size"  select="'30%'" />
			</xsl:call-template>
		</xsl:if>
	</td>
	<td><xsl:call-template name="SetTime">
			<xsl:with-param name="time"  select="@timetaken" />
		</xsl:call-template>
	</td>
</xsl:template>





<!-- Create Server Logs Report -->
<xsl:template name="GenerateServerLogsReport">
	<redirect:write file="../{../../../../../@name}/{../../../../@name}/{../../../@scenarioId}/{../../@name}/{@id}/serverLogs.html">
		<html>
			<head>
				<title>Server Logs</title>
				<link rel="stylesheet" type="text/css" href="../../../../../resources/reportStyle.css"/>
			</head>
			<body>
				<xsl:call-template name="logo">
					<xsl:with-param name="backdir" select="'../../../../../resources/'"/>
				</xsl:call-template>

				<xsl:call-template name="set.heading">
					<xsl:with-param name="heading" select="'Server Logs'"/>
				</xsl:call-template>
				<table width="100%" class="details">
					<tr>
						<th align="left">  Host   </th>
						<th align="left">  Component   </th>
						<th align="center">  Log File   </th>
						<th align="center">  Status  </th>
						<th align="left">  Remarks   </th>
					</tr>
					<xsl:apply-templates select="*" mode="serverlogs"/>
				</table>
				<xsl:copy-of select="$copyright"/>
			</body>
		</html>
	</redirect:write>
</xsl:template>


<xsl:template match="serverlog" mode="serverlogs">
	<tr>
		<td align="left"><xsl:value-of select="@host"/></td>
		<td align="left"><xsl:value-of select="@component"/></td>
		<td align="left">
			<a>
				<xsl:attribute name="href"><xsl:value-of select="@logFilePath"/></xsl:attribute>
				<xsl:attribute name="target">_blank</xsl:attribute>
				<xsl:value-of select="@displayName"/>
			</a>
		</td>
		<td align="middle">
			<xsl:choose>
				<xsl:when test="@status = 'PASS'">
					<img align="middle" width="30%" alt="right">
						<xsl:attribute name="src">../../../../../resources/images/right.png</xsl:attribute>
					</img>
				</xsl:when>
				<xsl:when test="@status = 'FAIL'">
					<img align="middle" width="30%" alt="failMark">
						<xsl:attribute name="src">../../../../../resources/images/failMark.png</xsl:attribute>
					</img>
				</xsl:when>
				<xsl:when test="@status = 'WARNING'">
					<img align="middle" width="30%" alt="skipped">
						<xsl:attribute name="src">../../../../../resources/images/skipped.png</xsl:attribute>
					</img>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@status"/>
				</xsl:otherwise>
			</xsl:choose>
		</td>

	</tr>
</xsl:template>


<xsl:template name="GenerateScreenReport">
	<redirect:write file="../{../../../../../@name}/{../../../../@name}/{../../../@scenarioId}/{../../@name}/{@id}/screen-report.html">
		<html>
			<head><title>ALF ScreenShot Report</title></head>
			<link rel="stylesheet" type="text/css" href="../../../../../resources/reportStyle.css"/>
			<body>
				<table width="100%" >
					<tr><td><b><font size="2">ALF ScreenShot Report >> <xsl:value-of select="../@name"/></font></b></td></tr>
			<tr><td width="100%" ><hr size="1"  /></td></tr>
		</table>
		<table width="100%" class="screen">
			<tr><td></td></tr>
			<tr align="left"><th>TimeStamp</th><th>Description</th><th>Status</th><th>Image</th></tr>
			<tr><td colspan="4"><h5>No of setps avilable are : <xsl:value-of select="count(current()/step)"/></h5></td></tr>
			<xsl:apply-templates select="*" mode="screenshots"/>
		</table>
		<xsl:copy-of select="$copyright"/>
	</body>
</html>
</redirect:write>
</xsl:template>

<xsl:template match="step" mode="screenshots">
	<tr>
		<xsl:attribute name="class">
			<xsl:value-of select="@result" />
		</xsl:attribute>
		<td align="left"><xsl:value-of select="@timestamp"/></td>
		<td align="left"><xsl:value-of select="@description"/></td>
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
		<td align="left">
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



<xsl:template name="set.heading">
	<xsl:param name="heading"/>
	<table width="100%">
		<tr><td colspan="4"><b><h3><xsl:value-of select="$heading"/></h3></b></td></tr>
	</table>
</xsl:template>

<xsl:template name="SetImage">
	<xsl:param name="status"/>
	<xsl:param name="size"/>
	<xsl:param name="path"/>
	<xsl:choose>
		<xsl:when test="$status = 'pass'">
			<img align="middle" alt="pass">
				<xsl:attribute name="src"><xsl:value-of select="$path"/>/right.png</xsl:attribute>
				<xsl:attribute name="width"><xsl:value-of select="$size"/></xsl:attribute>
			</img>
		</xsl:when>
		<xsl:when test="$status = 'fail'">
			<img align="middle" alt="fail">
				<xsl:attribute name="src"><xsl:value-of select="$path"/>/failMark.png</xsl:attribute>
				<xsl:attribute name="width"><xsl:value-of select="$size"/></xsl:attribute>
			</img>
		</xsl:when>
		<xsl:when test="$status = 'skipped'">
			<img align="middle" alt="skipped">
				<xsl:attribute name="src"><xsl:value-of select="$path"/>/skipped.png</xsl:attribute>
				<xsl:attribute name="width"><xsl:value-of select="$size"/></xsl:attribute>
			</img>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$status"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="AddHeadColumns">
	<xsl:param name="type"/>
	<tr>
		<th align="left"> Name  </th>
		<xsl:choose>
			<xsl:when test="$type='Actions'">
				<th align="left"> Actions  </th>
			</xsl:when>
			<xsl:otherwise>
				<th align="left"> Tests  </th>
			</xsl:otherwise>
		</xsl:choose>

		<th align="left"> Success  </th>
		<th align="left"> Skipped  </th>
		<th align="left"> Failures </th>
		<th align="left"> Status </th>
		<th align="left"> Time </th>
	</tr>
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


<!-- Style Sheet for the QTP Report report "Results.xml"  -->
<xsl:template name="PResults.css">
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
</xsl:template>

<xsl:template name="reportStyle.css">
				body {
				    font:normal 68% verdana,arial,helvetica;
				    color:#000000;
				    }
				table tr th {
				    font:normal 85% verdana,arial,helvetica;
				    text-align:left;
				    font-weight: bold;
				    color:#233356;
				    }
				table tr td {
				    font:normal 85% verdana,arial,helvetica;
				    }
				table.details tr th{
				    font-weight: bold;
				    font:size:85%;
				    text-align:left;
				    background:#a6caf0;
				}
				table.details tr td{
				    background:#eeeee0;
				    font:normal 75% verdana,arial,helvetica;
				    color:black;
				    }
				table.backpath tr td{
				    font:normal 75% verdana,arial,helvetica;
				    font-weight: bold;
				    color:#C5AA5B;
				    }
				table.screen tr th{
				    font-weight: bold;
				    font:size:85%;
				    text-align:middle;
				    background:#a6caf0;
				}
				table.screen tr.PASS{
				    background:#eeeee0;
				}
				table.screen tr.FAIL{
				    background:red;
				}
			    table.screen tr.WARNING{
			    background:yellow;
			    }
				table.screen td{
				    font:normal 75% verdana,arial,helvetica;
				}
				tr.strikeout td {
					position:relative
				}
				tr.strikeout td:before {
					content: " ";
					position: absolute;
					top: 50%;
					left: 0;
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
				    margin: 0px 0px 5px; font: 175% verdana,arial,helvetica;
				}
				h2 {
				    margin-top: 1em; margin-bottom: 0.5em; font: bold 120% verdana,arial,helvetica
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
				    margin-bottom: 0.5em; font: bold 90% verdana,arial,helvetica
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
				a:link  	  {   	color: #02A1B7 }
				a:visited 	  {  	color: #2200CC }
				a:active 	  {  	color: #FF00FF }
</xsl:template>

</xsl:stylesheet>
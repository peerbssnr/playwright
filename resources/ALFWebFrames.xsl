<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				version="1.0" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:redirect="http://xml.apache.org/xalan/redirect"
				xmlns:stringutils="xalan://org.apache.tools.ant.util.StringUtils"
				extension-element-prefixes="redirect dyn" xmlns:dyn="http://exslt.org/dynamic">


	<xsl:output method="html" indent="yes" encoding="US-ASCII" />
	<xsl:variable name="CSSPath">
		../resources/reportStyle.css
	</xsl:variable>
	<xsl:variable name="BootStrapPath">
		../resources/lib/bootstrap.min.css
	</xsl:variable>
	<xsl:template name="logo">
		<xsl:param name="backdir" />
		<table width="100%">
			<tr>
				<th>
					<h2>SAT Report</h2>
				</th>
				<td align="right">
					<img width="20%">
						<xsl:attribute name="src">
							<xsl:value-of select="$backdir" />/images/logo.png</xsl:attribute>
					</img>
					<!--<div class="page-header">
						<h3 align="right">SOFTWARE AG AGILE TESTER REPORT </h3></div>-->
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<hr />
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:variable name="copyright">
		<nav class="navbar navbar-default navbar-fixed-bottom" style="min-height: 24px;">
			<div class="container" align="center">
				<td width="100%" align="middle">COPYRIGHT &#169; 2019 SOFTWARE AG</td>
			</div>
		</nav>
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

		<!-- Create topleveltestsuite-frame.html -->
		<redirect:write file="./topleveltestsuite-frame.html">
			<xsl:call-template name="topleveltestsuite-frame.html" />
		</redirect:write>

		<!-- Create project-overview.html -->
		<redirect:write file="./project-overview.html">
			<xsl:call-template name="project-overview.html" />
		</redirect:write>

		<redirect:write file="./AllSummary-frame.html">
			<xsl:call-template name="allSummary-frame.html" />
		</redirect:write>

		<redirect:write file="./AlfProperties-frame.html">
			<xsl:call-template name="alfproperties-frame.html" />
		</redirect:write>

		<!-- Create index.html -->
		<html>
			<head>
				<title>SAT Report</title>
			</head>
			<frameset cols="20%,80%">
				<frameset rows="40%,60%">
					<frame src="./resources/topleveltestsuite-frame.html" name="ToplevelTestSuiteFrame" />
					<frame src="./resources/AllSummary-frame.html" name="ComponentDescFrame" />
				</frameset>
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



	<xsl:template name="topleveltestsuite-frame.html">
		<html>
			<head>
				<title>TopLevel Test Suites</title>
				<link rel="stylesheet" type="text/css" href="reportStyle.css" />
				<link rel="stylesheet" type="text/css" href="./lib/bootstrap.min.css" />
				<link rel="stylesheet" type="text/css" href="./lib/alfReport.css"/>
			</head>
			<body>
				<table width="100%" align="center" nowrap="nowrap" name="mainCall">
					<xsl:apply-templates select="*" mode="main" />
				</table>
			</body>
		</html>
	</xsl:template>
	<!-- main page call -->

	<xsl:template match="project" mode="main">
		<tr>
			<td align="middle" valign="middle">
				<b>
					<h3>
						<a>
							<xsl:attribute name="href">./project-overview.html</xsl:attribute>
							<xsl:attribute name="target">rightFrame</xsl:attribute>
							<xsl:value-of select="@name" />
						</a>
					</h3>
				
				</b>
			</td>
		</tr>
		<tr>
			<td align="middle">
				<i>
					<h6>
						<sup>
							ALF Version:
							<xsl:value-of select="@alfVersion" />
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
							<xsl:value-of select="@startTime" />
						</sup>
					</h6>
				</i>
			</td>
		</tr>
		<tr>
			<th>
				<h4>  Top Level Test Suites</h4>
			</th>
		</tr>
		<tr>
			<td>
				<ol class="summarylist">`
					<xsl:for-each
							select="current()/testsuite[not(@status='disabled' or @status='excluded')]">
						<xsl:variable name="totalCase">
							<xsl:value-of
									select="sum(current()//count[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@total)" />
						</xsl:variable>
						<xsl:variable name="passedCase">
							<xsl:value-of
									select="sum(current()//count[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@pass)" />
						</xsl:variable>
						<xsl:variable name="skippedCase">
							<xsl:value-of
									select="sum(current()//count[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@skipped)" />
						</xsl:variable>
						<xsl:variable name="failedCase"
									  select="$totalCase - $passedCase - $skippedCase" />
						<li>
							<div class="lineOverFlow">
								<a>
									<xsl:attribute name="href">../<xsl:value-of select="../@id" />/<xsl:value-of select="@id" />/testsuite-report.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									<xsl:attribute name="title">
										<xsl:value-of select="@name" />
									</xsl:attribute>
									<xsl:value-of select="@name" />
								</a>
							</div>
							<span class="badge alert-info">
								<xsl:attribute name="title">Total <xsl:value-of select="$totalCase"/> Cases</xsl:attribute>
								<xsl:value-of select="$totalCase" />
							</span>
							<span class="badge alert-success">
								<xsl:attribute name="title"><xsl:value-of select="$passedCase"/> Cases passed</xsl:attribute>
								<xsl:value-of select="$passedCase" />
							</span>
							<span class="badge alert-danger">
								<xsl:attribute name="title"><xsl:value-of select="$failedCase"/> Cases failed</xsl:attribute>
								<xsl:value-of select="$failedCase" />
							</span>
							<span class="badge alert-warning">
								<xsl:attribute name="title"><xsl:value-of select="$skippedCase"/> Cases skipped</xsl:attribute>
								<xsl:value-of select="$skippedCase" />
							</span>
						</li>
					</xsl:for-each>
				</ol>
			</td>
		</tr>
	</xsl:template>
	<!-- project overview -->

	<xsl:template name="project-overview.html">
		<html>
			<head>
				<title>SAT Report</title>
				<link rel="stylesheet" type="text/css" href="reportStyle.css" />
				<link rel="stylesheet" type="text/css" href="./lib/bootstrap.min.css" />
				<link rel="stylesheet" type="text/css" href="./lib/alfReport.css"/>
			</head>
			<body>
				<xsl:call-template name="logo">
					<xsl:with-param name="backdir" select="'.'" />
				</xsl:call-template>
				<xsl:call-template name="set.heading">
					<xsl:with-param name="heading" select="'Summary'" />
				</xsl:call-template>

				<!-- create the project summary table -->
				<xsl:call-template name="set.project.summary.details">
				</xsl:call-template>

				<table width="100%" class="alftable table table-hover">
					<thead class="trhead">
						<th align="left" width="10%">Tests </th>
						<th align="left" width="10%">Success </th>
						<th align="left" width="10%">Skipped </th>
						<th align="left" width="10%">Failures </th>
						<th align="left" width="10%">Success rate </th>
						<th align="left" width="10%">Time </th>
					</thead>
					<tr>

						<!-- testcases such as before suite/ after suite are not considered
							while counting the total number of cases -->
						<xsl:variable name="totalTCcount">
							<xsl:value-of
									select="sum(current()//count[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@total)" />
						</xsl:variable>
						<xsl:variable name="passTCcount">
							<xsl:value-of
									select="sum(current()//count[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@pass)" />
						</xsl:variable>
						<xsl:variable name="skipTCcount">
							<xsl:value-of
									select="sum(current()//count[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@skipped)" />
						</xsl:variable>
						<xsl:variable name="failTCcount">
							<xsl:value-of
									select="$totalTCcount - $passTCcount -  $skipTCcount" />
						</xsl:variable>
						<xsl:variable name="successRate"
									  select="($totalTCcount - $failTCcount - $skipTCcount ) div $totalTCcount" />
						<xsl:variable name="timeCount"
									  select="sum(current()//..//testcase/@timeCount)" />

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
							<xsl:value-of select="$skipTCcount" />
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
				<!-- Listing before project scenarios -->

				<xsl:if
						test="project/beforesuite/testcase[not(@status='disabled' or @status='excluded')]">
					<xsl:call-template name="set.heading">
						<xsl:with-param name="heading" select="'Before Project'" />
					</xsl:call-template>
					<table width="100%" class="alfTable
					 table table-hover">
						<xsl:call-template name="AddHeadColumns">
							<xsl:with-param name="type" select="'testcase'"></xsl:with-param>
						</xsl:call-template>
						<xsl:apply-templates
								select="project/beforesuite/testcase[not(@status='disabled' or @status='excluded')]"
								mode="beforeAndAfterProjectListing">
						</xsl:apply-templates>
					</table>
				</xsl:if>

				<!-- Setting the headings -->

				<xsl:call-template name="set.heading">
					<xsl:with-param name="heading" select="'Test Suites'" />
				</xsl:call-template>
				<table width="100%" class="alfTable table table-hover">
					<xsl:call-template name="AddHeadColumns" >
						<xsl:with-param name="type" select="'testcase'"/>
					</xsl:call-template>

					<!-- List test suites -->

					<xsl:apply-templates
							select="/project/testsuite[not(@status='disabled' or @status='excluded')]"
							mode="toplevel-testsuite-listing">
						<xsl:with-param name="resourcesFolderPath" select="'resources'" />
					</xsl:apply-templates>
				</table>
				<br />
				<br />

				<!-- Listing after project scenarios -->

				<xsl:if
						test="project/aftersuite/testcase[not(@status='disabled' or @status='excluded')]">
					<xsl:call-template name="set.heading">
						<xsl:with-param name="heading" select="'After Project'" />
					</xsl:call-template>
					<table width="100%" class="table table-hover">
						<xsl:call-template name="AddHeadColumns">
							<xsl:with-param name="type" select="'Test case'"/></xsl:call-template>
						<xsl:apply-templates
								select="project/aftersuite/testcase[not(@status='disabled' or @status='excluded')]"
								mode="beforeAndAfterProjectListing">
						</xsl:apply-templates>
					</table>
					<br />
					<br />
					<br />
				</xsl:if>
				<xsl:copy-of select="$copyright" />
			</body>
		</html>
	</xsl:template>

	<xsl:template name="set.project.summary.details">
		<table width="100%" class="alfTable table table-hover">
			<thead class="trhead">
				<th align="left" width="10%" title="Executed project name">ProjectName </th>
				<th align="left" width="10%" title="IDs of the assets executed">AssetsExecuted</th>
				<th align="left" width="10%" title="Version of the project executed">VersionExecuted</th>
				<th align="left" width="10%" title="category of assets executed">CategoryExecuted</th>
				<th align="left" width="10%" title="category test steps excluded from execution">CategoryExcluded</th>
				<th align="left" width="10%" title="Version of the prediction engine actions executed">CNLStepVersion</th>
				<th align="left" width="10%" title="Properties used for execution">EnvironmentalProperties</th>
			</thead>
			<tr>

				<td>
					<xsl:value-of select="project/@name" />
				</td>
				<td>
					<xsl:value-of select="project/@assetsExecute" />
				</td>
				<td>
					<xsl:value-of select="project/@projectVersion" />
				</td>
				<td>
					<xsl:value-of select="project/@categoryIncluded" />
				</td>
				<td>
					<xsl:value-of select="project/@categoryExcluded" />
				</td>
				<td>
					<xsl:value-of select="project/@predictionEngineVersion" />
				</td>
				<td>
					<a href="AlfProperties-frame.html"> Show Properties
					</a>
				</td>
			</tr>
		</table>
	</xsl:template>



	<!-- TopLevel Testsuite toplevel-testsuite-listing details -->
	<xsl:template match="/project/testsuite" mode="toplevel-testsuite-listing">
		<xsl:param name="resourcesFolderPath" />
		<xsl:variable name="totalTCcount">
			<xsl:value-of
					select="sum(current()//count[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@total)" />
		</xsl:variable>
		<xsl:variable name="passTCcount">
			<xsl:value-of
					select="sum(current()//count[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@pass)" />
		</xsl:variable>
		<xsl:variable name="skipTCcount">
			<xsl:value-of
					select="sum(current()//count[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@skipped)" />
		</xsl:variable>
		<xsl:variable name="failTCcount" select="$totalTCcount - $passTCcount -  $skipTCcount"/>
		<xsl:variable name="status">
			<xsl:value-of select="@status" />
		</xsl:variable>

		<!-- 		<xsl:variable name="averageTimeSum"> -->
		<!-- 			<xsl:value-of select="sum(current()//testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@averageTimeTaken)"></xsl:value-of> -->
		<!-- 		</xsl:variable> -->

		<!-- 		<xsl:variable name="totalTestcaseExecutionTime"> -->
		<!-- 			<xsl:value-of select="sum(current()//testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@timeCount)"></xsl:value-of> -->
		<!-- 		</xsl:variable> -->

		<!-- 		<xsl:variable name="timeStatus"> -->
		<!-- 		<xsl:choose> -->
		<!-- 			<xsl:when test="$averageTimeSum = 0"> -->
		<!-- 			<xsl:value-of select="$averageTimeSum"></xsl:value-of> -->
		<!-- 			</xsl:when> -->
		<!-- 			<xsl:otherwise>		 -->
		<!-- 			<xsl:value-of select="$totalTestcaseExecutionTime - $averageTimeSum"></xsl:value-of> -->
		<!-- 			</xsl:otherwise>	 -->
		<!-- 			</xsl:choose> -->
		<!-- 		</xsl:variable> -->

		<xsl:variable name="remarks">
			<xsl:value-of select="@remarks" />
		</xsl:variable>
		<!-- variable indicate the before/after suite/case failure count -->
		<xsl:variable name="depStatus">
			<xsl:value-of select="sum(current()//depCount/@fail)" />
		</xsl:variable>
		<tr>
			<xsl:attribute name="class">
				<xsl:value-of select="''" />
			</xsl:attribute>
			<td>

				<!-- Generate reports for all child test suites -->
				<xsl:call-template name="generate-testsuite-report.html">
					<!-- parentFolderPath will be ../(name of project) -->
					<xsl:with-param name="parentFolderPath" select="concat('../', ../@id)" />
					<xsl:with-param name="resourcesFolderPath"
									select="concat('../../', $resourcesFolderPath)" />
					<xsl:with-param name="Level">
						<xsl:value-of select="1" />
					</xsl:with-param>
				</xsl:call-template>

				<!-- List all child test suites -->
				<a>
					<xsl:attribute name="href">../<xsl:value-of select="../@id" />/<xsl:value-of select="@id" />/testsuite-report.html</xsl:attribute>
					<xsl:value-of select="@name" />
				</a>
			</td>
			<td class="wordBreak">
				<xsl:value-of select="@description" />
			</td>
			<td>
				<xsl:value-of select="$totalTCcount" />
			</td>
			<td>
				<xsl:value-of select="$passTCcount" />
			</td>
			<td>
				<xsl:value-of select="$skipTCcount" />
			</td>
			<td>
				<xsl:value-of
						select="$failTCcount" />
			</td>
			<td>
				<xsl:call-template name="displayprogressbar">
					<xsl:with-param name="totalCount" select="$totalTCcount"/>
					<xsl:with-param name="passedCount" select="$passTCcount"/>
					<xsl:with-param name="failedCount" select="$failTCcount"/>
					<xsl:with-param name="skippedCount" select="$skipTCcount"/>

				</xsl:call-template>
			</td>
			<xsl:variable name="timeCount"
						  select="@timeCount" />
			<td>
				<xsl:call-template name="SetTime">
					<xsl:with-param name="time" select="$timeCount" />
				</xsl:call-template>
			</td>
			<!-- 			<td> -->
			<!-- 				<xsl:call-template name="setTimeStatus"> -->
			<!-- 					<xsl:with-param name="timeStatus" select="$timeStatus" /> -->
			<!-- 				</xsl:call-template> -->
			<!-- 			</td> -->
			<td class="wordBreak">
				<xsl:value-of select="$remarks" />
			</td>
		</tr>
	</xsl:template>



	<!-- Create Testsuite wise report -->
	<xsl:template name="generate-testsuite-report.html">
		<xsl:param name="parentFolderPath" />
		<xsl:param name="resourcesFolderPath" />
		<xsl:param name="Level" />
		<redirect:write file="{$parentFolderPath}/{@id}/testsuite-report.html">
			<html>
				<head>
					<title>TestSuite Report</title>
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
							<xsl:value-of select="$resourcesFolderPath"/>/lib/bootstrap.min.css</xsl:attribute>
					</link>
					<link>
						<xsl:attribute name="rel">stylesheet</xsl:attribute>
						<xsl:attribute name="type">text/css</xsl:attribute>
						<xsl:attribute name="href">
							<xsl:value-of select="$resourcesFolderPath"/>/lib/alfReport.css</xsl:attribute>
					</link>
				</head>
				<body>
					<xsl:call-template name="logo">
						<xsl:with-param name="backdir" select="$resourcesFolderPath" />
					</xsl:call-template>

					<ol class="breadcrumb">
						<!-- Generate bredcrump on top of the page -->
						<xsl:call-template name="generateLink">
							<xsl:with-param name="totalCount" select="$Level" />
							<xsl:with-param name="LevelCounter" select="$Level" />
						</xsl:call-template>
						<li class="breadcrump active" font-color="black">
							<xsl:value-of select="@name" />
						</li>
					</ol>

					<!-- Generating and diplaying result for before every test cases in
						lower level suites -->
					<xsl:if
							test="beforeeverysuite/testcase[not(@status='disabled' or @status='excluded')]">
						<xsl:call-template name="set.heading">
							<xsl:with-param name="heading" select="'Before Every Suite'" />
						</xsl:call-template>
						<table width="100%" class="alfTable table table-hover">
							<xsl:call-template name="AddHeadColumns">
								<xsl:with-param name="type" select="'Test Case'"/>
							</xsl:call-template>
							<xsl:apply-templates
									select="beforeeverysuite/testcase[not(@status='disabled' or @status='excluded')]"
									mode="childTestCaseListing">
								<xsl:with-param name="parentFolderPath"
												select="concat($parentFolderPath,'/','/', @id)" />
								<xsl:with-param name="resourcesFolderPath"
												select="$resourcesFolderPath" />
								<xsl:with-param name="Level" select="$Level" />
							</xsl:apply-templates>
						</table>
					</xsl:if>

					<!-- Chekcing whether the test suite contains child suites or child
						test cases -->
					<xsl:choose>
						<xsl:when test="testsuite">
							<!-- Generating and diplaying result for before test cases in lower
								level suites -->
							<xsl:if
									test="beforesuite/testcase[not(@status='disabled' or @status='excluded')]">
								<xsl:call-template name="set.heading">
									<xsl:with-param name="heading" select="'Before Suite'" />
								</xsl:call-template>
								<table width="100%" class="alfTable table table-hover">
									<xsl:call-template name="AddHeadColumns">
										<xsl:with-param name="type" select="'Test Case'"/>
									</xsl:call-template>
									<xsl:apply-templates
											select="beforesuite/testcase[not(@status='disabled' or @status='excluded')]"
											mode="childTestCaseListing">
										<xsl:with-param name="parentFolderPath"
														select="concat($parentFolderPath,'/','/', @id)" />
										<xsl:with-param name="resourcesFolderPath"
														select="$resourcesFolderPath" />
										<xsl:with-param name="Level" select="$Level" />
									</xsl:apply-templates>
								</table>
								<br />
								<br />
							</xsl:if>

							<xsl:call-template name="set.heading">
								<xsl:with-param name="heading" select="'TestSuites:'" />
							</xsl:call-template>

							<table width="100%" class="alfTable table table-hover">
								<xsl:call-template name="AddHeadColumns">
									<xsl:with-param name="type" select="'Test Case'"/>
								</xsl:call-template>
								<xsl:apply-templates mode="childTestSuiteListing"
													 select="testsuite[not(@status='disabled' or @status='excluded')]">
									<xsl:with-param name="parentFolderPath"
													select="concat($parentFolderPath, '/', @id)" />
									<xsl:with-param name="resourcesFolderPath"
													select="$resourcesFolderPath" />
									<xsl:with-param name="Level" select="$Level" />
								</xsl:apply-templates>
							</table>

							<!-- Generating and diplaying result for after test cases in lower
								level suites -->
							<xsl:if
									test="aftersuite/testcase[not(@status='disabled' or @status='excluded')]">
								<xsl:call-template name="set.heading">
									<xsl:with-param name="heading" select="'After Suite'" />
								</xsl:call-template>
								<table width="100%" class="alfTable table table-hover">
									<xsl:call-template name="AddHeadColumns">
										<xsl:with-param name="type" select="'Test Case'"/>
									</xsl:call-template>
									<xsl:apply-templates
											select="aftersuite/testcase[not(@status='disabled' or @status='excluded')]"
											mode="childTestCaseListing">
										<xsl:with-param name="parentFolderPath"
														select="concat($parentFolderPath,'//',@id)" />
										<xsl:with-param name="resourcesFolderPath"
														select="$resourcesFolderPath" />
										<xsl:with-param name="Level" select="$Level" />
									</xsl:apply-templates>
								</table>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if
									test="beforecase/teststep[not(@status='disabled' or @status='excluded')]">
								<xsl:call-template name="beforeAndAftercaseListing">
									<xsl:with-param name="parentFolderPath" select="$parentFolderPath" />
									<xsl:with-param name="resourcesFolderPath"
													select="$resourcesFolderPath" />
									<xsl:with-param name="beforeOrAfterStatus"
													select="'beforecase'" />
									<xsl:with-param name="level" select="$Level+1"/>
								</xsl:call-template>
							</xsl:if>

							<xsl:call-template name="set.heading">
								<xsl:with-param name="heading" select="' TestCases'" />
							</xsl:call-template>
							<table width="100%" class="alfTable table table-hover">
								<xsl:call-template name="AddHeadColumns">
									<xsl:with-param name="type" select="'Test Case'"/>
								</xsl:call-template>
								<xsl:apply-templates
										select="testcase[not(@status='disabled' or @status='excluded')]"
										mode="childTestCaseListing">
									<xsl:with-param name="parentFolderPath"
													select="concat($parentFolderPath, '/', @id)" />
									<xsl:with-param name="resourcesFolderPath"
													select="$resourcesFolderPath" />
									<xsl:with-param name="Level" select="$Level" />
								</xsl:apply-templates>
							</table>

							<!-- checking whether there is after case, if yes display the result -->
							<xsl:if
									test="aftercase/teststep[not(@status='disabled' or @stauts='excluded')]">
								<xsl:call-template name="beforeAndAftercaseListing">
									<xsl:with-param name="parentFolderPath" select="$parentFolderPath" />
									<xsl:with-param name="resourcesFolderPath"
													select="$resourcesFolderPath" />
									<xsl:with-param name="beforeOrAfterStatus"
													select="'aftercase'" />
									<xsl:with-param name="level" select="$Level+1"/>
 								</xsl:call-template>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>


					<!-- Generating and diplaying result for before every test cases in
						lower level suites -->
					<xsl:if
							test="aftereverysuite/testcase[not(@status='disabled' or @status='excluded')]">
						<xsl:call-template name="set.heading">
							<xsl:with-param name="heading" select="'After Every Suite'" />
						</xsl:call-template>
						<table width="100%" class="alfTable table table-hover">
							<xsl:call-template name="AddHeadColumns">
								<xsl:with-param name="type" select="'Test Case'"/>
							</xsl:call-template>
							<xsl:apply-templates
									select="aftereverysuite/testcase[not(@status='disabled' or @status='excluded')]"
									mode="childTestCaseListing">
								<xsl:with-param name="parentFolderPath"
												select="concat($parentFolderPath,'/','/', @id)" />
								<xsl:with-param name="resourcesFolderPath"
												select="$resourcesFolderPath" />
								<xsl:with-param name="Level" select="$Level" />
							</xsl:apply-templates>
						</table>
						<br />
						<br />
					</xsl:if>
					<xsl:copy-of select="$copyright" />
				</body>
			</html>
		</redirect:write>
	</xsl:template>


	<!-- displaying the before and after case result in testsuite-report.html
		, selecting either beforecase or after case will be depended upon the value
		passed for param 'beforeOrAfterStatus' -->
	<xsl:template name="beforeAndAftercaseListing">
		<xsl:param name="parentFolderPath" />
		<xsl:param name="resourcesFolderPath" />
		<xsl:param name="beforeOrAfterStatus" />
		<xsl:param name="level"/>

		<xsl:choose>
			<xsl:when test="$beforeOrAfterStatus = 'beforecase'">
				<xsl:call-template name="set.heading">
					<xsl:with-param name="heading" select="'Set Up'" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$beforeOrAfterStatus = 'beforeeverycase'">
				<xsl:call-template name="set.heading">
					<xsl:with-param name="heading" select="'Before Every Case'" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$beforeOrAfterStatus = 'aftereverycase'">
				<xsl:call-template name="set.heading">
					<xsl:with-param name="heading" select="'After Every Case'" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="set.heading">
					<xsl:with-param name="heading" select="'Tear Down'" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		<table width="100%" class="alfTable table table-hover">
			<thead class="trhead">
				<th align="left"> Name </th>
				<th align="left"> Description </th>
				<th align="center"> Tool Report </th>
				<th align="center"> DataRow </th>
				<th align="center"> Analytics </th>
				<th align="left"> Status </th>
				<th align="left"> Time </th>
				<!-- 				<th align="left"> Time Stauts</th> -->
				<th align="left"> Remarks </th>
			</thead>
			<xsl:if test="$beforeOrAfterStatus = 'beforecase'">
				<xsl:apply-templates select="beforecase/teststep"
									 mode="childTestStepListing">
					<xsl:with-param name="parentFolderPath"
									select="concat($parentFolderPath,'/',@id)" />
					<xsl:with-param name="resourcesFolderPath" select="$resourcesFolderPath" />
					<xsl:with-param name="level" select="$level"></xsl:with-param>
				</xsl:apply-templates>
			</xsl:if>

			<xsl:if test="$beforeOrAfterStatus = 'beforeeverycase'">
				<xsl:apply-templates select="beforeeverycase/teststep"
									 mode="childTestStepListing">
					<xsl:with-param name="parentFolderPath"
									select="concat($parentFolderPath,'/',@id)" />
					<xsl:with-param name="resourcesFolderPath" select="$resourcesFolderPath" />
					<xsl:with-param name="level" select="-1"></xsl:with-param>
				</xsl:apply-templates>
			</xsl:if>

			<xsl:if test="$beforeOrAfterStatus = 'aftercase'">
				<xsl:apply-templates select="aftercase/teststep"
									 mode="childTestStepListing">
					<xsl:with-param name="parentFolderPath"
									select="concat($parentFolderPath,'/',@id)" />
					<xsl:with-param name="resourcesFolderPath" select="$resourcesFolderPath" />
					<xsl:with-param name="level" select="$level"></xsl:with-param>
				</xsl:apply-templates>
			</xsl:if>

			<xsl:if test="$beforeOrAfterStatus = 'aftereverycase'">
				<xsl:apply-templates select="aftereverycase/teststep"
									 mode="childTestStepListing">
					<xsl:with-param name="parentFolderPath"
									select="concat($parentFolderPath,'/',@id)" />
					<xsl:with-param name="resourcesFolderPath" select="$resourcesFolderPath" />
					<xsl:with-param name="level" select="-1"></xsl:with-param>
				</xsl:apply-templates>
			</xsl:if>
		</table>
	</xsl:template>
	<xsl:template match="testsuite" mode="childTestSuiteListing">
		<xsl:param name="parentFolderPath" />
		<xsl:param name="resourcesFolderPath" />
		<xsl:param name="Level" />

		<!-- get testCase counts -->
		<xsl:variable name="totalTCcount">
			<xsl:value-of
					select="sum(current()//count[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@total)" />
		</xsl:variable>

		<xsl:variable name="passTCcount">
			<xsl:value-of
					select="sum(current()//count[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@pass)" />
		</xsl:variable>

		<xsl:variable name="skipTCcount">
			<xsl:value-of
					select="sum(current()//count[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@skipped)" />
		</xsl:variable>


		<xsl:variable name="failTCcount">
			<xsl:value-of
					select="$totalTCcount - $passTCcount - $skipTCcount " />
		</xsl:variable>

		<xsl:variable name="status">
			<xsl:value-of select="@status" />
		</xsl:variable>

		<xsl:variable name="remarks">
			<xsl:value-of select="@remarks" />
		</xsl:variable>

		<xsl:variable name="timeCount">
			<xsl:value-of
					select="@timeCount" />
		</xsl:variable>

		<!-- 		<xsl:variable name="averageTimeSum"> -->
		<!-- 			<xsl:value-of select="sum(current()//testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@averageTimeTaken)"></xsl:value-of> -->
		<!-- 		</xsl:variable> -->
		<!-- 		<xsl:variable name="totalTestcaseExecutionTime"> -->
		<!-- 			<xsl:value-of select="sum(current()//testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@timeCount)"></xsl:value-of> -->
		<!-- 		</xsl:variable> -->

		<!-- 		<xsl:variable name="timeStatus"> -->
		<!-- 		<xsl:choose> -->
		<!-- 			<xsl:when test="$averageTimeSum = 0"> -->
		<!-- 			<xsl:value-of select="$averageTimeSum"></xsl:value-of> -->
		<!-- 			</xsl:when> -->
		<!-- 			<xsl:otherwise>		 -->
		<!-- 			<xsl:value-of select="$totalTestcaseExecutionTime - $averageTimeSum"></xsl:value-of> -->
		<!-- 			</xsl:otherwise>	 -->
		<!-- 			</xsl:choose> -->
		<!-- 		</xsl:variable> -->

		<xsl:variable name="depStatus">
			<xsl:value-of select="sum(current()//depCount/@fail)" />
		</xsl:variable>

		<tr>
			<xsl:attribute name="class">
				<xsl:value-of select="''" />
			</xsl:attribute>
			<td>
				<xsl:call-template name="generate-testsuite-report.html">
					<xsl:with-param name="parentFolderPath" select="$parentFolderPath" />
					<xsl:with-param name="resourcesFolderPath"
									select="concat('../', $resourcesFolderPath)" />
					<xsl:with-param name="Level" select="$Level+1" />

				</xsl:call-template>
				<a>
					<xsl:attribute name="href">./<xsl:value-of select="@id" />/testsuite-report.html</xsl:attribute>
					<xsl:value-of select="@name" />
				</a>
			</td>
			<td class="wordBreak">
				<xsl:value-of select="@description" />
			</td>
			<td>
				<xsl:value-of select="$totalTCcount" />
			</td>
			<td>
				<xsl:value-of select="$passTCcount" />
			</td>
			<td>
				<xsl:value-of select="$skipTCcount" />
			</td>
			<td>
				<xsl:value-of select="$failTCcount" />
			</td>
			<!--<td>-->
			<!--<xsl:call-template name="SetImage">-->
			<!--<xsl:with-param name="size" select="'16%'" />-->
			<!--<xsl:with-param name="resourcesFolderPath">-->
			<!--<xsl:value-of select="$resourcesFolderPath" />-->
			<!--</xsl:with-param>-->
			<!--<xsl:with-param name="status" select="$status" />-->
			<!--</xsl:call-template>-->
			<!--</td>-->

			<td>

				<xsl:call-template name="displayprogressbar">
					<xsl:with-param name="totalCount" select="$totalTCcount"/>
					<xsl:with-param name="passedCount" select="$passTCcount"/>
					<xsl:with-param name="failedCount" select="$failTCcount"/>
					<xsl:with-param name="skippedCount" select="$skipTCcount"/>

				</xsl:call-template>
			</td>
			<td>
				<xsl:call-template name="SetTime">
					<xsl:with-param name="time" select="$timeCount" />
				</xsl:call-template>
			</td>
			<!-- 			<td> -->
			<!-- 				<xsl:call-template name="setTimeStatus"> -->
			<!-- 					<xsl:with-param name="timeStatus" select="$timeStatus" /> -->
			<!-- 				</xsl:call-template> -->
			<!-- 			</td> -->
			<td class="wordBreak">
				<xsl:value-of select="$remarks" />
			</td>
		</tr>
	</xsl:template>

	<!-- template for generating and displaying before and after project test
		cases -->

	<xsl:template match="testcase" mode="beforeAndAfterProjectListing">
		<xsl:param name="resourcesFolderPath" select="'../resources'" />

		<!-- get test case counts -->
		<xsl:variable name="totalTCcount">
			<xsl:value-of select="sum(current()//count/@total)" />
		</xsl:variable>

		<xsl:variable name="passTCcount">
			<xsl:value-of select="sum(current()//count/@pass)" />
		</xsl:variable>

		<xsl:variable name="skipTCcount">
			<xsl:value-of select="sum(current()//count/@skipped)" />
		</xsl:variable>

		<xsl:variable name="failTCcount">
			<xsl:value-of
					select="$totalTCcount - $passTCcount - $skipTCcount " />
		</xsl:variable>
		<xsl:variable name="status">
			<xsl:value-of select="@status" />
		</xsl:variable>
		<xsl:variable name="remarks">
			<xsl:value-of select="@remarks" />
		</xsl:variable>
		<xsl:variable name="timeCount">
			<xsl:value-of select="@timeCount" />
		</xsl:variable>
		<xsl:variable name="timeStatus">
			<xsl:value-of select="@timeStatus" />
		</xsl:variable>

		<tr>
			<xsl:attribute name="class">
				<xsl:value-of select="''" />
			</xsl:attribute>
			<td>
				<xsl:call-template name="generate-testcase-report.html">
					<xsl:with-param name="parentFolderPath" select="concat('../',../../@id)" />
					<xsl:with-param name="resourcesFolderPath"
									select="concat('../',$resourcesFolderPath)" />
					<xsl:with-param name="Level">
						<xsl:value-of select="1" />
					</xsl:with-param>
				</xsl:call-template>
				<a>
					<xsl:attribute name="href">../<xsl:value-of select="../../@id" />/<xsl:value-of select="@id" />/testcase-report.html</xsl:attribute>
					<xsl:value-of select="@name" />
				</a>
			</td>
			<td>
				<xsl:value-of select="$totalTCcount" />
			</td>
			<td>
				<xsl:value-of select="$passTCcount" />
			</td>
			<td>
				<xsl:value-of select="$skipTCcount" />
			</td>
			<td>
				<xsl:value-of select="$failTCcount" />
			</td>
			<td>
				<xsl:call-template name="displayprogressbar">
					<xsl:with-param name="totalCount" select="$totalTCcount"/>
					<xsl:with-param name="passedCount" select="$passTCcount"/>
					<xsl:with-param name="failedCount" select="$failTCcount"/>
					<xsl:with-param name="skippedCount" select="$skipTCcount"/>

				</xsl:call-template>
			</td>

			<td>
				<xsl:call-template name="SetTime">
					<xsl:with-param name="time" select="$timeCount" />
				</xsl:call-template>
			</td>
			<!-- 			<td> -->
			<!-- 				<xsl:call-template name="setTimeStatus"> -->
			<!-- 					<xsl:with-param name="timeStatus" select="$timeStatus" /> -->
			<!-- 				</xsl:call-template> -->
			<!-- 			</td> -->
			<td class="wordBreak">
				<xsl:value-of select="$remarks" />
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="testcase" mode="childTestCaseListing">
		<xsl:param name="parentFolderPath" />
		<xsl:param name="resourcesFolderPath" />
		<xsl:param name="Level" />

		<xsl:variable name="totalTCcount">
			<xsl:value-of select="sum(current()//count/@total)" />
		</xsl:variable>

		<xsl:variable name="passTCcount">
			<xsl:value-of select="sum(current()//count/@pass)" />
		</xsl:variable>

		<xsl:variable name="skipTCcount">
			<xsl:value-of select="sum(current()//count/@skipped)" />
		</xsl:variable>

		<xsl:variable name="failTCcount">
			<xsl:value-of
					select="$totalTCcount - $passTCcount - $skipTCcount " />
		</xsl:variable>

		<xsl:variable name="status">
			<xsl:value-of select="current()//@status" />
		</xsl:variable>

		<xsl:variable name="remarks">
			<xsl:value-of select="current()//@remarks" />
		</xsl:variable>

		<xsl:variable name="timeStatus">
			<xsl:value-of select="current()//@timeStatus" />
		</xsl:variable>

		<tr>
			<xsl:attribute name="class">
				<xsl:value-of select="''" />
			</xsl:attribute>
			<td>
				<xsl:call-template name="generate-testcase-report.html">
					<xsl:with-param name="parentFolderPath" select="$parentFolderPath" />
					<xsl:with-param name="resourcesFolderPath"
									select="concat('../', $resourcesFolderPath)" />
					<xsl:with-param name="Level">
						<xsl:value-of select="$Level+1" />
					</xsl:with-param>
				</xsl:call-template>
				<a>
					<xsl:attribute name="href">./<xsl:value-of select="@id" />/testcase-report.html</xsl:attribute>
					<xsl:value-of select="@name" />
				</a>
			</td>
			<td class="wordBreak">
				<xsl:value-of select="@description" />
			</td>
			<td>
				<xsl:value-of select="$totalTCcount" />
			</td>
			<td>
				<xsl:value-of select="$passTCcount" />
			</td>
			<td>
				<xsl:value-of select="$skipTCcount" />
			</td>
			<td>
				<xsl:value-of select="$failTCcount" />
			</td>
			<td>
				<xsl:call-template name="displayprogressbar">
					<xsl:with-param name="totalCount" select="$totalTCcount"/>
					<xsl:with-param name="passedCount" select="$passTCcount"/>
					<xsl:with-param name="failedCount" select="$failTCcount"/>
					<xsl:with-param name="skippedCount" select="$skipTCcount"/>

				</xsl:call-template>
			</td>
			<xsl:variable name="timeCount" select="sum(@timeCount)" />
			<td>
				<xsl:call-template name="SetTime">
					<xsl:with-param name="time" select="$timeCount" />
				</xsl:call-template>
			</td>
			<!-- 			<td> -->
			<!-- 				<xsl:call-template name="setTimeStatus"> -->
			<!-- 					<xsl:with-param name="timeStatus" select="$timeStatus"></xsl:with-param> -->
			<!-- 				</xsl:call-template> -->
			<!-- 			</td> -->
			<td class="wordBreak">
				<xsl:value-of select="$remarks" />
			</td>
		</tr>
	</xsl:template>
	<!-- Create Testsuite wise report -->
	<xsl:template name="generate-testcase-report.html">
		<xsl:param name="parentFolderPath" />
		<xsl:param name="resourcesFolderPath" />
		<xsl:param name="Level" />

		<redirect:write file="{$parentFolderPath}/{@id}/testcase-report.html">
			<html>
				<head>
					<title>TestCase Report:</title>
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
							<xsl:value-of select="$resourcesFolderPath"/>/lib/bootstrap.min.css</xsl:attribute>
					</link>
					<link>
						<xsl:attribute name="rel">stylesheet</xsl:attribute>
						<xsl:attribute name="type">text/css</xsl:attribute>
						<xsl:attribute name="href">
							<xsl:value-of select="$resourcesFolderPath"/>/lib/alfReport.css</xsl:attribute>
					</link>
				</head>
				<body>
					<xsl:call-template name="logo">
						<xsl:with-param name="backdir" select="'../../resources/'" />
					</xsl:call-template>
					<ol class="breadcrumb">
						<xsl:call-template name="generateLink">
							<xsl:with-param name="totalCount" select="$Level" />
							<xsl:with-param name="LevelCounter" select="$Level" />
						</xsl:call-template>
						<li class="breadcrump active" font-color="black">
							<xsl:value-of select="@name" />
						</li>
					</ol>
					<xsl:if
							test="beforeeverycase/teststep[not(@status='disabled' or @status='excluded')]">
						<xsl:call-template name="beforeAndAftercaseListing">
							<xsl:with-param name="parentFolderPath" select="$parentFolderPath" />
							<xsl:with-param name="resourcesFolderPath" select="$resourcesFolderPath" />
							<xsl:with-param name="beforeOrAfterStatus" select="'beforeeverycase'" />
							<xsl:with-param name="level" select="$Level+1"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="set.heading">
						<xsl:with-param name="heading" select="'Test Steps'" />
					</xsl:call-template>
					<table width="100%" class="alfTable table table-hover">
						<thead class="trhead">
							<th align="left"> Name   </th>
							<th align="left"> Description   </th>
							<th align="center"> Tool Report   </th>
							<th align="center"> DataRow   </th>
							<th align="center"> Analytics   </th>
							<th align="left"> Status   </th>
							<th align="left"> Time  </th>
							<!-- 							<th align="left" width="10%" title="Difference in execution time from the average execution time of this asset on the same machine">Mean Time Difference</th> -->
							<th align="left"> SAT path</th>
							<th align="left"> Remarks </th>
						</thead>
						<xsl:apply-templates
								select="teststep[not(@status='disabled' or @status='excluded')]"
								mode="childTestStepListing">
							<xsl:with-param name="parentFolderPath"
											select="concat($parentFolderPath, '/', @id)" />
							<xsl:with-param name="resourcesFolderPath" select="$resourcesFolderPath" />
							<xsl:with-param name="level" select="$Level + 1"></xsl:with-param>
						</xsl:apply-templates>
					</table>
					<xsl:if
							test="aftereverycase/teststep[not(@status='disabled' or @status='excluded')]">
						<xsl:call-template name="beforeAndAftercaseListing">
							<xsl:with-param name="parentFolderPath" select="$parentFolderPath" />
							<xsl:with-param name="resourcesFolderPath" select="$resourcesFolderPath" />
							<xsl:with-param name="beforeOrAfterStatus" select="'aftereverycase'" />
							<xsl:with-param name="level" select="$Level+1"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:copy-of select="$copyright" />
				</body>
			</html>
		</redirect:write>
	</xsl:template>

	<xsl:template match="teststep" mode="childTestStepListing">
		<xsl:param name="parentFolderPath" />
		<xsl:param name="resourcesFolderPath" />
		<xsl:param name="level"/>

		<xsl:variable name="actionLanguage"
					  select="translate(@actionLanguage, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" />

		<xsl:variable name="toolSpecificReport">
			<xsl:value-of select="@toolSpecificReport" />
		</xsl:variable>

		<xsl:variable name="status" select="@status" />

		<xsl:variable name="timeCount" select="@timeCount" />

		<xsl:variable name="timeStatus" select="@timeStatus" />

		<xsl:variable name="remarks" select="@remarks" />
		
		<xsl:variable name="satpath" select="@satpath" />

		<tr>
			<xsl:attribute name="class">
				<xsl:value-of select="''" />
			</xsl:attribute>
			<td>
				<xsl:choose>
					<xsl:when test="$actionLanguage = 'QTP'">
						<a>
							<xsl:attribute name="href">./<xsl:value-of
									select="@id" />/screen-report.html</xsl:attribute>
							<xsl:attribute name="target">_blank</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="@description" />
							</xsl:attribute>
							<xsl:value-of select="@name" />
						</a>
						<xsl:call-template name="GenerateScreenReport">
							<xsl:with-param name="parentFolderPath" select="$parentFolderPath" />
							<xsl:with-param name="resourcesFolderPath"
											select="concat('../', $resourcesFolderPath)" />
							<xsl:with-param name="level" select="$level"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$actionLanguage = 'SELENIUM'">
						<a>
							<xsl:attribute name="href">./<xsl:value-of
									select="@id" />/screen-report.html</xsl:attribute>
							<xsl:attribute name="target">_blank</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="@description" />
							</xsl:attribute>
							<xsl:value-of select="@name" />
						</a>
						<xsl:call-template name="GenerateScreenReport">
							<xsl:with-param name="parentFolderPath" select="$parentFolderPath" />
							<xsl:with-param name="resourcesFolderPath"
											select="concat('../', $resourcesFolderPath)" />
							<xsl:with-param name="level" select="$level"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$actionLanguage = 'WEBDRIVER'">
						<a>
							<xsl:attribute name="href">./<xsl:value-of
									select="@id" />/screen-report.html</xsl:attribute>
							<xsl:attribute name="target">_blank</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="@description" />
							</xsl:attribute>
							<xsl:value-of select="@name" />
						</a>
						<xsl:call-template name="GenerateScreenReport">
							<xsl:with-param name="parentFolderPath" select="$parentFolderPath" />
							<xsl:with-param name="resourcesFolderPath"
											select="concat('../', $resourcesFolderPath)" />
							<xsl:with-param name="level" select="$level"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$actionLanguage = 'CNL'">
						<a>
							<xsl:attribute name="href">./<xsl:value-of
									select="@id" />/screen-report.html</xsl:attribute>
							<xsl:attribute name="target">_blank</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="@description" />
							</xsl:attribute>
							<xsl:value-of select="@name" />
						</a>
						<xsl:call-template name="GenerateScreenReport">
							<xsl:with-param name="parentFolderPath" select="$parentFolderPath" />
							<xsl:with-param name="resourcesFolderPath"
											select="concat('../', $resourcesFolderPath)" />
							<xsl:with-param name="level" select="$level"/>
						</xsl:call-template>
					</xsl:when>

					<xsl:when test="$actionLanguage = 'FEST'">
						<a>
							<xsl:attribute name="href">./<xsl:value-of
									select="@id" />/screen-report.html</xsl:attribute>
							<xsl:attribute name="target">_blank</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="@description" />
							</xsl:attribute>
							<xsl:value-of select="@name" />
						</a>
						<xsl:call-template name="GenerateScreenReport">
							<xsl:with-param name="parentFolderPath" select="$parentFolderPath" />
							<xsl:with-param name="resourcesFolderPath"
											select="concat('../', $resourcesFolderPath)" />
							<xsl:with-param name="level" select="$level"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$actionLanguage = 'IS_SERVICE'">
						<xsl:value-of select="@name" />
					</xsl:when>
					<xsl:when test="$actionLanguage = 'VENUS'">
						<xsl:value-of select="@name" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@name" />
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td class="wordBreak">
				<xsl:value-of select="@description" />
			</td>
			<td align="center">
				<xsl:if test="$toolSpecificReport != 'null'">
					<a>
						<xsl:attribute name="href">./<xsl:value-of
								select="@id" />/<xsl:value-of select="$toolSpecificReport" />
						</xsl:attribute>
						<xsl:attribute name="target">_blank</xsl:attribute>
						<xsl:value-of select="$actionLanguage" />
					</a>
				</xsl:if>

				<xsl:if test="$toolSpecificReport = 'null'">
					<xsl:value-of select="$actionLanguage" />
				</xsl:if>
			</td>
			<td align="center">
				<xsl:variable name="datareport">
					<xsl:value-of select="datarow/@file" />
				</xsl:variable>
				<a>
					<xsl:attribute name="href">./<xsl:value-of
							select="@id" />/datarow.html</xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>
					data
				</a>
			</td>
			<td align="center">
				<a>
					<xsl:attribute name="href">./<xsl:value-of
							select="@id" />/StepReportAnalysis.html</xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>
					Analytics
				</a>
				<xsl:call-template name="GenerateServerLogsReport">
					<xsl:with-param name="parentFolderPath" select="$parentFolderPath" />
					<xsl:with-param name="resourcesFolderPath"
									select="concat('../', $resourcesFolderPath)" />
				</xsl:call-template>
			</td>
			<td>
				<xsl:call-template name="SetImage">
					<xsl:with-param name="status" select="$status" />
				</xsl:call-template>
			</td>
			<td>
				<xsl:call-template name="SetTime">
					<xsl:with-param name="time" select="$timeCount" />
				</xsl:call-template>
			</td>
			<td class="wordBreak">
				<a>
					<xsl:attribute name="href"><xsl:value-of select="@satpath" /></xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>
					SAT link
				</a>
				
			</td>
			<!-- 			<td> -->
			<!-- 				<xsl:call-template name="setTimeStatus"> -->
			<!-- 					<xsl:with-param name="timeStatus" select="$timeStatus" /> -->
			<!-- 				</xsl:call-template> -->
			<!-- 			</td> -->
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
		<xsl:param name="level"/>

		<redirect:write file="{$parentFolderPath}/{@id}/screen-report.html">
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
						<xsl:value-of select="$resourcesFolderPath"/>/lib/bootstrap.min.css</xsl:attribute>
				</link>
				<link>
					<xsl:attribute name="rel">stylesheet</xsl:attribute>
					<xsl:attribute name="type">text/css</xsl:attribute>
					<xsl:attribute name="href">
						<xsl:value-of select="$resourcesFolderPath"/>/lib/alfReport.css</xsl:attribute>
				</link>
				<body>
					<xsl:call-template name="logo">
						<xsl:with-param name="backdir" select="$resourcesFolderPath"/>
					</xsl:call-template>
					<table width="100%">
						<tr>
							<td>
								<b>
									<font size="2">
										ALF ScreenShot Report <span class="glyphicon glyphicon-chevron-right"></span>
										<xsl:value-of select="../@id" />
									</font>
								</b>
							</td>
						</tr>
					</table>
					<!--for now we are adding a back button in beforeeverycase and aftereverycase, once we get a solution to fix the breadcrumb for these two, remove these condition-->
					<xsl:if test="$level > 0">
						<ol class="breadcrumb">
							<!-- Generate bredcrump on top of the page -->
							<xsl:call-template name="generateLink">
                                <xsl:with-param name="totalCount" select="$level" />
                                <xsl:with-param name="LevelCounter" select="$level" />
                            </xsl:call-template>

							<li class="breadcrump active" font-color="black">
								<xsl:value-of select="@name" />
							</li>
						</ol>
					</xsl:if>
					<xsl:if test="$level = -1">
						<ol class="breadcrumb">
						<li><a href="../testcase-report.html">Back</a></li>
						</ol>
					</xsl:if>
					<br/>
					<div>No of steps avilable are :
						<xsl:value-of select="count(current()/step)" /></div>
					<table width="100%" class="alfTable table">
						<thead class="trhead" align="left">
							<th>Timestamp</th>
							<th>Description</th>
							<th>Status</th>
							<th>Image</th>
						</thead>
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
			<td align="left">
				<xsl:choose>
					<xsl:when test="@result = 'PASS'">
						<span class="glyphicon glyphicon-arrow-right pass-icon screen-report-icon"></span>
					</xsl:when>
					<xsl:when test="@result = 'FAIL'">
						<span class="glyphicon glyphicon-arrow-right fail-icon screen-report-icon"></span>
					</xsl:when>
					<xsl:when test="@result = 'WARNING'">
						<span class="glyphicon glyphicon-arrow-right warn-icon screen-report-icon"></span>
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

	<!-- Create Server Logs Report -->
	<xsl:template name="GenerateServerLogsReport">
		<xsl:param name="parentFolderPath" />
		<xsl:param name="resourcesFolderPath" />
		<redirect:write file="{$parentFolderPath}/{@id}/serverLogs.html">
			<html>
				<head>
					<title>Server Logs</title>
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
							<xsl:value-of select="$resourcesFolderPath"/>/lib/bootstrap.min.css</xsl:attribute>
					</link>
					<link>
						<xsl:attribute name="rel">stylesheet</xsl:attribute>
						<xsl:attribute name="type">text/css</xsl:attribute>
						<xsl:attribute name="href">
							<xsl:value-of select="$resourcesFolderPath"/>/lib/alfReport.css</xsl:attribute>
					</link>
				</head>
				<body>
					<xsl:call-template name="logo">
						<xsl:with-param name="backdir" select="'../../../../../resources/'" />
					</xsl:call-template>

					<xsl:call-template name="set.heading">
						<xsl:with-param name="heading" select="'Server Logs'" />
					</xsl:call-template>
					<table width="100%" class="alfTable table table-hover">
						<thead class="trhead">
							<th align="left"> Host   </th>
							<th align="left"> Component   </th>
							<th align="center"> Log File   </th>
							<th align="center"> Status  </th>
						</thead>
						<xsl:apply-templates select="*" mode="serverlogs">
							<xsl:with-param name="resourcesFolderPath" select="$resourcesFolderPath" />
						</xsl:apply-templates>
					</table>
					<xsl:copy-of select="$copyright" />
				</body>
			</html>
		</redirect:write>
	</xsl:template>


	<xsl:template match="serverlog" mode="serverlogs">
		<xsl:param name="resourcesFolderPath" />
		<tr>
			<td align="left">
				<xsl:value-of select="@host" />
			</td>
			<td align="left">
				<xsl:value-of select="@component" />
			</td>
			<td align="left">
				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="@logFilePath" />
					</xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>
					<xsl:value-of select="@displayName" />
				</a>
			</td>
			<td align="middle">
				<xsl:call-template name="SetImage">
					<xsl:with-param name="status" select="@status"/>
				</xsl:call-template>
			</td>
		</tr>
	</xsl:template>

	<xsl:template name="set.heading">
		<xsl:param name="heading" />
		<h4><xsl:value-of select="$heading"></xsl:value-of></h4>
	</xsl:template>

	<xsl:template name="SetImage">
		<xsl:param name="status" />
		<xsl:choose>
			<xsl:when test="$status = 'pass'">
				<span title="Passed" style="color:green" class="glyphicon glyphicon-ok"></span>
			</xsl:when>
			<xsl:when test="$status = 'fail'">
				<span ttile="Failed" style="color:red" class="glyphicon glyphicon-remove"></span>
			</xsl:when>
			<xsl:when test="$status = 'skipped'">
				<span title="Skipped" style="color:rgb(239, 202, 12)" class="glyphicon glyphicon-warning-sign"></span>
			</xsl:when>
			<xsl:when test="$status = 'disabled'">
				<span title="Disabled" style="color:coral" class="glyphicon glyphicon-ban-circle"></span>
			</xsl:when>
			<xsl:when test="$status = 'excluded'">
				<span title="Excluded" style="color:dimgrey" class="glyphicon glyphicon-exclamation-sign"></span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$status" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="AddHeadColumns">
		<xsl:param name="type" />
		<thead class="trhead">
			<th align="left"> Name  </th>
			<th align="left"> Description  </th>
			<xsl:choose>
				<xsl:when test="$type='Test Steps'">
					<th align="left" title="Total number of test steps"> Test Steps  </th>
				</xsl:when>
				<xsl:otherwise>
					<th align="left" title="total number of test cases"> Tests  </th>
				</xsl:otherwise>
			</xsl:choose>

			<th align="left" title="Number of cases with Suceess status"> Success  </th>
			<th align="left" title="Number of cases with Skipped status"> Skipped  </th>
			<th align="left" title="Number of cases with Failed status"> Failures </th>
			<th align="left" title="Status of the asset"> Status </th>
			<th align="left" title="Total time taken for execution"> Time </th>
			<!-- 		<th align="left" width="10%" title="Difference in execution time from the average execution time of this asset on the same machine">Mean Time Difference</th> -->
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
		<xsl:variable name="NodeId" select="dyn:evaluate(concat($link,'@id'))"/>
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

				<xsl:if test="$LevelCounter != $totalCount ">
					<xsl:choose>
						<xsl:when test="starts-with($NodeId,'TC') or starts-with($NodeId,'STC')">
							<xsl:call-template name="getNodeName">
								<xsl:with-param name="linkTo"
												select="concat($link,'testcase-report.html')" />
								<xsl:with-param name="path" select="$link" />
							</xsl:call-template>
						</xsl:when>
					<xsl:otherwise>
					<xsl:call-template name="getNodeName">
						<xsl:with-param name="linkTo"
										select="concat($link,'testsuite-report.html')" />
						<xsl:with-param name="path" select="$link" />
					</xsl:call-template>
					</xsl:otherwise>
					</xsl:choose>
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
		<li>
			<a>
				<xsl:attribute name="class">
					<xsl:value-of select="'breadcrump'" />
				</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:value-of select="$link" />
				</xsl:attribute>
				<xsl:value-of select="$nodePath" />
			</a>
		</li>
	</xsl:template>

	<xsl:template name="alfproperties-frame.html">
		<html>
			<head>
				<title>SAT Report</title>
				<link rel="stylesheet" type="text/css" href="reportStyle.css" />
				<link rel="stylesheet" type="text/css" href="./lib/bootstrap.min.css"/>
				<link rel="stylesheet" type="text/css" href="./lib/alfReport.css"/>
			</head>
			<body>
				<xsl:call-template name="logo">
					<xsl:with-param name="backdir" select="'./'" />
				</xsl:call-template>
				<xsl:call-template name="set.heading">
					<xsl:with-param name="heading" select="'Environmental Properties'" />
				</xsl:call-template>
				<div class="container-fluid">
					<table width="100%" class="alfTable table table-hover" align="center" nowrap="nowrap"
						   name="mainCall">
						<xsl:apply-templates select="*" mode="allalfproperties" />
					</table>
				</div>
			</body>
		</html>
	</xsl:template>


	<xsl:template match="project" mode="allalfproperties">
		<thead class="trhead">
			<tr>
				<th align="left" width="10%">Property Name </th>
				<th align="left" width="10%">Value </th>
			</tr>
		</thead>
		<xsl:apply-templates select="alfproperties/alfproperty"
							 mode="listAlfProperties" />
	</xsl:template>
	<xsl:template match="alfproperty" mode="listAlfProperties">
		<tr>
			<td>
				<xsl:value-of select="@key" />
			</td>
			<td>
				<xsl:value-of select="@propertyvalue" />
			</td>
		</tr>
	</xsl:template>


	<xsl:template name="allSummary-frame.html">


		<xsl:variable name="total.suites">
			<xsl:value-of select="count(current()//testsuite)" />
		</xsl:variable>

		<xsl:variable name="total.passed.suites">
			<xsl:value-of select="count(current()//testsuite[@status='pass'])" />
		</xsl:variable>

		<xsl:variable name="total.failed.suites">
			<xsl:value-of select="count(current()//testsuite[@status='fail'])" />
		</xsl:variable>

		<xsl:variable name="total.skipped.suites">
			<xsl:value-of select="count(current()//testsuite[@status='skipped'])" />
		</xsl:variable>

		<xsl:variable name="total.warned.suites">
			<xsl:value-of select="dyn:evaluate($countOfWarningTestSuites)" />
		</xsl:variable>

		<xsl:variable name="total.disabled.suites">
			<xsl:value-of select="count(current()//testsuite[@status='disabled'])" />
		</xsl:variable>

		<xsl:variable name="total.excluded.suites">
			<xsl:value-of select="count(current()//testsuite[@status='excluded'])" />
		</xsl:variable>


		<!-- get testcases counts -->
		<xsl:variable name="test.cases">
			<xsl:value-of
					select="sum(current()//testcase/count/@total[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)])" />
		</xsl:variable>

		<xsl:variable name="total.passed.cases">
			<xsl:value-of
					select="sum(current()//testcase/count/@pass[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)])" />
		</xsl:variable>

		<xsl:variable name="total.skipped.cases">
			<xsl:value-of
					select="sum(current()//testcase/count/@skipped[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)])" />
		</xsl:variable>

		<xsl:variable name="total.failed.cases">
			<xsl:value-of
					select="$test.cases - $total.passed.cases - $total.skipped.cases" />
		</xsl:variable>

		<!-- 		<xsl:variable name="total.warned.cases"> -->
		<!-- 			<xsl:value-of select="count(current()//testcase[((descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@result='WARNING') or @timeStatus > 0) and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)])" /> -->
		<!-- 		</xsl:variable> -->

		<xsl:variable name="total.warned.cases">
			<xsl:value-of select="count(current()//testcase[((descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@result='WARNING') ) and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)])" />
		</xsl:variable>

		<xsl:variable name="total.disabled.cases">
			<xsl:value-of
					select="count(current()//testcase[@status='disabled' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)])" />
		</xsl:variable>

		<xsl:variable name="total.excluded.cases">
			<xsl:value-of
					select="count(current()//testcase[@status='excluded' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)])" />
		</xsl:variable>
		<xsl:variable name="total.cases">
			<xsl:value-of select="$test.cases + $total.disabled.cases + $total.excluded.cases"></xsl:value-of>
		</xsl:variable>


		<!-- get teststeps counts -->
		<xsl:variable name="total.steps">
			<xsl:value-of
					select="count(current()//teststep[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])" />
		</xsl:variable>

		<xsl:variable name="total.passed.steps">
			<xsl:value-of
					select="count(current()//teststep[@status='pass' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])" />
		</xsl:variable>
		<xsl:variable name="total.failed.steps">
			<xsl:value-of
					select="count(current()//teststep[@status='fail' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])" />
		</xsl:variable>

		<xsl:variable name="total.skipped.steps">
			<xsl:value-of
					select="count(current()//teststep[@status='skipped' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])" />
		</xsl:variable>

		<!-- 		<xsl:variable name="total.warned.steps"> -->
		<!-- 			<xsl:value-of select="count(current()//teststep[((descendant-or-self::node()/step/@result='WARNING') or @timeStatus > 0) and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])" /> -->
		<!-- 		</xsl:variable> -->

		<xsl:variable name="total.warned.steps">
			<xsl:value-of select="count(current()//teststep[((descendant-or-self::node()/step/@result='WARNING') ) and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])" />
		</xsl:variable>



		<xsl:variable name="total.disabled.steps">
			<xsl:value-of
					select="count(current()//teststep[@status='disabled' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])" />
		</xsl:variable>

		<xsl:variable name="total.excluded.steps">
			<xsl:value-of
					select="count(current()//teststep[@status='excluded' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])" />
		</xsl:variable>


		<html>
			<head>
				<title>All Features</title>
				<link rel="stylesheet" type="text/css" href="reportStyle.css" />
				<link rel="stylesheet" type="text/css" href="./lib/bootstrap.min.css" />
				<link rel="stylesheet" type="text/css" href="./lib/alfReport.css"/>
				<script src="./lib/jquery.min.js"></script>
				<script src="./lib/bootstrap.min.js"></script>

			</head>
			<body>
				<div style="font-size: 22px;
    text-align: center;">Execution Summary</div>


				<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
					<div class="panel panel-default">
						<div class="panel-heading none-padding" role="tab" id="headingOne">
							<h4 class="panel-title">
								<button role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne" class="summary-button  list-group-item">
									TestSteps<span class="badge alert-info header-badge">
									<xsl:value-of select="$total.steps" />
								</span>
								</button>
							</h4>
						</div>
						<div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
							<div class="panel-body none-padding">
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'teststep'" />
									<xsl:with-param name="status" select="'all'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">all-teststep.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All TestSteps
									<span class="badge alert-info">
										<xsl:value-of select="$total.steps" />
									</span>
								</a>
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'teststep'" />
									<xsl:with-param name="status" select="'pass'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">pass-teststep.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All Passed TestSteps
									<span class="badge alert-success">
										<xsl:value-of select="$total.passed.steps" />
									</span>
								</a>
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'teststep'" />
									<xsl:with-param name="status" select="'fail'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">fail-teststep.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All Failed TestSteps
									<span class="badge alert-danger">
										<xsl:value-of select="$total.failed.steps" />
									</span>
								</a>
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'teststep'" />
									<xsl:with-param name="status" select="'skipped'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">skipped-teststep.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All Skipped TestSteps
									<span class="badge alert-warning">
										<xsl:value-of select="$total.skipped.steps" />
									</span>
								</a>
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'teststep'" />
									<xsl:with-param name="status" select="'disabled'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">disabled-teststep.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All Disabled TestSteps
									<span class="excludedCount badge">
										<xsl:value-of select="$total.disabled.steps" />
									</span>
								</a>
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'teststep'" />
									<xsl:with-param name="status" select="'excluded'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">excluded-teststep.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All Excluded TestsSteps
									<span class="excludedCount badge">
										<xsl:value-of select="$total.excluded.steps" />
									</span>
								</a>
								<xsl:call-template name="generate-misc-teststeps.html"></xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">misc-teststeps.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestSteps With Warnings
									<span class="badge warningcount">
										<xsl:value-of select="$total.warned.steps" />
									</span>
								</a>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading none-padding" role="tab" id="headingTwo">
							<h4 class="panel-title">
								<button class="collapsed summary-button  list-group-item" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
									TestCases<span class="badge alert-info header-badge">
									<xsl:value-of select="$total.cases" />
								</span>
								</button>
							</h4>
						</div>
						<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
							<div class="panel-body none-padding">
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'testcase'" />
									<xsl:with-param name="status" select="'all'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">./all-testcase.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All TestsCases
									<span class="badge alert-info">
										<xsl:value-of select="$total.cases" />
									</span>
								</a>
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'testcase'" />
									<xsl:with-param name="status" select="'pass'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">./pass-testcase.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All Passed TestsCases
									<span class="badge alert-success">
										<xsl:value-of select="$total.passed.cases" />
									</span>
								</a>
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'testcase'" />
									<xsl:with-param name="status" select="'fail'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">./fail-testcase.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All Failed TestsCases
									<span class="badge alert-danger">
										<xsl:value-of select="$total.failed.cases" />
									</span>
								</a>
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'testcase'" />
									<xsl:with-param name="status" select="'skipped'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">./skipped-testcase.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All Skipped TestsCases
									<span class="badge alert-warning">
										<xsl:value-of select="$total.skipped.cases" />
									</span>
								</a>
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'testcase'" />
									<xsl:with-param name="status" select="'disabled'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">./disabled-testcase.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All Disabled TestCases
									<span class="excludedCount badge">
										<xsl:value-of select="$total.disabled.cases" />
									</span>
								</a>
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'testcase'" />
									<xsl:with-param name="status" select="'excluded'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">./excluded-testcase.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All Excluded TestCases
									<span class="excludedCount badge">
										<xsl:value-of select="$total.excluded.cases" />
									</span>
								</a>
								<xsl:call-template name="generate-misc-testcases.html"></xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">./misc-testcases.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestCases With Warnings
									<span class="badge warningcount">
										<xsl:value-of select="$total.warned.cases" />
									</span>
								</a>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading none-padding" role="tab" id="headingThree">
							<h4 class="panel-title">
								<button class="collapsed summary-button  list-group-item" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
									TestSuites<span class="badge alert-info header-badge">
									<xsl:value-of select="$total.suites" />
								</span>
								</button>
							</h4>
						</div>
						<div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
							<div class="panel-body  none-padding">
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'testsuite'" />
									<xsl:with-param name="status" select="'all'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">./all-testsuite.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All TestSuites
									<span class="badge alert-info">
										<xsl:value-of select="$total.suites" />
									</span>
								</a>
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'testsuite'" />
									<xsl:with-param name="status" select="'pass'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">./pass-testsuite.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All Passed TestsSuites
									<span class="badge alert-success">
										<xsl:value-of select="$total.passed.suites" />
									</span>
								</a>
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'testsuite'" />
									<xsl:with-param name="status" select="'fail'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">./fail-testsuite.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All Failed TestSuites
									<span class="badge alert-danger">
										<xsl:value-of select="$total.failed.suites" />
									</span>
								</a>
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'testsuite'" />
									<xsl:with-param name="status" select="'skipped'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">./skipped-testsuite.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All Skipped TestSuites
									<span class="badge alert-warning">
										<xsl:value-of select="$total.skipped.suites" />
									</span>
								</a>
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'testsuite'" />
									<xsl:with-param name="status" select="'disabled'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">./disabled-testsuite.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All Disabled TestSuites
									<span class="excludedCount badge">
										<xsl:value-of select="$total.disabled.suites" />
									</span>
								</a>
								<xsl:call-template name="createAll">
									<xsl:with-param name="type" select="'testsuite'" />
									<xsl:with-param name="status" select="'excluded'" />
								</xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">./excluded-testsuite.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									All Excluded TestSuites
									<span class="excludedCount badge">
										<xsl:value-of select="$total.excluded.suites" />
									</span>
								</a>
								<xsl:call-template name="generate-misc-testsuites.html"></xsl:call-template>
								<a class="small-padd list-group-item">
									<xsl:attribute name="href">./misc-testsuites.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestSuites With Warnings
									<span class="badge warningcount">
										<xsl:value-of select="$total.warned.suites" />
									</span>
								</a>
							</div>
						</div>
					</div>
				</div>

			</body>
		</html>
	</xsl:template>

	<xsl:template name="set.heading.summary.page">
		<xsl:param name="type"></xsl:param>
		<xsl:if test="$type = 'all testsuite'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'All TestSuites'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'pass testsuite'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'Passed TestSuites'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'fail testsuite'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'Failed TestSuites'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'skipped testsuite'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'Skipped TestSuites'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'disabled testsuite'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'Disabled TestSuites'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'excluded testsuite'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'Excluded TestSuites'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'all testcase'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'All TestCases'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'pass testcase'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'Passed TestCases'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'fail testcase'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'Failed TestCases'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'skipped testcase'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'Skipped TestCases'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'disabled testcase'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'Disabled TestCases'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'excluded testcase'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'Excluded TestCases'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'all teststep'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'All TestSteps'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'pass teststep'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'Passed TestSteps'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'fail teststep'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'Failed TestSteps'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'skipped teststep'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'Skipped TestSteps'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'disabled teststep'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'Disabled TestSteps'" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$type = 'excluded teststep'">
			<xsl:call-template name="set.heading">
				<xsl:with-param name="heading"
								select="'Excluded TestSteps'" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>


	<xsl:template name="createAll">
		<xsl:param name="type" />
		<xsl:param name="status" />
		<xsl:variable name="filename">./<xsl:value-of select="$status" />-<xsl:value-of select="$type" />.html</xsl:variable>

		<redirect:write file="{$filename}">
			<html>
				<head>
					<title>Full SAT Report</title>
					<link rel="stylesheet" type="text/css" href="reportStyle.css" />
					<link rel="stylesheet" type="text/css" href="./lib/bootstrap.min.css" />
					<link rel="stylesheet" type="text/css" href="./lib/alfReport.css" />

				</head>
				<body>
					<xsl:call-template name="logo">
						<xsl:with-param name="backdir" select="'./'" />
					</xsl:call-template>
					<xsl:call-template name="set.heading.summary.page">
						<xsl:with-param name="type"
										select="concat($status,' ',$type)" />
					</xsl:call-template>
					<table width="100%" class="alfTable table table-hover">
						<xsl:choose>
							<xsl:when test="$type = 'teststep'">
								<thead class="trhead">
									<th align="left"> Name   </th>
									<th align="left"> Description   </th>
									<th align="left"> Parent   </th>
									<th align="center"> Tool Report   </th>
									<th align="center"> Analytics   </th>
									<th align="center"> Data row   </th>
									<th align="left"> Status   </th>
									<th align="left"> Time  </th>
									<!-- 									<th align="left" width="10%" title="Difference in execution time from the average execution time of this asset on the same machine">Mean Time Difference</th> -->
									<th align="left" > SAT Link</th>
									<th align="left" width="30%"> Remarks</th>
								</thead>
								<xsl:if test="$status='all'">
									<xsl:apply-templates select="*" mode="allSteps">
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$status='pass'">
									<xsl:apply-templates select="*" mode="passedSteps">
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$status='fail'">
									<xsl:apply-templates select="*" mode="failedSteps">
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$status='warning'">
									<xsl:apply-templates select="*" mode="warningSteps">
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$status='skipped'">
									<xsl:apply-templates select="*" mode="skippedSteps">
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$status='disabled'">
									<xsl:apply-templates select="*" mode="disabledSteps">
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$status='excluded'">
									<xsl:apply-templates select="*" mode="excludedSteps">
									</xsl:apply-templates>
								</xsl:if>

							</xsl:when>
							<xsl:when test="$type ='testsuite'">
								<thead class="trhead">
									<th align="left"> Name  </th>
									<th align="left"> Description  </th>
									<!-- If there are more than one levels then add conditions to differentiate -->
									<th align="left"> Parent Name  </th>
									<th align="left"> Total TestSteps  </th>
									<th align="left"> Success  </th>
									<th align="left"> Failures </th>
									<th align="left"> Skipped </th>
									<th align="left"> Status </th>
									<th align="left"> Time </th>
									<!-- 									<th align="left" width="10%" title="Difference in execution time from the average execution time of this asset on the same machine">Mean Time Difference</th> -->
									<th align="left"> Remarks </th>
								</thead>
								<xsl:if test="$status='all'">
									<xsl:apply-templates select="*" mode="allSuites">
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$status = 'pass'">
									<xsl:apply-templates select="*" mode="passedSuites">
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$status='fail'">
									<xsl:apply-templates select="*" mode="failedSuites">
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$status='skipped'">
									<xsl:apply-templates select="*" mode="skippedSuites">
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$status='disabled'">
									<xsl:apply-templates select="*"
														 mode="disabledSuites">
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$status='excluded'">
									<xsl:apply-templates select="*"
														 mode="excludedSuites">
									</xsl:apply-templates>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<thead class="trhead">
									<th align="left"> Name  </th>
									<th align="left"> Description  </th>
									<!-- If there are more than one levels then add conditions to differentiate -->
									<th align="left"> Parent Name  </th>
									<th align="left"> Total TestSteps  </th>
									<th align="left"> Success  </th>
									<th align="left"> Skipped </th>
									<th align="left"> Failures </th>
									<th align="left"> Status </th>
									<th align="left"> Time </th>
									<!-- 									<th align="left" width="10%" title="Difference in execution time from the average execution time of this asset on the same machine">Mean Time Difference</th> -->
									<th align="left"> Remarks </th>
								</thead>
								<xsl:if test="$status='all'">
									<xsl:apply-templates select="*" mode="allCases">
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$status = 'pass'">
									<xsl:apply-templates select="*" mode="passedCases">
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$status='fail'">
									<xsl:apply-templates select="*" mode="failedCases">
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$status='skipped'">
									<xsl:apply-templates select="*" mode="skippedCases">
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$status='disabled'">
									<xsl:apply-templates select="*" mode="disabledCases">
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$status='excluded'">
									<xsl:apply-templates select="*" mode="excludedCases">
									</xsl:apply-templates>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</table>
					<xsl:copy-of select="$copyright" />
				</body>
			</html>
		</redirect:write>
	</xsl:template>





	<xsl:template name="AllTestsCases">
		<xsl:variable name="totalTCcount">
			<xsl:value-of
					select="count(current()//teststep)" />
		</xsl:variable>
		<xsl:variable name="passTCcount">
			<xsl:value-of
					select="count(current()//teststep[@status='pass'])" />
		</xsl:variable>
		<xsl:variable name="skipTCcount">
			<xsl:value-of
					select="count(current()//teststep[@status='skip'])" />
		</xsl:variable>
		<xsl:variable name="failTCcount">
			<xsl:value-of
					select="$totalTCcount - $passTCcount - $skipTCcount" />
		</xsl:variable>
		<xsl:variable name="status">
			<xsl:value-of select="@status">
			</xsl:value-of>
		</xsl:variable>
		<tr>
			<xsl:attribute name="class">
				<xsl:value-of select="''" />
			</xsl:attribute>
			<xsl:variable name="link">
				<xsl:call-template name="genLink">
					<xsl:with-param name="nodePath" select="'@id'" />
					<xsl:with-param name="linkPath" select="''" />
				</xsl:call-template>
			</xsl:variable>
			<td>
				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="concat('../',$link, 'testcase-report.html')">
						</xsl:value-of>
					</xsl:attribute>
					<xsl:value-of select="@name" />
				</a>
			</td>
			<td class="wordBreak">
				<xsl:value-of select="@description" />
			</td>
			<td>
				<div class="alftooltip tooltip">
					<xsl:value-of select="../@name" />
					<span class="tooltiptext">
						<div
								style="font-weight:bold;color:black;font-size:120%;text-align:center"> Parents </div>
						<xsl:apply-templates select=".."
											 mode="generateParentPath" />
					</span>
				</div>
			</td>
			
			<td>
				<xsl:value-of select="$totalTCcount" />
			</td>
			<td>
				<xsl:value-of select="$passTCcount" />
			</td>
			<td>
				<xsl:value-of select="$skipTCcount" />
			</td>
			<td>
				<xsl:value-of select="$failTCcount" />
			</td>
			<td>
				<xsl:call-template name="displayprogressbar">
					<xsl:with-param name="totalCount" select="$totalTCcount"/>
					<xsl:with-param name="passedCount" select="$passTCcount"/>
					<xsl:with-param name="failedCount" select="$failTCcount"/>
					<xsl:with-param name="skippedCount" select="$skipTCcount"/>

				</xsl:call-template>
			</td>
			<xsl:variable name="timeCount" select="sum(current()//count/@timecount)" />
			<td>
				<xsl:call-template name="SetTime">
					<xsl:with-param name="time" select="@timeCount" />
				</xsl:call-template>
			</td>
			<!-- 			<td> -->
			<!-- 				<xsl:call-template name="setTimeStatus"> -->
			<!-- 					<xsl:with-param name="timeStatus" select="@timeStatus" /> -->
			<!-- 				</xsl:call-template> -->
			<!-- 			</td> -->
			<td class="wordBreak">
				<xsl:value-of select="@remarks" />
			</td>
		</tr>
	</xsl:template>


	<xsl:template name="AllTestSuites">
		<xsl:variable name="totalTCcount">
			<xsl:value-of
					select="sum(current()//testcase/count/@total[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)])" />
		</xsl:variable>
		<xsl:variable name="passTCcount">
			<xsl:value-of
					select="sum(current()//testcase/count/@pass[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)])" />
		</xsl:variable>
		<xsl:variable name="skipTCcount">
			<xsl:value-of
					select="sum(current()//testcase/count/@skipped[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)])" />
		</xsl:variable>
		<xsl:variable name="failTCcount">
			<xsl:value-of
					select="$totalTCcount - $passTCcount - $skipTCcount" />
		</xsl:variable>

		<!-- 		<xsl:variable name="averageTimeSum"> -->
		<!-- 			<xsl:value-of select="sum(current()//testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@averageTimeTaken)"></xsl:value-of> -->
		<!-- 		</xsl:variable> -->

		<!-- 		<xsl:variable name="totalTestcaseExecutionTime"> -->
		<!-- 			<xsl:value-of select="sum(current()//testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@timeCount)"></xsl:value-of> -->
		<!-- 		</xsl:variable> -->

		<!-- 		<xsl:variable name="timeStatus"> -->
		<!-- 		<xsl:choose> -->
		<!-- 			<xsl:when test="$averageTimeSum = 0"> -->
		<!-- 			<xsl:value-of select="$averageTimeSum"></xsl:value-of> -->
		<!-- 			</xsl:when> -->
		<!-- 			<xsl:otherwise>		 -->
		<!-- 			<xsl:value-of select="$totalTestcaseExecutionTime - $averageTimeSum"></xsl:value-of> -->
		<!-- 			</xsl:otherwise>	 -->
		<!-- 			</xsl:choose> -->
		<!-- 		</xsl:variable> -->

		<tr>
			<xsl:attribute name="class">
				<xsl:value-of select="''" />
			</xsl:attribute>
			<xsl:variable name="link">
				<xsl:call-template name="genLink">
					<xsl:with-param name="nodePath" select="'@id'" />
					<xsl:with-param name="linkPath" select="''" />
				</xsl:call-template>
			</xsl:variable>
			<td>
				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="concat('../',$link, 'testsuite-report.html')">
						</xsl:value-of>
					</xsl:attribute>
					<xsl:value-of select="@name" />
				</a>
			</td>
			<td class="wordBreak">
				<xsl:value-of select="@description" />
			</td>
			<td>
				<div class="alftooltip tooltip">
					<xsl:value-of select="../@name" />
					<span class="tooltiptext">
						<div
								style="font-weight:bold;color:black;font-size:120%;text-align:center"> Parents </div>
						<xsl:apply-templates select=".."
											 mode="generateParentPath" />
					</span>
				</div>
			</td>
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
				<xsl:value-of select="$skipTCcount" />
			</td>
			<td>
				<xsl:call-template name="displayprogressbar">
					<xsl:with-param name="totalCount" select="$totalTCcount"/>
					<xsl:with-param name="passedCount" select="$passTCcount"/>
					<xsl:with-param name="failedCount" select="$failTCcount"/>
					<xsl:with-param name="skippedCount" select="$skipTCcount"/>

				</xsl:call-template>
			</td>
			<xsl:variable name="timeCount" select="@timeCount" />
			<td>
				<xsl:call-template name="SetTime">
					<xsl:with-param name="time" select="$timeCount" />
				</xsl:call-template>
			</td>
			<!-- 			<td> -->
			<!-- 				<xsl:call-template name="setTimeStatus"> -->
			<!-- 					<xsl:with-param name="timeStatus" select="$timeStatus" /> -->
			<!-- 				</xsl:call-template> -->
			<!-- 			</td> -->
			<td class="wordBreak">
				<xsl:value-of select="current()/@remarks" />
			</td>
		</tr>
	</xsl:template>


	<xsl:template name="AllActions">
		<xsl:variable name="link">
			<xsl:call-template name="genLink">
				<xsl:with-param name="nodePath" select="'@id'" />
				<xsl:with-param name="linkPath" select="''" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="type1">
			<xsl:value-of select="preceding-sibling::action/../@name" />
		</xsl:variable>
		<xsl:variable name="type2">
			<xsl:value-of select="../@name" />
		</xsl:variable>
		<xsl:variable name="status">
			<xsl:value-of select="@status" />
		</xsl:variable>


		<xsl:if test="$type1 != $type2 ">
			<tr>
				<td colspan="9">
					<ol class="breadcrump-pad breadcrumb">
						<li class="active">
							<xsl:value-of select="$type2" />
						</li>
						<li class="active">
							<xsl:value-of select="../../@name" />
						</li>
					</ol>
				</td>
			</tr>

		</xsl:if>
		<tr>
			<xsl:attribute name="class">
				<xsl:value-of select="''" />
			</xsl:attribute>

			<td>
				<xsl:choose>
					<xsl:when test="@actionLanguage = 'QTP'">
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="concat('../',$link,'screen-report.html')" />
							</xsl:attribute>
							<xsl:attribute name="target">_blank</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="@description" />
							</xsl:attribute>
							<xsl:value-of select="@name" />
						</a>
					</xsl:when>
					<xsl:when test="@actionLanguage = 'SELENIUM'">
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="concat('../',$link,'screen-report.html')" />
							</xsl:attribute>
							<xsl:attribute name="target">_blank</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="@description" />
							</xsl:attribute>
							<xsl:value-of select="@name" />
						</a>
					</xsl:when>
					<xsl:when test="@actionLanguage = 'WEBDRIVER'">
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="concat('../',$link,'screen-report.html')" />
							</xsl:attribute>
							<xsl:attribute name="target">_blank</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="@description" />
							</xsl:attribute>
							<xsl:value-of select="@name" />
						</a>
					</xsl:when>
					<xsl:when test="@actionLanguage = 'CNL'">
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="concat('../',$link,'screen-report.html')" />
							</xsl:attribute>
							<xsl:attribute name="target">_blank</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="@description" />
							</xsl:attribute>
							<xsl:value-of select="@name" />
						</a>
					</xsl:when>

					<xsl:when test="@actionLanguage = 'FEST'">
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="concat('../',$link,'screen-report.html')" />
							</xsl:attribute>
							<xsl:attribute name="target">_blank</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="@description" />
							</xsl:attribute>
							<xsl:value-of select="@name" />
						</a>
					</xsl:when>
					<xsl:when test="@actionLanguage = 'IS_Service'">
						<xsl:value-of select="@name" />
					</xsl:when>
					<xsl:when test="@actionLanguage = 'VENUS'">
						<xsl:value-of select="@name" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@name" />
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td class="wordBreak">
				<xsl:value-of select="@description" />
			</td>
			<td align="left">
				<div class="alftooltip tooltip">
					<xsl:value-of select="../@name" />
					<span class="tooltiptext">
						<div
								style="font-weight:bold;color:black;font-size:120%;text-align:center"> Parents </div>
						<xsl:apply-templates select=".."
											 mode="generateParentPath" />
					</span>
				</div>
			</td>
			<td>
				<xsl:variable name="toolSpecificReport">
					<xsl:value-of select="@toolSpecificReport" />
				</xsl:variable>
				<xsl:if test="$toolSpecificReport != 'null'">
					<a>
						<xsl:attribute name="href">
							<xsl:value-of select="concat('../',$link,$toolSpecificReport,'?actionid=',@id)" />
						</xsl:attribute>
						<xsl:attribute name="target">_blank</xsl:attribute>
						<xsl:value-of select="@actionLanguage" />
					</a>
				</xsl:if>

				<xsl:if test="$toolSpecificReport = 'null'">
					<xsl:value-of select="@actionLanguage" />
				</xsl:if>
			</td>
			<td align="center">
				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="concat('../',$link,'StepReportAnalysis.html')" />
					</xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>
					Analytics
				</a>
			</td>
			<td align="center">
				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="concat('../', $link,'datarow.html')" />
					</xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>
					<xsl:value-of select="'data'" />
				</a>
			</td>
			<td>
				<xsl:call-template name="SetImage">
					<xsl:with-param name="status" select="$status" />
				</xsl:call-template>
			</td>
			<td>
				<xsl:call-template name="SetTime">
					<xsl:with-param name="time" select="@timeCount"></xsl:with-param>
				</xsl:call-template>
			</td>
			<td>
				<a>
					<xsl:attribute name="href"><xsl:value-of select="@satpath" /></xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>
					SAT link
				</a>
			</td>
			
			<!-- 			<td align="center"> -->
			<!-- 				<xsl:call-template name="setTimeStatus"> -->
			<!-- 					<xsl:with-param name="timeStatus" select="@timeStatus" /> -->
			<!-- 				</xsl:call-template> -->
			<!-- 			</td> -->
			<td style="white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-wrap: break-word;"><xsl:call-template name="getRemarks">
				<xsl:with-param name="text" select="@remarks"/></xsl:call-template></td>
		</tr>
	</xsl:template>

	<xsl:template name="genLink">
		<xsl:param name="nodePath" />
		<xsl:param name="linkPath" />
		<xsl:choose>
			<xsl:when test="starts-with($linkPath,'PID' )">
				<xsl:value-of select="$linkPath">
				</xsl:value-of>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="node">
					<xsl:value-of select="dyn:evaluate($nodePath)" />
				</xsl:variable>
				<xsl:call-template name="genLink">
					<xsl:with-param name="nodePath" select="concat('../',$nodePath)" />
					<xsl:with-param name="linkPath">
						<xsl:choose>
							<xsl:when test="starts-with($linkPath,'/')">
								<xsl:value-of select="concat($node,'/',substring($linkPath,2))" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($node,'/',$linkPath)">
								</xsl:value-of>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- list all skipped test steps -->

	<xsl:template
			match="teststep[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]"
			mode="allSteps">
		<xsl:call-template name="AllActions" />
	</xsl:template>
	<!-- list all passed test steps -->

	<!-- eliminating the fixture tests as it will nit be counted -->
	<xsl:template
			match="teststep[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]"
			mode="passedSteps">
		<xsl:variable name="status" select="@status" />
		<xsl:if test="$status='pass'">
			<xsl:call-template name="AllActions">
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- list all failed test steps -->

	<xsl:template
			match="teststep[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]"
			mode="failedSteps">
		<xsl:variable name="status" select="@status" />
		<xsl:if test="$status='fail'">
			<xsl:call-template name="AllActions">
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- list all warning test steps -->

	<xsl:template
			match="teststep[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]"
			mode="warningSteps">
		<xsl:variable name="status" select="@status" />
		<xsl:if test="$status='warning'">
			<xsl:call-template name="AllActions">
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- list all skipped test steps -->
	<xsl:template
			match="teststep[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]"
			mode="skippedSteps">
		<xsl:if test="@status='skipped'">
			<xsl:call-template name="AllActions">
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- list all disabled test steps -->

	<xsl:template
			match="teststep[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]"
			mode="disabledSteps">
		<xsl:variable name="status" select="@status" />
		<xsl:if test="$status='disabled'">
			<xsl:call-template name="AllActions">
			</xsl:call-template>
		</xsl:if>
	</xsl:template>


	<!-- list all disabled test steps -->

	<xsl:template
			match="teststep[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]"
			mode="excludedSteps">
		<xsl:variable name="status" select="@status" />
		<xsl:if test="$status='excluded'">
			<xsl:call-template name="AllActions">
			</xsl:call-template>
		</xsl:if>
	</xsl:template>



	<!-- list all test cases -->

	<xsl:template
			match="testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]"
			mode="allCases">
		<xsl:call-template name="AllTestsCases" />
	</xsl:template>

	<!-- list all passed test cases -->

	<xsl:template
			match="testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]"
			mode="passedCases">
		<xsl:if test="@status='pass'">
			<xsl:call-template name="AllTestsCases">
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- list all failed test cases -->

	<xsl:template
			match="testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]"
			mode="failedCases">
		<xsl:if test="@status='fail'">
			<xsl:call-template name="AllTestsCases">
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- list all warning test cases -->

	<xsl:template
			match="testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]"
			mode="warningCases">
		<xsl:if test="@status='warning'">
			<xsl:call-template name="AllTestsCases">
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- list all skipped test cases -->

	<xsl:template
			match="testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]"
			mode="skippedCases">
		<xsl:if test="@status='skipped'">
			<xsl:call-template name="AllTestsCases">
			</xsl:call-template>
		</xsl:if>
	</xsl:template>


	<!-- list all disabled test cases -->

	<xsl:template
			match="testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]"
			mode="disabledCases">
		<xsl:if test="@status='disabled'">
			<xsl:call-template name="AllTestsCases">
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- list all excluded stest cases -->

	<xsl:template
			match="testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]"
			mode="excludedCases">
		<xsl:if test="@status='excluded'">
			<xsl:call-template name="AllTestsCases">
			</xsl:call-template>
		</xsl:if>
	</xsl:template>



	<!-- list all test suites -->

	<xsl:template match="testsuite" mode="allSuites">
		<xsl:call-template name="AllTestSuites">
		</xsl:call-template>
		<xsl:apply-templates select="testsuite" mode="allSuites">
		</xsl:apply-templates>
	</xsl:template>

	<!-- list all passed test suites -->

	<xsl:template match="testsuite" mode="passedSuites">
		<xsl:if test="@status='pass'">
			<xsl:call-template name="AllTestSuites">
			</xsl:call-template>
		</xsl:if>
		<xsl:apply-templates select="testsuite" mode="passedSuites">
		</xsl:apply-templates>
	</xsl:template>

	<!-- list all failed test suites -->

	<xsl:template match="testsuite" mode="failedSuites">
		<xsl:if test="@status='fail'">
			<xsl:call-template name="AllTestSuites">
			</xsl:call-template>
		</xsl:if>
		<xsl:apply-templates select="testsuite" mode="failedSuites">
		</xsl:apply-templates>
	</xsl:template>

	<!-- list all warning test suites -->

	<xsl:template match="testsuite" mode="warningSuites">
		<xsl:if test="@status='warning'">
			<xsl:call-template name="AllTestSuites">
			</xsl:call-template>
		</xsl:if>
		<xsl:apply-templates select="testsuite" mode="warningSuites">
		</xsl:apply-templates>
	</xsl:template>


	<!-- list all skipped test suites -->

	<xsl:template match="testsuite" mode="skippedSuites">
		<xsl:if test="@status='skipped'">
			<xsl:call-template name="AllTestSuites">
			</xsl:call-template>
		</xsl:if>
		<xsl:apply-templates select="testsuite" mode="skippedSuites">
		</xsl:apply-templates>
	</xsl:template>

	<!-- list all disabled test suites -->

	<xsl:template match="testsuite" mode="disabledSuites">
		<xsl:if test="@status='disabled'">
			<xsl:call-template name="AllTestSuites">
			</xsl:call-template>
		</xsl:if>
		<xsl:apply-templates select="testsuite" mode="disabledSuites">
		</xsl:apply-templates>
	</xsl:template>


	<!-- list all excluded test suites -->

	<xsl:template match="testsuite" mode="excludedSuites">
		<xsl:if test="@status='excluded'">
			<xsl:call-template name="AllTestSuites">
			</xsl:call-template>
		</xsl:if>
		<xsl:apply-templates select="testsuite" mode="excludedSuites">
		</xsl:apply-templates>
	</xsl:template>



	<xsl:template match="*" mode="generateParentPath">
		<xsl:variable name="parentName">
			<xsl:value-of select="@name" />
		</xsl:variable>
		<xsl:variable name="parentId">
			<xsl:value-of select="@id" />
		</xsl:variable>
		<xsl:if test="not(starts-with($parentId,'PID'))">
			<xsl:apply-templates select=".." mode="generateParentPath" />
		</xsl:if>
		<xsl:choose>
			<xsl:when test="starts-with($parentId,'TCID')">
				<div class="tctooltip">
					&#8679;
					<br />
					<xsl:value-of select="$parentName" />
				</div>
			</xsl:when>
			<xsl:when test="starts-with($parentId,'TSID')">
				<div class="tstooltip">
					&#8679;
					<br />
					<xsl:value-of select="$parentName" />
				</div>
			</xsl:when>
			<xsl:when test="starts-with($parentId,'PID')">
				<div class="ptooltip">
					<xsl:value-of select="$parentName" />
				</div>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="createAllMiscSteps">
		<xsl:param name="status" />
		<xsl:variable name="filename">./<xsl:value-of select="$status"/>-warning-step.html</xsl:variable>

		<redirect:write file="{$filename}">
			<html>
				<head>
					<title>Full SAT Report</title>
					<link rel="stylesheet" type="text/css" href="reportStyle.css" />
					<link rel="stylesheet" type="text/css" href="./lib/bootstrap.min.css" />
					<link rel="stylesheet" type="text/css" href="./lib/alfReport.css" />
				</head>
				<body>
					<xsl:call-template name="logo">
						<xsl:with-param name="backdir" select="'./'" />
					</xsl:call-template>
					<xsl:call-template name="set.heading">
						<xsl:with-param name="heading"
										select="concat('All TestSteps With ',$status,' Warnings')" />
					</xsl:call-template>
					<table width="100%" class="alfTable table table-hover">
						<thead class="trhead">
							<th align="left"> Name   </th>
							<th align="left"> Parent   </th>
							<th align="center"> Tool Report   </th>
							<th align="center"> Analytics   </th>
							<th align="center"> Data row   </th>
							<th align="left"> Status   </th>
							<th align="left"> Time  </th>
							<!-- 									<th align="left" width="10%" title="Difference in execution time from the average execution time of this asset on the same machine">Mean Time Difference</th> -->
							<th align="left" width="40%"> Remarks   </th>
						</thead>
						<!-- 								<xsl:if test="$status='Time'"> -->
						<!-- 									<xsl:apply-templates select="*" mode="allTimeWarningSteps"> -->
						<!-- 									</xsl:apply-templates> -->
						<!-- 									</xsl:if> -->
						<xsl:if test="$status='Alert'">
							<xsl:apply-templates select="*" mode="allAlertWarningSteps">
							</xsl:apply-templates>
						</xsl:if>
						<xsl:if test="$status='Popup'">
							<xsl:apply-templates select="*" mode="allPopupWarningSteps">
							</xsl:apply-templates>
						</xsl:if>
						<xsl:if test="$status='Retry'">
							<xsl:apply-templates select="*" mode="allRetryWarningSteps">
							</xsl:apply-templates>
						</xsl:if>
						<xsl:if test="$status='Recovery'">
							<xsl:apply-templates select="*" mode="allRecoveryWarningSteps">
							</xsl:apply-templates>
						</xsl:if>
						<xsl:if test="$status='Donotfail'">
							<xsl:apply-templates select="*" mode="allDonotFailWarningSteps">
							</xsl:apply-templates>
						</xsl:if>
						<xsl:if test="$status='ignoreOperation'">
							<xsl:apply-templates select="*" mode="allIgnoreOperationWarningSteps">
							</xsl:apply-templates>
						</xsl:if>

					</table>
					<xsl:copy-of select="$copyright" />
				</body>
			</html>
		</redirect:write>
	</xsl:template>

	<xsl:template
			match="teststep[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]"
			mode="allAlertWarningSteps">
		<xsl:if test="current()[step/@warningReason='alert']">
			<xsl:call-template name="AllActions" />
		</xsl:if>
	</xsl:template>

	<xsl:template
			match="teststep[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]"
			mode="allRetryWarningSteps">
		<xsl:if test="current()//step/@warningReason='retry'">
			<xsl:call-template name="AllActions" />
		</xsl:if>
	</xsl:template>

	<xsl:template
			match="teststep[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]"
			mode="allRecoveryWarningSteps">
		<xsl:if test="current()//step/@warningReason='recovery'">
			<xsl:call-template name="AllActions" />
		</xsl:if>
	</xsl:template>
	<!-- 	<xsl:template -->
	<!-- 		match="teststep[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]" -->
	<!-- 		mode="allTimeWarningSteps"> -->
	<!-- 		<xsl:if test="@timeStatus > 0"> -->
	<!-- 		<xsl:call-template name="AllActions" /> -->
	<!-- 		</xsl:if> -->
	<!-- 	</xsl:template> -->
	<xsl:template
			match="teststep[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]"
			mode="allPopupWarningSteps">
		<xsl:if test="current()//step/@warningReason='popup'">
			<xsl:call-template name="AllActions" />
		</xsl:if>
	</xsl:template>
	<xsl:template
			match="teststep[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]"
			mode="allDonotFailWarningSteps">
		<xsl:if test="current()//step/@warningReason='donotfailflag'">
			<xsl:call-template name="AllActions" />
		</xsl:if>
	</xsl:template>
	<xsl:template
			match="teststep[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]"
			mode="allIgnoreOperationWarningSteps">
		<xsl:if test="current()//step/@warningReason='ignoreoperationkeyword'">
			<xsl:call-template name="AllActions" />
		</xsl:if>
	</xsl:template>

	<xsl:template name="generate-misc-teststeps.html">

		<!-- 	<xsl:param name="extra.time.step.count" select="count(current()//teststep[(@timeStatus) > 0 and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/> -->
		<!-- 	<xsl:param name="extra.time.step.pass.count" select="count(current()//teststep[@status='pass' and @timeStatus > 0 and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/> -->
		<!-- 	<xsl:param name="extra.time.step.fail.count" select="count(current()//teststep[@status='fail' and @timeStatus > 0 and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/> -->
		<!-- 	<xsl:param name="extra.time.step.total.time" select="sum(current()//teststep[@timeStatus > 0 and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]/@timeCount)"/> -->
		<xsl:param name="alert.step.count" select="count(current()//teststep[step/@warningReason='alert' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="alert.step.pass.count" select="count(current()//teststep[step/@warningReason='alert' and @status='pass' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="alert.step.fail.count" select="count(current()//teststep[step/@warningReason='alert' and @status='fail' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="alert.step.total.time" select="sum(current()//teststep[step/@warningReason='alert' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]/@timeCount)"/>
		<xsl:param name="popup.step.count" select="count(current()//teststep[step/@warningReason='popup' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="popup.step.pass.count" select="count(current()//teststep[step/@warningReason='popup' and @status='pass' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="popup.step.fail.count" select="count(current()//teststep[step/@warningReason='popup' and @status='fail' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="popup.step.total.time" select="sum(current()//teststep[step/@warningReason='popup' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]/@timeCount)"/>
		<xsl:param name="retry.step.count" select="count(current()//teststep[step/@warningReason='retry' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="retry.step.pass.count" select="count(current()//teststep[step/@warningReason='retry' and @status='pass' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="retry.step.fail.count" select="count(current()//teststep[step/@warningReason='retry' and @status='fail' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="retry.step.total.time" select="sum(current()//teststep[step/@warningReason='retry' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]/@timeCount)"/>
		<xsl:param name="recovery.step.count" select="count(current()//teststep[step/@warningReason='recovery' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="recovery.step.pass.count" select="count(current()//teststep[step/@warningReason='recovery' and @status='pass' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="recovery.step.fail.count" select="count(current()//teststep[step/@warningReason='recovery' and @status='fail' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="recovery.step.total.time" select="sum(current()//teststep[step/@warningReason='recovery' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]/@timeCount)"/>
		<xsl:param name="donotfail.step.count" select="count(current()//teststep[step/@warningReason='donotfailflag' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="donotfail.step.pass.count" select="count(current()//teststep[step/@warningReason='donotfailflag' and @status='pass' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="donotfail.step.fail.count" select="count(current()//teststep[step/@warningReason='donotfailflag' and @status='fail' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="donotfail.step.total.time" select="sum(current()//teststep[step/@warningReason='donotfailflag' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]/@timeCount)"/>
		<xsl:param name="ignoreoperationkeyword.step.count" select="count(current()//teststep[step/@warningReason='ignoreoperationkeyword' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="ignoreoperationkeyword.step.pass.count" select="count(current()//teststep[step/@warningReason='ignoreoperationkeyword' and @status='pass' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="ignoreoperationkeyword.step.fail.count" select="count(current()//teststep[step/@warningReason='ignoreoperationkeyword' and @status='fail' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)])"/>
		<xsl:param name="ignoreoperationkeyword.step.total.time" select="sum(current()//teststep[step/@warningReason='ignoreoperationkeyword' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforecase | ancestor::aftercase | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforeeverycase | ancestor::aftereverycase)]/@timeCount)"/>

		<redirect:write file="misc-teststeps.html">

			<html>
				<head>
					<title>Full SAT Report</title>
					<link rel="stylesheet" type="text/css" href="reportStyle.css" />
					<link rel="stylesheet" type="text/css" href="./lib/bootstrap.min.css" />
					<link rel="stylesheet" type="text/css" href="./lib/alfReport.css" />
				</head>
				<body>
					<xsl:call-template name="logo">
						<xsl:with-param name="backdir" select="'./'" />
					</xsl:call-template>
					<xsl:call-template name="set.heading">
						<xsl:with-param name="heading"
										select="'TestSteps With Warnings'" />
					</xsl:call-template>
					<table width="100%" class="alfTable table table-hover">
						<thead calss="trhead">
							<th align="left"> Types</th>
							<!-- If there are more than one levels then add conditions to differentiate -->
							<th align="left"> Number Of testSteps</th>
							<th align="left"> Total Passed  </th>
							<th align="left"> Total Failed  </th>
							<th align="left"> Total TimeTaken </th>
						</thead>
						<!-- 								<tr> -->
						<!-- 								<td> -->
						<!-- 						<xsl:call-template name="createAllMiscSteps"> -->
						<!-- 							<xsl:with-param name="status" select="'Time'" /> -->
						<!-- 						</xsl:call-template> -->
						<!-- 						<a> -->
						<!-- 							<xsl:attribute name="href">./Time-warning-step.html</xsl:attribute> -->
						<!-- 							<xsl:attribute name="target">rightFrame</xsl:attribute> -->
						<!-- 							TestSteps that took more time compared to previous builds -->
						<!-- 						</a> -->
						<!-- 					</td> -->
						<!-- 					<td> -->
						<!-- 						<xsl:value-of select="$extra.time.step.count"/> -->
						<!-- 					</td> -->
						<!-- 					<td> -->
						<!-- 						<xsl:value-of select="$extra.time.step.pass.count"/> -->
						<!-- 					</td> -->
						<!-- 					<td> -->
						<!-- 						<xsl:value-of select="$extra.time.step.fail.count"/> -->
						<!-- 					</td> -->
						<!-- 					<td> -->
						<!-- 					<xsl:call-template name="SetTime"> -->
						<!-- 						<xsl:with-param name="time" select="$extra.time.step.total.time"> -->
						<!-- 						</xsl:with-param> -->
						<!-- 						</xsl:call-template> -->
						<!-- 					</td> -->
						<!-- 					</tr> -->
						<tr>
							<td>
								<xsl:call-template name="createAllMiscSteps">
									<xsl:with-param name="status" select="'Alert'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./Alert-warning-step.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestSteps where Alerts are handled
								</a>
							</td>
							<td>
								<xsl:value-of select="$alert.step.count"/>
							</td>
							<td>
								<xsl:value-of select="$alert.step.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$alert.step.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$alert.step.total.time">
									</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="createAllMiscSteps">
									<xsl:with-param name="status" select="'Popup'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./Popup-warning-step.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestSteps where Unexpected Pop-ups are handled
								</a>
							</td>
							<td>
								<xsl:value-of select="$popup.step.count"/>
							</td>
							<td>
								<xsl:value-of select="$popup.step.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$popup.step.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$popup.step.total.time">
									</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="createAllMiscSteps">
									<xsl:with-param name="status" select="'Retry'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./Retry-warning-step.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestSteps where Retry mechanism was triggered
								</a>
							</td>
							<td>
								<xsl:value-of select="$retry.step.count"/>
							</td>
							<td>
								<xsl:value-of select="$retry.step.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$retry.step.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$retry.step.total.time">
									</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="createAllMiscSteps">
									<xsl:with-param name="status" select="'Recovery'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./Recovery-warning-step.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestSteps where Recovery mechanism was triggered
								</a>
							</td>
							<td>
								<xsl:value-of select="$recovery.step.count"/>
							</td>
							<td>
								<xsl:value-of select="$recovery.step.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$recovery.step.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$recovery.step.total.time"/>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="createAllMiscSteps">
									<xsl:with-param name="status" select="'Donotfail'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./Donotfail-warning-step.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestSteps where failure was suppressed due to DoNotFailOnError Flag
								</a>
							</td>
							<td>
								<xsl:value-of select="$donotfail.step.count"/>
							</td>
							<td>
								<xsl:value-of select="$donotfail.step.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$donotfail.step.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$donotfail.step.total.time"/>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="createAllMiscSteps">
									<xsl:with-param name="status" select="'ignoreOperation'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./ignoreOperation-warning-step.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestSteps where CNL Steps are skipped
								</a>
							</td>
							<td>
								<xsl:value-of select="$ignoreoperationkeyword.step.count"/>
							</td>
							<td>
								<xsl:value-of select="$ignoreoperationkeyword.step.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$ignoreoperationkeyword.step.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$ignoreoperationkeyword.step.total.time"/>
								</xsl:call-template>
							</td>
						</tr>
					</table>
				</body>
			</html>
		</redirect:write>
	</xsl:template>

	<!-- 	<xsl:template name="setTimeStatus"> -->
	<!-- 	<xsl:param name="timeStatus"/> -->
	<!-- 	<xsl:if test="$timeStatus > 0"> -->
	<!-- 	<label style="color:red;" title="Execution took more time than the average execution time of this asset on this machine"> + -->
	<!-- 	<xsl:choose> -->
	<!-- 			<xsl:when test="floor($timeStatus div 60) > '59'"> -->
	<!-- 				<xsl:value-of -->
	<!-- 					select="concat(floor($timeStatus div 3600),'h ',floor(($timeStatus div 60) mod 60),'m ',$timeStatus mod 60,'s')" /> -->
	<!-- 			</xsl:when> -->
	<!-- 			<xsl:when test="floor($timeStatus div 60) > '0'"> -->
	<!-- 				<xsl:value-of select="concat(floor($timeStatus div 60),'m ',$timeStatus mod 60,'s')" /> -->
	<!-- 			</xsl:when> -->
	<!-- 			<xsl:otherwise> -->
	<!-- 				<xsl:value-of select="concat($timeStatus mod 60,'s')" /> -->
	<!-- 			</xsl:otherwise> -->
	<!-- 		</xsl:choose> -->
	<!-- 		</label> -->
	<!-- 	</xsl:if> -->
	<!-- 	<xsl:if test="$timeStatus &lt; 1"> -->
	<!-- 	<label style="color:green;" title="Execution took less time than the average execution time of this asset on this machine">  -->
	<!-- 	<xsl:choose> -->
	<!-- 			<xsl:when test="floor($timeStatus div 60) > '59'"> -->
	<!-- 				<xsl:value-of -->
	<!-- 					select="concat(floor($timeStatus div 3600),'h ',floor(($timeStatus div 60) mod 60),'m ',$timeStatus mod 60,'s')" /> -->
	<!-- 			</xsl:when> -->
	<!-- 			<xsl:when test="floor($timeStatus div 60) > '0'"> -->
	<!-- 				<xsl:value-of select="concat(floor($timeStatus div 60),'m ',$timeStatus mod 60,'s')" /> -->
	<!-- 			</xsl:when> -->
	<!-- 			<xsl:otherwise> -->
	<!-- 				<xsl:value-of select="concat($timeStatus mod 60,'s')" /> -->
	<!-- 			</xsl:otherwise> -->
	<!-- 		</xsl:choose> -->
	<!-- 		</label> -->
	<!-- 	</xsl:if> -->
	<!-- 	</xsl:template> -->



	<xsl:template name="generate-misc-testcases.html">

		<!-- 	<xsl:param name="extra.time.case.count" select="count(current()//testcase[@timeStatus > 0 and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/> -->
		<!-- 	<xsl:param name="extra.time.case.pass.count" select="count(current()//testcase[@status='pass' and @timeStatus > 0 and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/> -->
		<!-- 	<xsl:param name="extra.time.case.fail.count" select="count(current()//testcase[@status='fail' and @timeStatuss > 0 and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/> -->
		<!-- 	<xsl:param name="extra.time.case.total.time" select="sum(current()//testcase[@timeStatus > 0 and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite )]/@timeCount)"/> -->
		<xsl:param name="alert.case.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='alert') and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="alert.case.pass.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='alert') and @status='pass' and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="alert.case.fail.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='alert') and @status='fail' and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="alert.case.total.time" select="sum(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='alert') and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )]/@timeCount)"/>
		<xsl:param name="popup.case.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='popup') and not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="popup.case.pass.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='popup') and @status='pass' and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="popup.case.fail.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='popup') and @status='fail' and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="popup.case.total.time" select="sum(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='popup') and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )]/@timeCount)"/>
		<xsl:param name="retry.case.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='retry') and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="retry.case.pass.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='retry') and @status='pass' and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="retry.case.fail.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='retry') and @status='fail' and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="retry.case.total.time" select="sum(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='retry') and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )]/@timeCount)"/>
		<xsl:param name="recovery.case.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='recovery') and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="recovery.case.pass.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='recovery') and @status='pass' and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="recovery.case.fail.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='recovery') and @status='fail' and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="recovery.case.total.time" select="sum(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='recovery') and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )]/@timeCount)"/>
		<xsl:param name="donotfail.case.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='donotfailflag') and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="donotfail.case.pass.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='donotfailflag') and @status='pass' and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="donotfail.case.fail.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='donotfailflag') and @status='fail' and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="donotfail.case.total.time" select="sum(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='donotfailflag') and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )]/@timeCount)"/>
		<xsl:param name="ignoreoperationkeyword.case.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='ignoreoperationkeyword') and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="ignoreoperationkeyword.case.pass.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='ignoreoperationkeyword') and @status='pass' and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="ignoreoperationkeyword.case.fail.count" select="count(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='ignoreoperationkeyword') and @status='fail' and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )])"/>
		<xsl:param name="ignoreoperationkeyword.case.total.time" select="sum(current()//testcase[(descendant-or-self::node()/step[not(ancestor::beforeeverycase | ancestor::aftereverycase)]/@warningReason='ignoreoperationkeyword') and not(ancestor::beforesuite | ancestor::aftersuite |  ancestor::beforeeverysuite | ancestor::aftereverysuite )]/@timeCount)"/>

		<redirect:write file="misc-testcases.html">

			<html>
				<head>
					<title>Full SAT Report</title>
					<link rel="stylesheet" type="text/css" href="reportStyle.css" />
					<link rel="stylesheet" type="text/css" href="./lib/bootstrap.min.css" />
					<link rel="stylesheet" type="text/css" href="./lib/alfReport.css" />
				</head>
				<body>
					<xsl:call-template name="logo">
						<xsl:with-param name="backdir" select="'./'" />
					</xsl:call-template>
					<xsl:call-template name="set.heading">
						<xsl:with-param name="heading"
										select="'TestCases With Warnings'" />
					</xsl:call-template>
					<table width="100%" class="alfTable table table-hover">
						<thead class="trhead">
							<th align="left"> Types</th>
							<!-- If there are more than one levels then add conditions to differentiate -->
							<th align="left"> Number Of Testcases</th>
							<th align="left"> Total Passed  </th>
							<th align="left"> Total Failed  </th>
							<th align="left"> Total TimeTaken </th>
						</thead>
						<!-- 				<tr> -->
						<!-- 								<td> -->
						<!-- 						<xsl:call-template name="createAllMiscCases"> -->
						<!-- 							<xsl:with-param name="status" select="'Time'" /> -->
						<!-- 						</xsl:call-template> -->
						<!-- 						<a> -->
						<!-- 							<xsl:attribute name="href">./Time-warning-cases.html</xsl:attribute> -->
						<!-- 							<xsl:attribute name="target">rightFrame</xsl:attribute> -->
						<!-- 							TestCases which took more time compared to previous builds -->
						<!-- 						</a> -->
						<!-- 					</td> -->
						<!-- 					<td> -->
						<!-- 						<xsl:value-of select="$extra.time.case.count"/> -->
						<!-- 					</td> -->
						<!-- 					<td> -->
						<!-- 						<xsl:value-of select="$extra.time.case.pass.count"/> -->
						<!-- 					</td> -->
						<!-- 					<td> -->
						<!-- 						<xsl:value-of select="$extra.time.case.fail.count"/> -->
						<!-- 					</td> -->
						<!-- 					<td> -->
						<!-- 					<xsl:call-template name="SetTime"> -->
						<!-- 						<xsl:with-param name="time" select="$extra.time.case.total.time"> -->
						<!-- 						</xsl:with-param> -->
						<!-- 						</xsl:call-template> -->
						<!-- 					</td> -->
						<!-- 					</tr> -->
						<tr>
							<td>
								<xsl:call-template name="createAllMiscCases">
									<xsl:with-param name="status" select="'Alert'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./Alert-warning-cases.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestCases which contains TestSteps where alerts are handled
								</a>
							</td>
							<td>
								<xsl:value-of select="$alert.case.count"/>
							</td>
							<td>
								<xsl:value-of select="$alert.case.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$alert.case.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$alert.case.total.time">
									</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="createAllMiscCases">
									<xsl:with-param name="status" select="'Popup'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./Popup-warning-cases.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestCases which contains TestSteps where  Unexpected Pop-ups are handled
								</a>
							</td>
							<td>
								<xsl:value-of select="$popup.case.count"/>
							</td>
							<td>
								<xsl:value-of select="$popup.case.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$popup.case.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$popup.case.total.time">
									</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="createAllMiscCases">
									<xsl:with-param name="status" select="'Retry'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./Retry-warning-cases.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestCases which contains TestSteps where Retry mechanism was triggered
								</a>
							</td>
							<td>
								<xsl:value-of select="$retry.case.count"/>
							</td>
							<td>
								<xsl:value-of select="$retry.case.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$retry.case.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$retry.case.total.time">
									</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="createAllMiscCases">
									<xsl:with-param name="status" select="'Recovery'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./Recovery-warning-cases.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestCases which contains TestSteps where Recovery mechanism was triggered
								</a>
							</td>
							<td>
								<xsl:value-of select="$recovery.case.count"/>
							</td>
							<td>
								<xsl:value-of select="$recovery.case.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$recovery.case.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$recovery.case.total.time"/>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="createAllMiscCases">
									<xsl:with-param name="status" select="'Donotfail'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./Donotfail-warning-cases.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestCases which contains TestSteps where failure was suppressed due to DoNotFailOnError Flag
								</a>
							</td>
							<td>
								<xsl:value-of select="$donotfail.case.count"/>
							</td>
							<td>
								<xsl:value-of select="$donotfail.case.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$donotfail.case.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$donotfail.case.total.time"/>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="createAllMiscCases">
									<xsl:with-param name="status" select="'ignoreOperation'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./ignoreOperation-warning-cases.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestCases which contains TestSteps where CNL steps were skipped
								</a>
							</td>
							<td>
								<xsl:value-of select="$ignoreoperationkeyword.case.count"/>
							</td>
							<td>
								<xsl:value-of select="$ignoreoperationkeyword.case.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$ignoreoperationkeyword.case.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$ignoreoperationkeyword.case.total.time"/>
								</xsl:call-template>
							</td>
						</tr>
					</table>
				</body>
			</html>
		</redirect:write>
	</xsl:template>

	<xsl:template name="createAllMiscCases">
		<xsl:param name="status" />
		<xsl:variable name="filename">./<xsl:value-of select="$status"/>-warning-cases.html</xsl:variable>

		<redirect:write file="{$filename}">
			<html>
				<head>
					<title>Full SAT Report</title>
					<link rel="stylesheet" type="text/css" href="reportStyle.css" />
					<link rel="stylesheet" type="text/css" href="./lib/bootstrap.min.css" />
					<link rel="stylesheet" type="text/css" href="./lib/alfReport.css" />
				</head>
				<body>
					<xsl:call-template name="logo">
						<xsl:with-param name="backdir" select="'./'" />
					</xsl:call-template>
					<xsl:call-template name="set.heading">
						<xsl:with-param name="heading"
										select="concat('All TestCases with ',$status,' warnings')" />
					</xsl:call-template>
					<table width="100%" class="alfTable table table-hover">
						<thead class="trhead">
							<th align="left"> Name  </th>
							<!-- If there are more than one levels then add conditions to differentiate -->
							<th align="left"> Parent Name  </th>
							<th align="left"> Total TestSteps  </th>
							<th align="left"> Success  </th>
							<th align="left"> Skipped </th>
							<th align="left"> Failures </th>
							<th align="left"> Status </th>
							<th align="left"> Time </th>
							<!-- 									<th align="left" width="10%" title="Difference in execution time from the average execution time of this asset on the same machine">Mean Time Difference</th> -->
							<th align="left"> Remarks </th>
						</thead>
						<!-- 								<xsl:if test="$status='Time'"> -->
						<!-- 									<xsl:apply-templates select="*" mode="allTimeWarningCases"> -->
						<!-- 									</xsl:apply-templates> -->
						<!-- 									</xsl:if> -->
						<xsl:if test="$status='Alert'">
							<xsl:apply-templates select="*" mode="allAlertWarningCases">
							</xsl:apply-templates>
						</xsl:if>
						<xsl:if test="$status='Popup'">
							<xsl:apply-templates select="*" mode="allPopupWarningCases">
							</xsl:apply-templates>
						</xsl:if>
						<xsl:if test="$status='Retry'">
							<xsl:apply-templates select="*" mode="allRetryWarningCases">
							</xsl:apply-templates>
						</xsl:if>
						<xsl:if test="$status='Recovery'">
							<xsl:apply-templates select="*" mode="allRecoveryWarningCases">
							</xsl:apply-templates>
						</xsl:if>
						<xsl:if test="$status='Donotfail'">
							<xsl:apply-templates select="*" mode="allDoNotFailWarningCases">
							</xsl:apply-templates>
						</xsl:if>
						<xsl:if test="$status='ignoreOperation'">
							<xsl:apply-templates select="*" mode="allIgnoreOperationWarningCases">
							</xsl:apply-templates>
						</xsl:if>


					</table>
					<xsl:copy-of select="$copyright" />
				</body>
			</html>
		</redirect:write>
	</xsl:template>

	<!-- 	<xsl:template -->
	<!-- 		match="testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite )]" -->
	<!-- 		mode="allTimeWarningCases"> -->
	<!-- 		<xsl:if test="@timeStatus>0 "> -->
	<!-- 		<xsl:call-template name="AllTestsCases" /> -->
	<!-- 		</xsl:if> -->
	<!-- 	</xsl:template> -->

	<xsl:template
			match="testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite )]"
			mode="allAlertWarningCases">
		<xsl:if test="current()//step[@warningReason='alert' and not(ancestor::beforeeverycase | ancestor::aftereverycase)]">
			<xsl:call-template name="AllTestsCases" />
		</xsl:if>
	</xsl:template>

	<xsl:template
			match="testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite )]"
			mode="allRetryWarningCases">
		<xsl:if test="current()//step[@warningReason='retry' and not(ancestor::beforeeverycase | ancestor::aftereverycase)]">
			<xsl:call-template name="AllTestsCases" />
		</xsl:if>
	</xsl:template>

	<xsl:template
			match="testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite )]"
			mode="allRecoveryWarningCases">
		<xsl:if test="current()//step[@warningReason='recovery' and not(ancestor::beforeeverycase | ancestor::aftereverycase)]">
			<xsl:call-template name="AllTestsCases" />
		</xsl:if>
	</xsl:template>
	<xsl:template
			match="testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite )]"
			mode="allPopupWarningCases">
		<xsl:if test="current()//step[@warningReason='popup' and not(ancestor::beforeeverycase | ancestor::aftereverycase)]">
			<xsl:call-template name="AllTestsCases" />
		</xsl:if>
	</xsl:template>

	<xsl:template
			match="testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite )]"
			mode="allDoNotFailWarningCases">
		<xsl:if test="current()//step[@warningReason='donotfailflag' and not(ancestor::beforeeverycase | ancestor::aftereverycase)]">
			<xsl:call-template name="AllTestsCases" />
		</xsl:if>
	</xsl:template>

	<xsl:template
			match="testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite )]"
			mode="allIgnoreOperationWarningCases">
		<xsl:if test="current()//step[@warningReason='ignoreoperationkeyword' and not(ancestor::beforeeverycase | ancestor::aftereverycase)]">
			<xsl:call-template name="AllTestsCases" />
		</xsl:if>
	</xsl:template>

	<xsl:template name="generate-misc-testsuites.html">

		<!-- 	<xsl:param name="extra.time.suite.count" select="dyn:evaluate($countOfTimeWarningTestSuites)"/> -->
		<!-- 	<xsl:param name="extra.time.suite.pass.count" select="dyn:evaluate($countOfPassedTimeWarningTestSuites)"/> -->
		<!-- 	<xsl:param name="extra.time.suite.fail.count" select="dyn:evaluate($countOfFailedTimeWarningTestSuites)"/> -->
		<!-- 	<xsl:param name="extra.time.suite.total.time" select="dyn:evaluate($totalTimeOfTimeWarningTestsuites)"/> -->
		<xsl:param name="alert.suite.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='alert')])"/>
		<xsl:param name="alert.suite.pass.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='alert') ])"/>
		<xsl:param name="alert.suite.fail.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='alert') ])"/>
		<xsl:param name="alert.suite.total.time" select="sum(current()//testsuite[(testcase/teststep/step/@warningReason='alert') ]/testcase/@timeCount)"/>
		<xsl:param name="popup.suite.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='popup') ])"/>
		<xsl:param name="popup.suite.pass.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='popup')])"/>
		<xsl:param name="popup.suite.fail.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='popup')])"/>
		<xsl:param name="popup.suite.total.time" select="sum(current()//testsuite[(testcase/teststep/step/@warningReason='popup') ]/testcase/@timeCount)"/>
		<xsl:param name="retry.suite.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='retry')])"/>
		<xsl:param name="retry.suite.pass.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='retry') and @status='pass' ])"/>
		<xsl:param name="retry.suite.fail.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='retry') and @status='fail' ])"/>
		<xsl:param name="retry.suite.total.time" select="sum(current()//testsuite[testcase/teststep/step/@warningReason='retry']/testcase//@timeCount)"/>
		<xsl:param name="recovery.suite.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='recovery')])"/>
		<xsl:param name="recovery.suite.pass.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='recovery') and @status='pass' ])"/>
		<xsl:param name="recovery.suite.fail.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='recovery') and @status='fail' ])"/>
		<xsl:param name="recovery.suite.total.time" select="sum(current()//testsuite[(testcase/teststep/step/@warningReason='recovery') ]/testcase/@timeCount)"/>
		<xsl:param name="donotfail.suite.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='donotfailflag')])"/>
		<xsl:param name="donotfail.suite.pass.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='donotfailflag') and @status='pass' ])"/>
		<xsl:param name="donotfail.suite.fail.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='donotfailflag') and @status='fail' ])"/>
		<xsl:param name="donotfail.suite.total.time" select="sum(current()//testsuite[(testcase/teststep/step/@warningReason='donotfailflag') ]/testcase/@timeCount)"/>
		<xsl:param name="ignoreoperationkeyword.suite.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='ignoreoperationkeyword')])"/>
		<xsl:param name="ignoreoperationkeyword.suite.pass.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='ignoreoperationkeyword') and @status='pass' ])"/>
		<xsl:param name="ignoreoperationkeyword.suite.fail.count" select="count(current()//testsuite[(testcase/teststep/step/@warningReason='ignoreoperationkeyword') and @status='fail' ])"/>
		<xsl:param name="ignoreoperationkeyword.suite.total.time" select="sum(current()//testsuite[(testcase/teststep/step/@warningReason='ignoreoperationkeyword') ]/testcase/@timeCount)"/>
		<redirect:write file="misc-testsuites.html">

			<html>
				<head>
					<title>Full SAT Report</title>
					<link rel="stylesheet" type="text/css" href="reportStyle.css" />
					<link rel="stylesheet" type="text/css" href="./lib/bootstrap.min.css" />
					<link rel="stylesheet" type="text/css" href="./lib/alfReport.css" />
				</head>
				<body>
					<xsl:call-template name="logo">
						<xsl:with-param name="backdir" select="'./'" />
					</xsl:call-template>
					<xsl:call-template name="set.heading">
						<xsl:with-param name="heading"
										select="'TestSuites With Warnings'" />
					</xsl:call-template>
					<table width="100%" class="alfTable table table-hover">
						<thead class="trhead">
							<th align="left"> Types</th>
							<!-- If there are more than one levels then add conditions to differentiate -->
							<th align="left"> Number Of Testcases</th>
							<th align="left"> Total Passed  </th>
							<th align="left"> Total Failed  </th>
							<th align="left"> Total TimeTaken </th>
						</thead>
						<!-- 				<tr> -->
						<!-- 								<td> -->
						<!-- 						<xsl:call-template name="createAllMiscSuites"> -->
						<!-- 							<xsl:with-param name="status" select="'Time'" /> -->
						<!-- 						</xsl:call-template> -->
						<!-- 						<a> -->
						<!-- 							<xsl:attribute name="href">./Time-warning-suites.html</xsl:attribute> -->
						<!-- 							<xsl:attribute name="target">rightFrame</xsl:attribute> -->
						<!-- 							TestSuites which took more time compared to previous build -->
						<!-- 						</a> -->
						<!-- 					</td> -->
						<!-- 					<td> -->
						<!-- 						<xsl:value-of select="$extra.time.suite.count"/> -->
						<!-- 					</td> -->
						<!-- 					<td> -->
						<!-- 						<xsl:value-of select="$extra.time.suite.pass.count"/> -->
						<!-- 					</td> -->
						<!-- 					<td> -->
						<!-- 						<xsl:value-of select="$extra.time.suite.fail.count"/> -->
						<!-- 					</td> -->
						<!-- 					<td> -->
						<!-- 					<xsl:call-template name="SetTime"> -->
						<!-- 						<xsl:with-param name="time" select="$extra.time.suite.total.time"> -->
						<!-- 						</xsl:with-param> -->
						<!-- 						</xsl:call-template> -->
						<!-- 					</td> -->
						<!-- 					</tr> -->
						<tr>
							<td>
								<xsl:call-template name="createAllMiscSuites">
									<xsl:with-param name="status" select="'Alert'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./alert-warning-suites.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestSuites which contains TestStep where Alerts are handled
								</a>
							</td>
							<td>
								<xsl:value-of select="$alert.suite.count"/>
							</td>
							<td>
								<xsl:value-of select="$alert.suite.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$alert.suite.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$alert.suite.total.time">
									</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="createAllMiscSuites">
									<xsl:with-param name="status" select="'Popup'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./Popup-warning-suites.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestSuites which contains TestStep where Unexpected Pop-ups are handled
								</a>
							</td>
							<td>
								<xsl:value-of select="$popup.suite.count"/>
							</td>
							<td>
								<xsl:value-of select="$popup.suite.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$popup.suite.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$popup.suite.total.time">
									</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="createAllMiscSuites">
									<xsl:with-param name="status" select="'Retry'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./Retry-warning-suites.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestSuites which contains TestStep were Retry mechanism was triggered
								</a>
							</td>
							<td>
								<xsl:value-of select="$retry.suite.count"/>
							</td>
							<td>
								<xsl:value-of select="$retry.suite.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$retry.suite.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$retry.suite.total.time">
									</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="createAllMiscSuites">
									<xsl:with-param name="status" select="'Recovery'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./Recovery-warning-suites.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestSuites which contians TestStep were Recovery mechanism was triggered
								</a>
							</td>
							<td>
								<xsl:value-of select="$recovery.suite.count"/>
							</td>
							<td>
								<xsl:value-of select="$recovery.suite.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$recovery.suite.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$recovery.suite.total.time"/>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="createAllMiscSuites">
									<xsl:with-param name="status" select="'Donotfail'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./Donotfail-warning-suites.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestSuites which contains Teststep were failure was suppressed due to DoNotFailOnError flag
								</a>
							</td>
							<td>
								<xsl:value-of select="$donotfail.suite.count"/>
							</td>
							<td>
								<xsl:value-of select="$donotfail.suite.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$donotfail.suite.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$donotfail.suite.total.time"/>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="createAllMiscSuites">
									<xsl:with-param name="status" select="'ignoreOperation'" />
								</xsl:call-template>
								<a>
									<xsl:attribute name="href">./ignoreOperation-warning-suites.html</xsl:attribute>
									<xsl:attribute name="target">rightFrame</xsl:attribute>
									TestSuites which contains Teststep were CNL Steps are skipped
								</a>
							</td>
							<td>
								<xsl:value-of select="$ignoreoperationkeyword.suite.count"/>
							</td>
							<td>
								<xsl:value-of select="$ignoreoperationkeyword.suite.pass.count"/>
							</td>
							<td>
								<xsl:value-of select="$ignoreoperationkeyword.suite.fail.count"/>
							</td>
							<td>
								<xsl:call-template name="SetTime">
									<xsl:with-param name="time" select="$ignoreoperationkeyword.suite.total.time"/>
								</xsl:call-template>
							</td>
						</tr>
					</table>
				</body>
			</html>
		</redirect:write>
	</xsl:template>

	<xsl:template name="createAllMiscSuites">
		<xsl:param name="status" />
		<xsl:variable name="filename">./<xsl:value-of select="$status"/>-warning-suites.html</xsl:variable>

		<redirect:write file="{$filename}">
			<html>
				<head>
					<title>Full SAT Report</title>
					<link rel="stylesheet" type="text/css" href="reportStyle.css" />
					<link rel="stylesheet" type="text/css" href="./lib/bootstrap.min.css" />
					<link rel="stylesheet" type="text/css" href="./lib/alfReport.css" />
				</head>
				<body>
					<xsl:call-template name="logo">
						<xsl:with-param name="backdir" select="'./'" />
					</xsl:call-template>
					<xsl:call-template name="set.heading">
						<xsl:with-param name="heading"
										select="concat('TestSuites With ',$status,' warnings')" />
					</xsl:call-template>
					<table width="100%" class="alfTable table table-hover">
						<thead class="trhead">
							<th align="left"> Name  </th>
							<!-- If there are more than one levels then add conditions to differentiate -->
							<th align="left"> Parent Name  </th>
							<th align="left"> Total TestCases  </th>
							<th align="left"> Success  </th>
							<th align="left"> Failures </th>
							<th align="left"> Skipped </th>
							<th align="left"> Status </th>
							<th align="left"> Time </th>
							<!-- 									<th align="left" width="10%" title="Difference in execution time from the average execution time of this asset on the same machine">Mean Time Difference</th> -->
							<th align="left"> Remarks </th>
						</thead>
						<!-- 								<xsl:if test="$status='Time'"> -->
						<!-- 									<xsl:apply-templates select="*" mode="allTimeWarningSuites"> -->
						<!-- 									</xsl:apply-templates> -->
						<!-- 									</xsl:if> -->
						<xsl:if test="$status='Alert'">
							<xsl:apply-templates select="*" mode="allAlertWarningSuites">
							</xsl:apply-templates>
						</xsl:if>
						<xsl:if test="$status='Popup'">
							<xsl:apply-templates select="*" mode="allPopupWarningSsuites">
							</xsl:apply-templates>
						</xsl:if>
						<xsl:if test="$status='Retry'">
							<xsl:apply-templates select="*" mode="allRetryWarningSuites">
							</xsl:apply-templates>
						</xsl:if>
						<xsl:if test="$status='Recovery'">
							<xsl:apply-templates select="*" mode="allRecoveryWarningSuites">
							</xsl:apply-templates>
						</xsl:if>
						<xsl:if test="$status='Donotfail'">
							<xsl:apply-templates select="*" mode="allDoNotFailOnErrorWarningSuites">
							</xsl:apply-templates>
						</xsl:if>
						<xsl:if test="$status='ignoreOperation'">
							<xsl:apply-templates select="*" mode="allIgnoreOperationWarningSuites">
							</xsl:apply-templates>
						</xsl:if>

					</table>
					<xsl:copy-of select="$copyright" />
				</body>
			</html>
		</redirect:write>
	</xsl:template>

	<!-- <xsl:template -->
	<!-- 		match="testsuite" -->
	<!-- 		mode="allTimeWarningSuites"> -->

	<!-- 		<xsl:if test="dyn:evaluate($checkWhetherCurrentTestSuiteTookMoreTime)"> -->
	<!-- 			<xsl:call-template name="AllTestSuites" /> -->
	<!-- 		</xsl:if> -->
	<!-- 		<xsl:apply-templates select="testsuite" mode="allTimeWarningSuites"> -->
	<!-- 		</xsl:apply-templates> -->
	<!-- 	</xsl:template> -->

	<xsl:template
			match="testsuite"
			mode="allAlertWarningSuites">
		<xsl:if test="current()//step[@warningReason='alert' and not(ancestor::beforeeverycase | ancestor::aftereverycase|ancestor::beforecase | ancestor::aftercase| ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]">
			<xsl:call-template name="AllTestSuites" />
		</xsl:if>
		<xsl:apply-templates select="testsuite" mode="allAlertWarningSuites"></xsl:apply-templates>
	</xsl:template>

	<xsl:template
			match="testsuite[testcase]"
			mode="allRetryWarningSuites">
		<xsl:if test="current()//step[@warningReason='retry' and not(ancestor::beforeeverycase | ancestor::aftereverycase|ancestor::beforecase | ancestor::aftercase| ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]">
			<xsl:call-template name="AllTestSuites" />
		</xsl:if>
		<xsl:apply-templates select="testsuite" mode="allRetryWarningSuites"></xsl:apply-templates>
	</xsl:template>


	<xsl:template
			match="testsuite[testcase]"
			mode="allRecoveryWarningSuites">
		<xsl:if test="current()//step[@warningReason='recovery' and not(ancestor::beforeeverycase | ancestor::aftereverycase|ancestor::beforecase | ancestor::aftercase| ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]">
			<xsl:call-template name="AllTestSuites" />
		</xsl:if>
		<xsl:apply-templates select="testsuite" mode="allRecoveryWarningSuites"></xsl:apply-templates>
	</xsl:template>
	<xsl:template
			match="testsuite[testcase]"
			mode="allPopupWarningSsuites">
		<xsl:if test="current()//step[@warningReason='popup' and not(ancestor::beforeeverycase | ancestor::aftereverycase|ancestor::beforecase | ancestor::aftercase| ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]">
			<xsl:call-template name="AllTestSuites" />
		</xsl:if>
		<xsl:apply-templates select="testsuite" mode="allPopupWarningSsuites"></xsl:apply-templates>
	</xsl:template>
	<xsl:template
			match="testsuite[testcase]"
			mode="allDoNotFailOnErrorWarningSuites">
		<xsl:if test="current()//step[@warningReason='donotfailflag' and not(ancestor::beforeeverycase | ancestor::aftereverycase|ancestor::beforecase | ancestor::aftercase| ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]">
			<xsl:call-template name="AllTestSuites" />
		</xsl:if>
		<xsl:apply-templates select="testsuite" mode="allDoNotFailOnErrorWarningSuites"></xsl:apply-templates>
	</xsl:template>

	<xsl:template
			match="testsuite[testcase]"
			mode="allIgnoreOperationWarningSuites">
		<xsl:if test="current()//step[@warningReason='ignoreoperationkeyword' and not(ancestor::beforeeverycase | ancestor::aftereverycase|ancestor::beforecase | ancestor::aftercase| ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]">
			<xsl:call-template name="AllTestSuites" />
		</xsl:if>
		<xsl:apply-templates select="testsuite" mode="allIgnoreOperationWarningSuites"></xsl:apply-templates>
	</xsl:template>

	<xsl:template name="displayprogressbar">
		<xsl:param name="totalCount"/>
		<xsl:param name="passedCount"/>
		<xsl:param name="failedCount"/>
		<xsl:param name="skippedCount"/>

		<xsl:variable name="successRate" select="($totalCount - $failedCount - $skippedCount) div $totalCount"/>
		<xsl:variable name="failureRate" select="($totalCount - $passedCount - $skippedCount) div $totalCount"/>
		<xsl:variable name="skippedRate" select="($totalCount - $passedCount - $failedCount) div $totalCount"/>
		<xsl:variable name="successPercentageNumber" select="$successRate * 100"></xsl:variable>
		<xsl:variable name="failedPercentageNumber" select="$failureRate* 100"></xsl:variable>
		<xsl:variable name="skippedPercentageNumber" select="$skippedRate * 100"></xsl:variable>

		<xsl:variable name="successPercentage" select="format-number($successRate,'0.00%')"/>
		<xsl:variable name="failurePercentage" select="format-number($failureRate,'0.00%')"/>
		<xsl:variable name="skippedPercentage" select="format-number($skippedRate,'0.00%')"/>

		<div class="alfProgress progress">
			<div>
				<xsl:attribute name="class">progress-bar success-progress-bar active</xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="$successPercentage"/> TestCases Passed</xsl:attribute>
				<xsl:attribute name="style">width:<xsl:value-of select="$successPercentage"/></xsl:attribute>
				<xsl:if test="$successPercentageNumber > 20">
					<xsl:value-of select="$successPercentage"/>
				</xsl:if>
				<span class="sr-only"><xsl:value-of select="$successPercentage"/> Complete (success)</span>
			</div>
			<div>
				<xsl:attribute name="class">progress-bar skipped-progress-bar active</xsl:attribute>

				<xsl:attribute name="title"><xsl:value-of select="$skippedPercentage"/> TestCases Skipped</xsl:attribute>
				<xsl:attribute name="style">width:<xsl:value-of select="$skippedPercentage"/></xsl:attribute>
				<span class="sr-only"><xsl:value-of select="$skippedCount"/> Complete (warning)</span>
			</div>
			<div>
				<xsl:attribute name="class">progress-bar failure-progress-bar active</xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="$failurePercentage"/> TestCases Failed</xsl:attribute>
				<xsl:attribute name="style">width:<xsl:value-of select="$failurePercentage"/></xsl:attribute>
				<span class="sr-only"><xsl:value-of select="$failurePercentage"/> Complete (failed)</span>
			</div>
		</div>
	</xsl:template>


	<!-- List of all complex Xpaths used-->


	<xsl:variable name="NonFixtureTestCaseXpath">testcase[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]</xsl:variable>
	<xsl:variable name="childTestCaseContainsWarningStep">(<xsl:value-of select="$NonFixtureTestCaseXpath"/>/teststep/step/@result='WARNING')</xsl:variable>

	<xsl:variable name="testsuiteTookMoreThanAverageTime">(sum(current()//<xsl:value-of select="$NonFixtureTestCaseXpath"/>/@timeCount) -  sum(current()//<xsl:value-of select="$NonFixtureTestCaseXpath"/>/@averageTimeTaken))  > 0</xsl:variable>
	<xsl:variable name="doesNotContainChildTestsuiteWhichTookMoreThanAverageTime">not(descendant::testsuite[(sum(current()//<xsl:value-of select="$NonFixtureTestCaseXpath"/>/@timeCount) -  sum(current()//<xsl:value-of select="$NonFixtureTestCaseXpath"/>/@averageTimeTaken))  > 0])</xsl:variable>

	<xsl:variable name="descendentTestCaseTimeisNotZero">(sum(descendant::<xsl:value-of select="$NonFixtureTestCaseXpath"></xsl:value-of>/@timeCount) != 0)</xsl:variable>
	<!-- 	<xsl:variable name="countOfWarningTestSuites">count(current()//testsuite[<xsl:value-of select="$childTestCaseContainsWarningStep"/> or (<xsl:value-of select="$descendentTestCaseTimeisNotZero"/> and <xsl:value-of select="$testsuiteTookMoreThanAverageTime"/>  and <xsl:value-of select="$doesNotContainChildTestsuiteWhichTookMoreThanAverageTime"></xsl:value-of>)])</xsl:variable> -->

	<xsl:variable name="countOfWarningTestSuites">count(current()//testsuite[<xsl:value-of select="$childTestCaseContainsWarningStep"/> and not(descendant::testsuite[<xsl:value-of select="$childTestCaseContainsWarningStep"/>]) ])</xsl:variable>

	<xsl:variable name="countOfTimeWarningTestSuites">count(current()//testsuite[<xsl:value-of select="$descendentTestCaseTimeisNotZero"/> and <xsl:value-of select="$testsuiteTookMoreThanAverageTime"/> and <xsl:value-of select="$doesNotContainChildTestsuiteWhichTookMoreThanAverageTime"></xsl:value-of>])</xsl:variable>

	<xsl:variable name="checkWhetherCurrentTestSuiteTookMoreTime">current()[<xsl:value-of select="$descendentTestCaseTimeisNotZero"/> and <xsl:value-of select="$testsuiteTookMoreThanAverageTime"/> and <xsl:value-of select="$doesNotContainChildTestsuiteWhichTookMoreThanAverageTime"/>]	</xsl:variable>

	<xsl:variable name="countOfPassedTimeWarningTestSuites">count(current()//testsuite[<xsl:value-of select="$descendentTestCaseTimeisNotZero"/> and <xsl:value-of select="$testsuiteTookMoreThanAverageTime"/> and <xsl:value-of select="$doesNotContainChildTestsuiteWhichTookMoreThanAverageTime"></xsl:value-of> and @status="pass"])</xsl:variable>


	<xsl:variable name="countOfFailedTimeWarningTestSuites">count(current()//testsuite[<xsl:value-of select="$descendentTestCaseTimeisNotZero"/> and <xsl:value-of select="$testsuiteTookMoreThanAverageTime"/> and <xsl:value-of select="$doesNotContainChildTestsuiteWhichTookMoreThanAverageTime"></xsl:value-of> and @status="fail"])</xsl:variable>


	<xsl:variable name="totalTimeOfTimeWarningTestsuites" >sum(current()//testsuite[<xsl:value-of select="$testsuiteTookMoreThanAverageTime"/> and <xsl:value-of select="$testsuiteTookMoreThanAverageTime"/>  and <xsl:value-of select="$doesNotContainChildTestsuiteWhichTookMoreThanAverageTime"/>]//../testcase/@timeCount)</xsl:variable>



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
		background-color:#4e4d4d !important;
		}
		.passedcount{
		font:normal 85%
		verdana,arial,helvetica;
		font-size:85%;
		font-weight: bold;
		background-color:#5cb85c !important;
		}
		.failedcount{
		font:normal 85%
		verdana,arial,helvetica;
		font-size:85%;
		font-weight: bold;
		background-color:#d9534f !important;
		}
		.skippedcount{
		font:normal 85%
		verdana,arial,helvetica;
		font-size:85%;
		font-weight:
		bold;
		background-color:#f0ad4e !important;
		}
		.disabledcount{
		font:normal 85%
		verdana,arial,helvetica;
		font-size:85%;
		font-weight:
		bold;
		color:black !important;
		background-color:#a39797 !important;
		}
		.excludedcount{
		background-color:#dcd5d5 !important;
		color:#555 !important;
		}
		.warningcount{
		background-color:#f1cf9b !important;
		color:#bd6906 !important;
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
		verdana,arial,helvetical;
		}
		table.details21 tr th{
		font-weight: bold;
		font:size:85%;
		text-align:left;
		background:#9ac4f1;
		}
		table.details22 tr th{
		font-weight: bold;
		font:size:85%;
		text-align:left;
		background:#d4e9ff;
		}
		table.details21 tr td{
		background:#eeeee0;
		font:normal 75% verdana,arial,helvetica;
		color:black;
		}
		table.details22 tr td{
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
		.PASS{
		background:white;
		}
		.FAIL{
		background:red;
		color:black;
		}
		.WARNING td{
		background:yellow !important;
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
		.sbreadcrump{
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
		}.summarylist{
		font-size=small;
		}
	</xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:redirect="http://xml.apache.org/xalan/redirect"
	xmlns:stringutils="xalan://org.apache.tools.ant.util.StringUtils"
	extension-element-prefixes="redirect dyn" xmlns:dyn="http://exslt.org/dynamic">

	<xsl:output method="html" indent="yes" encoding="US-ASCII" />
	<xsl:template match="/">

		<!-- Create index.html -->
		<html>
			<head>
				<style>
					a{
					text-decoration:none
					}
					table tr
					th {
					font:normal 115%
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
					table.details tr th{
					margin-left: auto;
					margin-right: auto;
					font-weight: bold;
					font:size:85%;
					text-align:left;
					background:#9ac4f1;
					}
					.lineOverFlow{
					white-space: nowrap;
					font-size:140%;
					}.totalcount{
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
					color:green !important;
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
					font-weight: bold;
					color:gray !important;
					}
					.blank_row
					{
					height: 20px !important; /* overwrites any other rules */
					background-color: #FFFFFF;
					}
				</style>
				<title>ALF Report</title>
			</head>
			<xsl:apply-templates select="*" mode="main" />
		</html>
	</xsl:template>

	<xsl:template name="Summary.html">

		<xsl:apply-templates select="*" mode="main" />
	</xsl:template>

	<xsl:template match="reports" mode="main">
		<tr>
			<th>
				<h2 align="center">ALF Execution Report</h2>
			</th>
		</tr>
		<tr>
			<br />
			<br />
			<td>
				<br />
				<br />
				<br />
				<table class="details">
					<tr>
						<th align="left" width="10%">Names </th>
						<th align="left" width="10%">Total TestCases </th>
						<th align="left" width="10%">Success </th>
						<th align="left" width="10%">Failures </th>
						<th align="left" width="10%">Skipped </th>
						<th align="left" width="10%">Success rate </th>
						<th align="left" width="10%">Time </th>
					</tr>
					<xsl:apply-templates select="file" mode="fileListing" />
					<tr class="blank_row"></tr>
					<xsl:call-template name="getSummary"></xsl:call-template>
				</table>
			</td>
		</tr>
	</xsl:template>


	<xsl:template name="getSummary">
		<xsl:variable name="total.cases">
			<xsl:value-of
				select="sum(document(file/@path)//count[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforecase| ancestor::beforeeverycase| ancestor::aftercase| ancestor::aftereverycase)]/@total)" />
		</xsl:variable>
		<xsl:variable name="total.passed.cases">
			<xsl:value-of
				select="sum(document(file/@path)//count[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforecase| ancestor::beforeeverycase| ancestor::aftercase| ancestor::aftereverycase)]/@pass)" />
		</xsl:variable>
		<xsl:variable name="total.skipped.cases">
			<xsl:value-of
				select="sum(document(file/@path)//count[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite | ancestor::beforecase| ancestor::beforeeverycase| ancestor::aftercase| ancestor::aftereverycase)]/@skipped)" />
		</xsl:variable>
		<xsl:variable name="total.failed.cases"
			select="$total.cases - $total.passed.cases - $total.skipped.cases" />
		<xsl:variable name="successRate"
			select="($total.cases - $total.failed.cases - $total.skipped.cases) div $total.cases" />
		<xsl:variable name="total.time.taken">
			<xsl:value-of
				select="sum(document(file/@path)/project/testsuite/@timeCount)" />
		</xsl:variable>

		<tr class="lineoverflow" >
			<td> Total</td>
			<td style="font-weight:bold;">
				<xsl:value-of select="$total.cases"></xsl:value-of>
			</td>
			<td style="font-weight:bold;">
				<xsl:value-of select="$total.passed.cases"></xsl:value-of>
			</td>
			<td style="font-weight:bold;">
				<xsl:value-of select="$total.failed.cases"></xsl:value-of>
			</td>
			<td style="font-weight:bold;">
				<xsl:value-of select="$total.skipped.cases"></xsl:value-of>
			</td>
			<td style="font-weight:bold;">
				<xsl:value-of select="format-number($successRate,'0.00%')" />
			</td>
			<td style="font-weight:bold;">  
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="file" mode="fileListing">
		<xsl:variable name="name" select="@name" />
		<xsl:variable name="allResults" select="document(@path)//count" />

		<xsl:variable name="totalCase">
			<xsl:value-of
				select="sum($allResults[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@total)" />
		</xsl:variable>
		<xsl:variable name="passedCase">
			<xsl:value-of
				select="sum($allResults[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@pass)" />
		</xsl:variable>
		<xsl:variable name="skippedCase">
			<xsl:value-of
				select="sum($allResults[not(ancestor::beforesuite | ancestor::aftersuite | ancestor::beforeeverysuite | ancestor::aftereverysuite)]/@skipped)" />
		</xsl:variable>
		<xsl:variable name="failedCase"
			select="$totalCase - $passedCase - $skippedCase" />
		<xsl:variable name="successRate"
			select="($totalCase - $failedCase - $skippedCase) div $totalCase" />

		<xsl:variable name="total.time.taken">
			<xsl:value-of select="sum(document(@path)/project/testsuite/@timeCount)" />
		</xsl:variable>
		<tr class="lineoverflow">
			<td>
				<a>
					<xsl:attribute name="href"><xsl:value-of select="$name" />/index.html</xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>
					<xsl:attribute name="title">
										<xsl:value-of select="$name" />
									</xsl:attribute>
					<xsl:value-of select="$name" />
				</a>
			</td>
			<td>
				<span class="totalcount">
					<xsl:value-of select="$totalCase" />
				</span>
			</td>

			<td>
				<span class="passedcount">
					<xsl:value-of select="$passedCase" />
				</span>
			</td>
			<td>
				<span class="failedcount">
					<xsl:value-of select="$failedCase" />
				</span>
			</td>
			<td>
				<span class="skippedcount">
					<xsl:value-of select="$skippedCase" />
				</span>
			</td>
			<td color="green">
				<xsl:value-of select="format-number($successRate,'0.00%')" />
			</td>
			<td>
				<xsl:call-template name="SetTime">
					<xsl:with-param name="time" select="$total.time.taken" />
				</xsl:call-template>
			</td>
		</tr>
	</xsl:template>


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
</xsl:stylesheet>
	
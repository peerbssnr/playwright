<xsl:stylesheet version="1.0"
	xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:url="uri:find-url.org">

<!-- ////////////  Match the document node, HTML, head, scripts  ////////////// -->
<xsl:variable name="xmlpath" select="url:findURL(.)" />
<msxsl:script language="JScript" implements-prefix="url">
	<![CDATA[ 
	     function findURL(nodelist) {      
	       return nodelist.nextNode().url;      
	     }     
	]]>
</msxsl:script>

<xsl:template match = "/">

<html >
	<head>
    	<title Localizable_1="True"><xsl:value-of select="Report/General/@productName"/> Report</title>
    	<link rel="stylesheet" type="text/css" href="../../../resources/PResults.css" />
   </head>
   <body bgcolor="#ffffff" leftmargin="0" marginwidth="20" topmargin="10" marginheight="10" vlink="#9966cc" >
      	<center>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="hl_qt">
				<div align="center"><span class="hl_qt" Localizable_1="True">ALF <xsl:value-of select="Report/General/@productName"/> Report</span></div>
			</td>
		</tr>
		<tr>
			<td class="hl0">
				<xsl:choose>
					<xsl:when test="Report/BPT">
						<p><span class="hl0_name" Localizable="True">Business Process Test:</span> <span class="hl0"><xsl:value-of select="Report/BPT/DName"/></span></p>
					</xsl:when>
					<xsl:when test="Report/Doc[@type='BC']">
						<p><span class="hl0_name" Localizable="True">Business Component:</span> <span class="hl0"><xsl:value-of select="Report/Doc/DName"/></span></p>
					</xsl:when>
					<xsl:otherwise>
						<p><span class="hl0_name" Localizable="True">Individual Action Reporting</span></p>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</table>
			<br/>

	<xsl:choose>
		<xsl:when test="Report/BPT">
			<xsl:apply-templates select = "Report/BPT"  />	   
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select = "Report/Doc"  />	   
		</xsl:otherwise>
	</xsl:choose>
	
	</center>		
   </body>
</html>


</xsl:template>





<xsl:template name="Arguments">

	<xsl:if test="Summary/Param[@paramInOut='In']">
		<table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="#666699">
			<tr>
				<td bgcolor="white">
									
					<table border="0" cellpadding="3" cellspacing="0" width="100%">
						<tr>
							<td width="50%" valign="middle" align="center" class="tablehl"><b> <span class="tablehl" Localizable="True">Input Parameters </span> </b></td>
							<td width="50%" valign="middle" align="center" class="tablehl"> <b><span class="tablehl" Localizable="True">Value</span></b> </td>
						</tr>
						
						<tr>
							<td width="50%" height="1" class="bg_darkblue"></td>
							<td width="50%" height="1" class="bg_darkblue"></td>
						</tr>
	
						
						<xsl:for-each select="Summary/Param[@paramInOut='In']">
							<tr>
								<td width="50%" valign="middle" align="center" height="20"><span class="text"><xsl:value-of select="ParamName"/></span></td>
								<td width="50%" valign="middle" align="center" height="20"><span class="text"><xsl:value-of select="ParamVal"/></span></td>
							
								<tr>
									<td width="50%" class="bg_gray_eee" height="1"></td>
									<td width="50%" class="bg_gray_eee" height="1"></td>
								</tr>
							
							</tr>
						</xsl:for-each>
						<tr>
							<td width="50%" class="bg_gray_eee" height="1"></td>
							<td width="50%" class="bg_gray_eee" height="1"></td>
						</tr>
					</table>
				</td>
			</tr>
	<br/><br/>

		</table>
	
	</xsl:if>
	
	<xsl:if test="Summary/Param[@paramInOut='Out']">
		<table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="#666699">
			<tr>
				<td bgcolor="white">
									
					<table border="0" cellpadding="3" cellspacing="0" width="100%">
						<tr>
							<td width="50%" valign="middle" align="center" class="tablehl"><b> <span class="tablehl" Localizable="True">Output Parameters </span> </b></td>
							<td width="50%" valign="middle" align="center" class="tablehl"> <b><span class="tablehl" Localizable="True">Value</span></b> </td>
						</tr>
						
						<tr>
							<td width="50%" height="1" class="bg_darkblue"></td>
							<td width="50%" height="1" class="bg_darkblue"></td>
						</tr>
	
						
						<xsl:for-each select="Summary/Param[@paramInOut='Out']">
							<tr>
								<td width="50%" valign="middle" align="center" height="20"><span class="text"><xsl:value-of select="ParamName"/></span></td>
								<td width="50%" valign="middle" align="center" height="20"><span class="text"><xsl:value-of select="ParamVal"/></span></td>
							
								<tr>
									<td width="50%" class="bg_gray_eee" height="1"></td>
									<td width="50%" class="bg_gray_eee" height="1"></td>
								</tr>
							
							</tr>
						</xsl:for-each>
						<tr>
							<td width="50%" class="bg_gray_eee" height="1"></td>
							<td width="50%" class="bg_gray_eee" height="1"></td>
						</tr>
					</table>
				</td>
			</tr>
	<br/><br/>
		</table>								
	</xsl:if>

</xsl:template>

<!-- ///////////////////////////////////////////////////////////// -->

<xsl:template match = "Obj|Details">
	<xsl:choose>
		<xsl:when test="@plainTxt ='False'">
			<xsl:value-of disable-output-escaping="yes" select="."/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="."/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<!-- //////////////////////////  Step  /////////////////////////////////// -->

<xsl:template match = "Step" >
   <xsl:choose>
	<xsl:when test="Obj != 'DummyDriverStep'">
		<table width="100%" valign="top" >
		<tr><td height="1" class="bg_midblue" /></tr>
		<tr>
			<td height="30">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><span class="hl1name" Localizable="True">Step Name: </span><b><span class="hl1"><xsl:value-of select="NodeArgs/Disp"/></span></b></td>
						<td align="right">
							<span valign="center">
								<xsl:element name="span">
									<xsl:attribute name="class"><xsl:value-of select="NodeArgs/@status"/>High</xsl:attribute>
									Step <xsl:value-of select="NodeArgs/@status"/>
								</xsl:element>
							</span>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td><br/></td></tr>
		<tr>
			<td>
				<table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="#666699">
					<tr>
						<td bgcolor="white">
							<table border="0" cellpadding="3" cellspacing="0" width="100%">
								<tr align="center" border="0">
									<td width="25%" valign="middle" align="center" class="tablehl"><span width="100%" class="tablehl" Localizable="True">Object</span></td>
									<td width="25%" valign="middle" align="center" class="tablehl"><span width="100%" class="tablehl" Localizable="True">Details</span></td>
									<td width="25%" valign="middle" align="center" class="tablehl"><span width="100%" class="tablehl" Localizable="True">Result</span></td>
									<td width="25%" valign="middle" align="center" class="tablehl"><span width="100%" class="tablehl" Localizable="True">Time</span></td>
								</tr>
								<tr>
									<td colspan="4" width="100%" height="1" class="bg_darkblue" />
								</tr>
								<tr border="0">
									<td valign="middle" align="center" height="20">
										<div align="center" width="100%" class="text">
											<xsl:apply-templates select="Obj"/>
										</div>
									</td>
									<td valign="middle" align="center" height="20">
										<div align="center" width="100%" class="text">
											<xsl:apply-templates select="Details"/>
										</div>
									</td>
									<td valign="middle" align="center" height="20">
										<div align="center" width="100%" class="text">
											<xsl:element name="span">
												<xsl:attribute name="class"><xsl:value-of select="NodeArgs/@status"/></xsl:attribute>
												<xsl:value-of select="NodeArgs/@status"/>
											</xsl:element>
										</div>
									</td>									
									<td valign="middle" align="center" height="20">
										<div align="center" width="100%" class="text"><xsl:value-of select="Time"/></div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

	<xsl:call-template name="GreenLine"/>
	<xsl:apply-templates select = "*[@rID]" />
	</xsl:when>
	<xsl:otherwise>
	
    </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<!-- ///////////////////////////////////////////////////////////// -->

<xsl:template match="HtmlStep">
	<center>
	<table border = "1" bordercolor ="#666699" cellspacing="0" cellpadding="0" width="100%" height = "100" valign = "top" >
		<!--xsl:attribute name="id">Step<xsl:value-of select="@rID" /></xsl:attribute-->
		<tr><td>
		<div >
			<xsl:value-of disable-output-escaping="yes" select="HTML"/>	
		</div>
		</td></tr>		
	</table>
	</center>
	
	<xsl:call-template name="GreenLine"/>

	<xsl:apply-templates select = "*[@rID]" />
	
</xsl:template>


<!-- ///////////////////////////////////////////////////////////// -->

<xsl:template match="AIter">


	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr><td class="iteration_head" Localizable="True">Action: <xsl:value-of select="NodeArgs/Disp"/></td></tr>
		<tr>
			<td class="iteration_border" height="40">
				<table width="100%" border="0" cellspacing="2" cellpadding="0">
					<tr>
						<td>
							<div>
								<table border="0" cellpadding="3" cellspacing="0" width="100%">
									<tr><td height="1" class="bg_midblue"></td></tr>
									<tr>
										<td height="30">
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td align="left" valign="top">
														<p><b><span class="hl1" Localizable_2="True">Iteration <xsl:value-of select="@iterID"/> Summary:</span></b></p>
													</td>
												</tr>
												<tr><td height="10"></td>	</tr>
												<tr><td height="2" class="bg_darkblue"></td></tr>
												<tr><td height="20"></td>	</tr>
			
												<tr>
													<td align="left" valign="top">
														<p><b><span class="hl1" Localizable="True">Iteration <xsl:value-of select="NodeArgs/@status"/></span></b></p>
													</td>
												</tr>
												<tr><td height="15"></td>	</tr>
											</table>
											<table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#666699">
												<tr>
													<td bgcolor="white">
														<table border="0" cellpadding="3" cellspacing="0" width="100%">
															<tr>
																<td valign="middle" align="center" class="tablehl"><span class="tablehl" Localizable="True">Object</span></td>
																<td valign="middle" align="center" class="tablehl"><span class="tablehl" Localizable="True">Details</span></td>
																<td valign="middle" align="center" class="tablehl"><span class="tablehl" Localizable="True">Result</span></td>
																<td valign="middle" align="center" class="tablehl"><span class="tablehl" Localizable="True">Time</span></td>
															</tr>
															<tr >
																<td  height="1" class="bg_darkblue"></td>
																<td  height="1" class="bg_darkblue"></td>
																<td  height="1" class="bg_darkblue"></td>
																<td  height="1" class="bg_darkblue"></td>
															</tr>
															<xsl:for-each select="Step|Action" >
																<tr>
																	<td valign="middle" align="center" height="20"><span class="text"><xsl:value-of select="NodeArgs/Disp"/> </span></td>
																	<td  valign="middle" align="center" height="20"><span class="text"><xsl:value-of select="Details"/></span></td>
																	<td  valign="middle" align="center" height="20">
																		<xsl:element name="span">
																			<xsl:attribute name="class"><xsl:value-of select="NodeArgs/@status"/></xsl:attribute>
																			<xsl:value-of select="NodeArgs/@status"/>
																		</xsl:element>
																	</td>
																	<td  valign="middle" align="center" height="20">
																		<span class="text">
																			<xsl:choose>
																				<xsl:when test="Time"><xsl:value-of select="Time"/></xsl:when>
																				<xsl:otherwise><xsl:value-of select="Summary/@sTime"/></xsl:otherwise>
																			</xsl:choose>
																		</span>
																	</td>
																</tr>	
																<tr>
																	<td height="1" class="bg_gray_eee"></td>
																	<td height="1" class="bg_gray_eee"></td>
																	<td height="1" class="bg_gray_eee"></td>
																	<td height="1" class="bg_gray_eee"></td>
																</tr>
															</xsl:for-each>
														</table>
													</td>
												</tr>
											</table>											
										</td>
									</tr>
								</table>						
								
				<xsl:call-template name="GreenLine"/>

				<xsl:apply-templates select = "*[@rID]" />
								
							</div>
						</td>
					</tr>
				</table>
			</td>		
		</tr>
	</table>
</xsl:template>



<!-- ///////////////////////////////////////////////////////////// -->

<xsl:template match="Action">
<xsl:variable name="divider"><xsl:value-of select="preceding-sibling::Step[1]/Details"/></xsl:variable>					
<xsl:variable name="theParam" select="substring-after($xmlpath,'actionid=')" />
	<xsl:choose>
		<xsl:when test = "../@type = 'BC'">
			<xsl:apply-templates select = "*[@rID]" />
		</xsl:when>
		<xsl:when test = "@rID = 'T3'">
				<xsl:call-template name="Action"/>
		</xsl:when>
				<xsl:when test = "@rID = 'T4'">
			<xsl:call-template name="Action"/>
		</xsl:when>
		<xsl:when test = "$divider = $theParam">
			<xsl:call-template name="Action"/>
		</xsl:when>
		<xsl:otherwise>
		</xsl:otherwise>
	</xsl:choose>	
</xsl:template>

<xsl:template name="Action">

	<table border="0" width="100%" cellspacing="0" cellpadding="0">

			<xsl:if test="AName != 'DriverScript' ">			
		<tr><td class="action_head" Localizable="True">Action: <xsl:value-of select="AName"/></td></tr>
		</xsl:if> 
		<tr>
			<td class="action_border" height="40">
				<table width="100%" border="0" cellspacing="2" cellpadding="0">
					<tr>
						<td>
							<div>
								<table border="0" cellpadding="3" cellspacing="0" width="100%">
									<xsl:if test="AName != 'DriverScript' ">
									<tr><td height="1" class="bg_midblue"></td></tr>
									
									<tr>
										<td height="30">
											<p/><span class="hl1name"><xsl:value-of select="AName"/></span>
												<b><span class="hl1" Localizable="True"> Results Summary</span></b>
										</td>
									</tr>
									
									<tr><td height="2" class="bg_darkblue"></td></tr>
									<tr><td height="20"></td>	</tr>
									<tr><td><span class="text" Localizable_bold="True"><b>Action:</b> <xsl:value-of select="AName"/> </span></td></tr>
									<tr>
										<td><span class="text" Localizable_bold="True"><b>Run started: </b> <xsl:value-of select="Summary/@sTime"/></span></td>
									</tr>
									<tr>
										<td><span class="text" Localizable_bold="True"><b>Run ended: </b> <xsl:value-of select="Summary/@eTime"/></span></td>
									</tr>
									<tr><td height="15"></td></tr>
									<tr>
										<td><span class="text" Localizable_bold="True"><b>Result: </b><xsl:value-of select="NodeArgs/@status"/></span></td>
									</tr>
									<tr><td height="15"></td>	</tr>
								</xsl:if> 
								</table>
								<xsl:if test="AName != 'DriverScript' ">
								<table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="#666699">
								
									<tr>
										<td bgcolor="white">
											<table border="0" cellpadding="3" cellspacing="0" width="100%">
												<tr>
													<td width="50%" valign="middle" align="center" class="tablehl"><b> <span class="tablehl" Localizable="True">Status </span> </b></td>
													<td width="50%" valign="middle" align="center" class="tablehl"> <b><span class="tablehl" Localizable="True">Times</span></b> </td>
												</tr>
												<tr>
													<td width="50%" height="1" class="bg_darkblue"></td><td width="50%" height="1" class="bg_darkblue"></td>
												</tr>
												<tr>
													<td width="50%" valign="middle" align="center" height="20"><b><span class="passed" Localizable="True">Passed</span></b></td>
													<td width="50%" valign="middle" align="center" height="20">
														<span class="text"><xsl:value-of select="Summary/@passed"/></span>
													</td>
												</tr>
												<tr>
													<td width="50%" height="1" class="bg_gray_eee"></td>
													<td width="50%" height="1" class="bg_gray_eee"></td>
												</tr>
												<tr>
													<td width="50%" valign="middle" align="center" height="20"><span class="failed" Localizable="True">Failed</span></td>
													<td width="50%" valign="middle" align="center" height="20">
														<span class="text"><xsl:value-of select="Summary/@failed"/></span>
													</td>
												</tr>
												<tr>
													<td width="50%" class="bg_gray_eee" height="1"></td>
													<td width="50%" class="bg_gray_eee" height="1"></td>
												</tr>
												<tr>
													<td width="50%" valign="middle" align="center" height="20"><span class="warning"><span class="text" Localizable_bold="True"><b>Warnings</b></span></span></td>
													<td width="50%" valign="middle" align="center" height="20">
														<span class="text"><xsl:value-of select="Summary/@warnings"/></span>
													</td>
												</tr>
												<tr>
													<td width="50%" class="bg_gray_eee" height="1"></td>
													<td width="50%" class="bg_gray_eee" height="1"></td>
												</tr>
												
											</table>
										</td>
									</tr>
								 
								</table>
								
								<xsl:call-template name="Arguments"/>
								
								<xsl:call-template name="GreenLine"/>
							</xsl:if> 
								
								<xsl:apply-templates select = "*[@rID]" />
								
							</div>
						</td>
					</tr>
				</table>
			</td>		
		</tr>
	</table>
</xsl:template>

<xsl:template match="DT">
	<!--xsl:element name="IFRAME">
		<xsl:attribute name="src"><xsl:value-of select="NodeArgs/BtmPane/Path"/></xsl:attribute>
		<xsl:attribute name="width">100%</xsl:attribute>
		<xsl:attribute name="height">100%</xsl:attribute>
	</xsl:element-->
</xsl:template>

<!-- //////////////////////////// Test Iteration ///////////////////////////////// -->

<xsl:template match="DIter">

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr><td class="iteration_head" Localizable="True">Test Iteration <xsl:value-of select="@iterID"/></td>
		</tr>
		<tr>
			<td class="iteration_border">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td height="1" class="bg_midblue"></td>
								</tr>
								<tr>
									<td height="30">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
													<td align="left" valign="top">
														<p><b><span class="hl1" Localizable_2="True">Test Iteration <xsl:value-of select="@iterID"/> Summary:</span></b></p>
													</td>
											
											</tr>
											<tr><td height="2"><br/>	</td></tr>
						
											<tr><td height="2" class="bg_darkblue"></td></tr>
											<tr><td height="20"><br/>	</td></tr>
														
											<tr>	
													<td align="left" valign="top">
														<p><b><span class="hl1" Localizable="True">Iteration <xsl:value-of select="NodeArgs/@status"/></span></b></p>
													</td>
											</tr>	
											<tr><td height="20"><br/>	</td></tr>
										</table>
									</td>
								</tr>
							</table>
							
							<table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#666699">
								<tr>
									<td bgcolor="white">
										<table border="0" cellpadding="3" cellspacing="0" width="100%">
											<tr>
												<td valign="middle" align="center" class="tablehl"><span class="tablehl" Localizable="True">Object	</span></td>
												<td valign="middle" align="center" class="tablehl"><span class="tablehl" Localizable="True">Details	</span></td>
												<td valign="middle" align="center" class="tablehl"><span class="tablehl" Localizable="True">Result	</span></td>
												<td valign="middle" align="center" class="tablehl"><span class="tablehl" Localizable="True">Time	</span></td>
											</tr>
											<tr >
												<td  height="1" class="bg_darkblue"></td>
												<td  height="1" class="bg_darkblue"></td>
												<td  height="1" class="bg_darkblue"></td>
												<td  height="1" class="bg_darkblue"></td>
											</tr>
											<xsl:for-each select="Step|Action" >
												<tr>
													<td valign="middle" align="center" height="20"><span class="text"><xsl:value-of select="NodeArgs/Disp"/> </span></td>
													<td  valign="middle" align="center" height="20"><span class="text"><xsl:value-of select="Details"/></span></td>
													<td  valign="middle" align="center" height="20">
														<xsl:element name="span">
															<xsl:attribute name="class"><xsl:value-of select="NodeArgs/@status"/></xsl:attribute>
															<xsl:value-of select="NodeArgs/@status"/>
														</xsl:element>
													</td>
													<td  valign="middle" align="center" height="20">
														<span class="text">
															<xsl:choose>
																<xsl:when test="Time"><xsl:value-of select="Time"/></xsl:when>
																<xsl:otherwise><xsl:value-of select="Summary/@sTime"/></xsl:otherwise>
															</xsl:choose>
														</span>
													</td>
												</tr>	
												<tr>
													<td height="1" class="bg_gray_eee"></td>
													<td height="1" class="bg_gray_eee"></td>
													<td height="1" class="bg_gray_eee"></td>
													<td height="1" class="bg_gray_eee"></td>
												</tr>
											</xsl:for-each>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>

				<xsl:call-template name="GreenLine"/>

				<xsl:apply-templates select = "*[@rID]" />

			</td>	
		</tr>	
	</table>	
</xsl:template>


<!-- //////////////////////////// Doc  ///////////////////////////////// -->

<xsl:template match="Doc">
	<xsl:choose>
		<xsl:when test="@type = 'BC'">	
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr><td class="iteration_head" bgcolor="gray" Localizable="True">Business Component <xsl:value-of select="DName"/>
				<xsl:if test="@BCIter">(Iteration <xsl:value-of select="@BCIter"/>) </xsl:if>
				</td></tr>				
				<tr>
					<td class="iteration_border">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								    <xsl:call-template name="Doc"/>
								</td>	
							</tr>	
						</table>	
					</td>
				</tr>
			</table>	
		</xsl:when>
		<xsl:when test="../General[@productName = 'WinRunner']">
			<xsl:choose>
				<xsl:when test="../@ver &lt; '3.0'">
					<xsl:apply-templates select = "*[@rID]" />
				</xsl:when>
				<xsl:otherwise>
						<xsl:call-template name="Doc"/>		
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="Doc"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="Doc">

	<xsl:apply-templates select = "*[@rID]" />
	
</xsl:template>


<!-- //////////////////////////// BPT  ///////////////////////////////// -->

<xsl:template match="BPT">

	<table border="0" cellpadding="3" cellspacing="0" width="100%">
		<tr><td height="1" class="bg_midblue"></td></tr>
		<tr><td height="30"><p/><span class="hl1name"><xsl:value-of select="DName" /></span><b><span class="hl1" Localizable="True"> Results Summary</span></b></td></tr>
		<tr><td height="2" class="bg_darkblue"></td></tr>
		<tr><td height="20"></td></tr>
		<tr><td><span class="text" Localizable_bold="True"><b>Business Process Test: </b> <xsl:value-of select="DName" /> </span></td></tr>
		<tr><td><span class="text" Localizable_bold="True"><b>Results name : </b><xsl:value-of select="Res" /></span></td></tr>
		<tr><td><span class="text" Localizable_bold="True"><b>Time Zone:  </b><xsl:value-of select="//Report/@tmZone" /></span></td></tr>
		<tr><td><span class="text" Localizable_bold="True"><b>Run started: </b> <xsl:value-of select="Doc[position()=1]/Summary/@sTime" /></span></td></tr>
		<tr><td><span class="text" Localizable_bold="True"><b>Run ended: </b> <xsl:value-of select="Doc[position()=last()]/Summary/@eTime" /></span></td></tr>
		<xsl:if test="DVer">
			<tr><td><span class="text" Localizable_bold="True"><b>Test version: </b> <xsl:value-of select="DVer" /></span></td></tr>
		</xsl:if>
		<xsl:if test="TSet">
			<tr><td><span class="text" Localizable_bold="True"><b>Test set: </b> <xsl:value-of select="TSet" /></span></td></tr>
		</xsl:if>
		<xsl:if test="TInst">
			<tr><td><span class="text" Localizable_bold="True"><b>Test instance: </b> <xsl:value-of select="TInst" /></span><br/></td></tr>
		</xsl:if>
		<tr><td height="15"></td></tr>
		<tr>
			<td>
				<span class="text" Localizable_bold="True"><b>Result: </b> 
					<xsl:choose>
						<xsl:when test="Doc/NodeArgs[@status = 'Failed']">Failed</xsl:when>
						<xsl:when test="Doc/NodeArgs[@status = 'Warning']">Warning</xsl:when>
						<xsl:when test="Doc/NodeArgs[@status = 'Passed']">Passed</xsl:when>
						<xsl:otherwise>Done</xsl:otherwise>
					</xsl:choose>
				  </span>
			</td>
		</tr>
		<tr><td height="15"></td></tr>
		<xsl:if test="DIter">
			<tr><td>
				<table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#666699">
					<tr><td bgcolor="white">
						<table border="0" cellpadding="2" cellspacing="0" width="100%">
							<tr>
								<td width="50%" valign="middle" align="center" class="tablehl"> <span class="tablehl" Localizable="True">Iteration # </span> </td>
								<td width="50%" valign="middle" align="center" class="tablehl"> <span class="tablehl" Localizable="True">Results</span> </td>
							</tr>
							<tr>
								<td width="50%" height="1" class="bg_darkblue"></td>
								<td width="50%" height="1" class="bg_darkblue"></td>
							</tr>
							<tr>
								<td width="50%" height="1" class="bg_gray_eee"></td>
								<td width="50%" height="1" class="bg_gray_eee"></td>
							</tr>
							
							<xsl:for-each select="DIter">
								<tr>
									<td width="50%" valign="middle" align="center" height="20">
										<span class="text"><xsl:value-of select="@iterID"/></span>
									</td>
									<td width="50%" valign="middle" align="center" height="20">
										<xsl:element name="span">
											<xsl:attribute name="class"><xsl:value-of select="NodeArgs/@status"/></xsl:attribute>
											<xsl:value-of select="NodeArgs/@status"/>
										</xsl:element>
									</td>
								</tr>
								<tr>
									<td width="50%" height="1" class="bg_gray_eee"></td>
									<td width="50%" height="1" class="bg_gray_eee"></td>
								</tr>
								
							</xsl:for-each>
						</table>
					</td></tr>
				</table>
			</td></tr>
		</xsl:if>
	</table>
	
	<br/><br/>
	
	<table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="#666699">
		<tr>
			<td bgcolor="white">
				<table border="0" cellpadding="3" cellspacing="0" width="100%">
					<tr>
						<td width="50%" valign="middle" align="center" class="tablehl"><b> <span class="tablehl" Localizable="True">Status </span> </b></td>
						<td width="50%" valign="middle" align="center" class="tablehl"> <b><span class="tablehl" Localizable="True">Times</span></b> </td>
					</tr>
					<tr>
						<td width="50%" height="1" class="bg_darkblue"></td><td width="50%" height="1" class="bg_darkblue"></td>
					</tr>
					<tr>
						<td width="50%" valign="middle" align="center" height="20"><b><span class="passed" Localizable="True">Passed</span></b></td>
						<td width="50%" valign="middle" align="center" height="20">
							<span class="text"><xsl:value-of select="sum(Doc/Summary/@passed)"/></span>
						</td>
					</tr>
					<tr>
						<td width="50%" height="1" class="bg_gray_eee"></td>
						<td width="50%" height="1" class="bg_gray_eee"></td>
					</tr>
					<tr>
						<td width="50%" valign="middle" align="center" height="20"><span class="failed" Localizable="True">Failed</span></td>
						<td width="50%" valign="middle" align="center" height="20">
							<span class="text"><xsl:value-of select="sum(Doc/Summary/@failed)"/></span>
						</td>
					</tr>
					<tr>
						<td width="50%" class="bg_gray_eee" height="1"></td>
						<td width="50%" class="bg_gray_eee" height="1"></td>
					</tr>
					<tr>
						<td width="50%" valign="middle" align="center" height="20"><span class="warning"><span class="text" Localizable_bold="True"><b>Warnings</b></span></span></td>
						<td width="50%" valign="middle" align="center" height="20">
							<span class="text"><xsl:value-of select="sum(Doc/Summary/@warnings)"/></span>
						</td>
					</tr>
					<tr>
						<td width="50%" class="bg_gray_eee" height="1"></td>
						<td width="50%" class="bg_gray_eee" height="1"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
	<xsl:call-template name="GreenLine"/>

	<xsl:apply-templates select = "*[@rID]" />

</xsl:template>




<!-- //////////////////////////// GreenLine ///////////////////////////////// -->

<xsl:template name="GreenLine">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="brake"> </td>
		</tr>
	</table>	
</xsl:template>

</xsl:stylesheet>


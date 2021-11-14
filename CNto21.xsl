<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:marc="http://www.loc.gov/MARC21/slim" version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
				xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<marc:collection xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
				    xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
            <xsl:for-each select="marc:collection/marc:record">					
				<marc:record>
					<xsl:variable name="s005" select="marc:controlfield[@tag='005']"/>	
					<xsl:variable name="s100" select="marc:datafield[@tag='100']"/>	
					<xsl:variable name="s101" select="marc:datafield[@tag='101']"/>						
					<xsl:variable name="s105" select="marc:datafield[@tag='105']"/>
					<xsl:variable name="s115" select="marc:datafield[@tag='115']"/>		
					<xsl:variable name="s126" select="marc:datafield[@tag='126']"/>	
					<xsl:variable name="s200" select="marc:datafield[@tag='200']"/>
					<xsl:variable name="s205" select="marc:datafield[@tag='205']"/>	
					<xsl:variable name="s206" select="marc:datafield[@tag='206']"/>	
					<xsl:variable name="s210" select="marc:datafield[@tag='210']"/>
					<xsl:variable name="s215" select="marc:datafield[@tag='215']"/>
					<xsl:variable name="s225" select="marc:datafield[@tag='225']"/>	
					<xsl:variable name="s300" select="marc:datafield[@tag='300']"/>	
					<xsl:variable name="s302" select="marc:datafield[@tag='302']"/>
					<xsl:variable name="s304" select="marc:datafield[@tag='304']"/>
					<xsl:variable name="s305" select="marc:datafield[@tag='305']"/>
					<xsl:variable name="s307" select="marc:datafield[@tag='307']"/>
					<xsl:variable name="s308" select="marc:datafield[@tag='308']"/>
					<xsl:variable name="s312" select="marc:datafield[@tag='312']"/>
					<xsl:variable name="s314" select="marc:datafield[@tag='314']"/>
					<xsl:variable name="s320" select="marc:datafield[@tag='320']"/>
					<xsl:variable name="s325" select="marc:datafield[@tag='325']"/>
					<xsl:variable name="s327" select="marc:datafield[@tag='327']"/>
					<xsl:variable name="s330" select="marc:datafield[@tag='330']"/>
					<xsl:variable name="s333" select="marc:datafield[@tag='333']"/>
					<xsl:variable name="s337" select="marc:datafield[@tag='337']"/>
					<xsl:variable name="s410" select="marc:datafield[@tag='410']"/>
					<xsl:variable name="s452" select="marc:datafield[@tag='452']"/>		
					<xsl:variable name="s454" select="marc:datafield[@tag='454']"/>
					<xsl:variable name="s461" select="marc:datafield[@tag='461']"/>
					<xsl:variable name="s462" select="marc:datafield[@tag='462']"/>
					<xsl:variable name="s500" select="marc:datafield[@tag='500']"/>
					<xsl:variable name="s510" select="marc:datafield[@tag='510']"/>	
					<xsl:variable name="s512" select="marc:datafield[@tag='512']"/>
					<xsl:variable name="s516" select="marc:datafield[@tag='516']"/>	
					<xsl:variable name="s517" select="marc:datafield[@tag='517']"/>	
					<xsl:variable name="s540" select="marc:datafield[@tag='540']"/>
					<xsl:variable name="s541" select="marc:datafield[@tag='541']"/>
					<xsl:variable name="s600" select="marc:datafield[@tag='600']"/>	
					<xsl:variable name="s601" select="marc:datafield[@tag='601']"/>	
					<xsl:variable name="s605" select="marc:datafield[@tag='605']"/>
					<xsl:variable name="s606" select="marc:datafield[@tag='606']"/>	
					<xsl:variable name="s607" select="marc:datafield[@tag='607']"/>	
					<xsl:variable name="s610" select="marc:datafield[@tag='610']"/>	
					<xsl:variable name="s660" select="marc:datafield[@tag='660']"/>
					<xsl:variable name="s676" select="marc:datafield[@tag='676']"/>
					<xsl:variable name="s680" select="marc:datafield[@tag='680']"/>
					<xsl:variable name="s690" select="marc:datafield[@tag='690']"/>	
					<xsl:variable name="s700" select="marc:datafield[@tag='700']"/>	
					<xsl:variable name="s701" select="marc:datafield[@tag='701']"/>	
					<xsl:variable name="s702" select="marc:datafield[@tag='702']"/>	
					<xsl:variable name="s710" select="marc:datafield[@tag='710']"/>	
					<xsl:variable name="s711" select="marc:datafield[@tag='711']"/>	
					<xsl:variable name="s712" select="marc:datafield[@tag='712']"/>
					<xsl:variable name="s905" select="marc:datafield[@tag='905']"/>						
						<!-- 头标区转换，MARC21中文献类型p没有对应，按照普通图书处理-->
						<marc:leader>
							<xsl:variable name="leader00-05" select="'00000n'"/>
							<xsl:variable name="leader06" select="translate(substring(marc:leader,7,1),'lmb','mot')"/>
							<xsl:variable name="leader08-23" select="' a22000004a 4500'"/>
							<xsl:value-of select="concat($leader00-05, $leader06, substring(marc:leader,8,1), $leader08-23)"/>
						</marc:leader>			
						<!-- 005 文献修改时间 -->
						<marc:controlfield tag="005"><xsl:value-of select="$s005" /></marc:controlfield>
						<!-- 008<=100,101,102,105 暂时仅考虑图书 -->
						<marc:controlfield tag="008">
							<xsl:variable name="dest00-05" select="substring($s005,3,6)"/>
							<xsl:variable name="dest06" select="translate(substring($s100,9,1), 'abcdefghij', 'cdusrqmtpe')"/>
							<xsl:variable name="dest07-14" select="substring($s100,10,8)"/>
							<xsl:variable name="dest15-17"><xsl:call-template name="publishing-code"/></xsl:variable>
							<xsl:variable name="dest18-21" select="translate(substring($s105,1,4), 'noy', ' p ')"/>
							<xsl:variable name="dest22" select="translate(substring($s100,18,1), 'abcdekmu', 'dabcdfe ')"/>
							<xsl:variable name="dest24-27" select="translate(substring($s105,5,4), 'abcdefgijklvnopqrstz', 'bciaderspj ml t nz  ')"/>
							<xsl:variable name="dest28" select="translate(substring($s100,21,1), 'abcdefghy', 'flllmizo ')"/>
							<xsl:variable name="dest29-31" select="substring($s105,9,3)"/>
							<xsl:variable name="dest33" select="translate(substring($s105,12,1), 'abcdefghyz', '1dehijps0m')"/>
							<xsl:variable name="dest34" select="translate(substring($s105,13,1), 'y', ' ')"/>
							<xsl:variable name="dest35-37">
								<xsl:choose>
									<xsl:when test="$s101/marc:subfield[@code='a']">
										<xsl:value-of select="$s101/marc:subfield[@code='a'][1]" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="substring($s100,23,3)" />
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<xsl:value-of select="concat($dest00-05, $dest06, $dest07-14, $dest15-17, $dest18-21, $dest22, ' ', $dest24-27, $dest28, $dest29-31, ' ', $dest33, $dest34, $dest35-37, ' d')"/>
						</marc:controlfield>
						<!-- 020<=010 ISBN -->
						<xsl:for-each select="marc:datafield[@tag='010']">
							<marc:datafield tag="020" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
								<xsl:for-each select="marc:subfield[@code='b']">
									<marc:subfield code="q">
										<xsl:if test="text()='精装'">hardback</xsl:if>
										<xsl:if test="text()='光盘'">disc</xsl:if>
									</marc:subfield>
								</xsl:for-each>
								<xsl:if test="marc:subfield[@code='z']">
									<marc:subfield code="z"><xsl:value-of select="marc:subfield[@code='z']" /></marc:subfield>
								</xsl:if>
							</marc:datafield>					
						</xsl:for-each>	
						<!-- 022<=011 ISSN -->
						<xsl:for-each select="marc:datafield[@tag='011']">
							<marc:datafield tag="022" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
								<xsl:if test="marc:subfield[@code='y']">
									<marc:subfield code="y"><xsl:value-of select="marc:subfield[@code='y']" /></marc:subfield>
								</xsl:if>
								<xsl:if test="marc:subfield[@code='z']">
									<marc:subfield code="z"><xsl:value-of select="marc:subfield[@code='z']" /></marc:subfield>
								</xsl:if>
							</marc:datafield>				
						</xsl:for-each>				
						<!-- 024<=013 ISMN音乐出版物号 -->
						<xsl:for-each select="marc:datafield[@tag='013']">
							<marc:datafield tag="024" ind1="2" ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
								<xsl:if test="marc:subfield[@code='z']">
									<marc:subfield code="z"><xsl:value-of select="marc:subfield[@code='z']" /></marc:subfield>
								</xsl:if>	
							</marc:datafield>
						</xsl:for-each>	
						<!-- 024<=016 ISRC音像编码 -->
						<xsl:for-each select="marc:datafield[@tag='016']">
							<marc:datafield tag="024" ind1="0" ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="translate(marc:subfield[@code='a'],'-','')" /></marc:subfield>
								<xsl:if test="marc:subfield[@code='z']">
									<marc:subfield code="z"><xsl:value-of select="marc:subfield[@code='z']" /></marc:subfield>
								</xsl:if>	
							</marc:datafield>
						</xsl:for-each>
						<!-- 035<=001 系统控制字段 -->
						<xsl:for-each select="marc:controlfield[@tag='001']">
							<marc:datafield tag="035" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="text()" /></marc:subfield>
							</marc:datafield>
						</xsl:for-each>						
						<!-- 041<=101 -->
						<xsl:for-each select="$s101">
							<marc:datafield tag="041">
								<xsl:attribute name="ind1">
									<xsl:choose>
										<xsl:when test="@ind1='0'">0</xsl:when>
										<xsl:otherwise>1</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
								<xsl:attribute name="ind2"><xsl:value-of select="' '" /></xsl:attribute>
								<xsl:for-each select="marc:subfield[@code='a']"><marc:subfield code="a"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
								<xsl:for-each select="marc:subfield[@code='b']"><marc:subfield code="k"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
								<xsl:for-each select="marc:subfield[@code='c']"><marc:subfield code="h"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
								<xsl:for-each select="marc:subfield[@code='d']"><marc:subfield code="b"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
								<xsl:for-each select="marc:subfield[@code='e']"><marc:subfield code="f"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
								<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="e"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
								<xsl:for-each select="marc:subfield[@code='i']"><marc:subfield code="g"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
								<xsl:for-each select="marc:subfield[@code='j']"><marc:subfield code="j"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>								
							</marc:datafield>
						</xsl:for-each>
						<!-- 043<=660 -->
						<xsl:if test="$s660">
							<marc:datafield tag="043" ind1=" " ind2=" ">
								<xsl:for-each select="$s660">
									<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
								</xsl:for-each>
							</marc:datafield>
						</xsl:if>		
						<!-- 050<=680 -->
						<xsl:for-each select="$s680">
							<marc:datafield tag="050" ind1=" " ind2="4">
								<xsl:for-each select="marc:subfield[@code='a']"><marc:subfield code="a"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
								<xsl:for-each select="marc:subfield[@code='b']"><marc:subfield code="b"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
							</marc:datafield>
						</xsl:for-each>
						<!-- 082<=676 -->
						<xsl:for-each select="$s676">
							<marc:datafield tag="082" ind1="0" ind2="4">
								<xsl:for-each select="marc:subfield[@code='a']"><marc:subfield code="a"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
								<xsl:for-each select="marc:subfield[@code='v']"><marc:subfield code="2"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
							</marc:datafield>
						</xsl:for-each>
						<!-- 007<=115录像制品形态特征 -->
<!-- 						<xsl:for-each select="$s115">
							<marc:controlfield tag="007">
								<xsl:variable name="vd01" select="translate(substring($s115/marc:subfield[@code='a'],16,1),'abcdrxz','')"/>
							</marc:controlfield>
						</xsl:for-each> -->
						<!-- 007<=126录音制品形态特征 -->
<!-- 						<xsl:for-each select="$s126">
							<marc:controlfield tag="007">
								<xsl:variable name="vd01" select="translate(substring($s115/marc:subfield[@code='a'],,),'','')"/>
							</marc:controlfield>
						</xsl:for-each>	 -->
						<!-- 098<=690 -->
						<xsl:for-each select="$s690">
							<marc:datafield tag="098" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
								<marc:subfield code="v">5</marc:subfield>
							</marc:datafield>
						</xsl:for-each>
						<!-- 099<=905 -->
						<xsl:for-each select="$s905">
							<marc:datafield tag="099" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='f']" /></marc:subfield>
								<xsl:for-each select="marc:subfield[@code='b']"><marc:subfield code="b"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
							</marc:datafield>
						</xsl:for-each>
						<!-- 130<=500 -->
						<xsl:for-each select="$s500">
							<xsl:if test="marc:subfield[@code='a']">
								<marc:datafield tag="130" ind1="0" ind2=" ">
									<xsl:call-template name="title"/>
									<xsl:for-each select="marc:subfield[@code='m']"><marc:subfield code="l"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
								</marc:datafield>							
							</xsl:if>
						</xsl:for-each>
						<!-- 245<=200 -->
						<xsl:for-each select="$s200">
							<marc:datafield tag="245">
								<xsl:attribute name="ind1">
									<xsl:choose>
										<xsl:when test="$s500">1</xsl:when>
										<xsl:otherwise>0</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
								<xsl:attribute name="ind2"><xsl:value-of select="'0'" /></xsl:attribute>
								<xsl:call-template name="title-author"/>																
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='f']">
										<marc:subfield code="c">
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='g']">
														<xsl:for-each select="marc:subfield[@code='f']"><xsl:value-of select="concat(text(),' ; ')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='g'][position() &lt; last()]">
															<xsl:value-of select="concat(text(),' ; ')" />
														</xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='g'][last()]">
															<xsl:value-of select="text()" />
														</xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:for-each select="marc:subfield[@code='f'][position() &lt; last()]">
															<xsl:value-of select="concat(text(),' ; ')" />
														</xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='f'][last()]">
															<xsl:value-of select="text()" />
														</xsl:for-each>
													</xsl:otherwise>
												</xsl:choose>
										</marc:subfield>
									</xsl:when>
									<xsl:otherwise>
										<xsl:if test="marc:subfield[@code='g']">
											<marc:subfield code="c">
												<xsl:for-each select="marc:subfield[@code='g'][position() &lt; last()]">
													<xsl:value-of select="concat(text(),' ; ')" />
												</xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='g'][last()]">
													<xsl:value-of select="text()" />
												</xsl:for-each>
											</marc:subfield>
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
							</marc:datafield>
						</xsl:for-each>
						<!-- 246 31<=510 -->
						<xsl:for-each select="$s510">
							<marc:datafield tag="246" ind1="3" ind2="1"><xsl:call-template name="title"/></marc:datafield>
						</xsl:for-each>
						<!-- 246<=512 -->
						<xsl:for-each select="$s512">
							<marc:datafield tag="246" ind1="1" ind2=" ">
								<marc:subfield code="i">Cover title:</marc:subfield>
								<xsl:call-template name="title"/>
							</marc:datafield>
						</xsl:for-each>
						<!-- 246<=516 -->
						<xsl:for-each select="$s516">
							<marc:datafield tag="246" ind1="1" ind2=" ">
								<marc:subfield code="i">Spine title:</marc:subfield>
								<xsl:call-template name="title"/>
							</marc:datafield>
						</xsl:for-each>						
						<!-- 246<=517 -->
						<xsl:for-each select="$s517">
							<marc:datafield tag="246" ind1="3" ind2=" "><xsl:call-template name="title"/></marc:datafield>
						</xsl:for-each>						
						<!-- 246<=540 -->
						<xsl:for-each select="$s540">
							<marc:datafield tag="246" ind1="3" ind2=" "><xsl:call-template name="title"/></marc:datafield>
						</xsl:for-each>						
						<!-- 242<=541 -->
						<xsl:for-each select="$s541">
							<marc:datafield tag="242" ind1="1" ind2=" "><xsl:call-template name="title"/></marc:datafield>
						</xsl:for-each>
						<!-- 250<=205 -->
						<xsl:for-each select="$s205">
							<marc:datafield tag="250" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
								<xsl:for-each select="marc:subfield[@code='z']"><marc:subfield code="y"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
							</marc:datafield>
						</xsl:for-each>	
						<!-- 255<=206 -->
						<xsl:for-each select="$s206">
							<marc:datafield tag="255" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
							</marc:datafield>
						</xsl:for-each>
						<!-- 260<=210 -->
						<xsl:for-each select="$s210">
							<marc:datafield tag="260" ind1=" " ind2=" ">
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='a'][2]">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='c'][2]">
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='d'][2]">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'][1], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="marc:subfield[@code='c'][1]" /></marc:subfield>
														<marc:subfield code="c"><xsl:value-of select="concat(marc:subfield[@code='d'][1], ' ;')" /></marc:subfield>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'][2], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="marc:subfield[@code='c'][2]" /></marc:subfield>
														<marc:subfield code="c"><xsl:value-of select="marc:subfield[@code='d'][2]" /></marc:subfield>
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'][1], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='c'][1], ' ;')" /></marc:subfield>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'][2], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="marc:subfield[@code='c'][2]" /></marc:subfield>
														<marc:subfield code="c"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
													</xsl:otherwise>													
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'][1], ' :')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'][2], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:value-of select="marc:subfield[@code='c']" /></marc:subfield>
												<marc:subfield code="c"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='c'][2]">
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'][1], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='c'][1], ',')" /></marc:subfield>
												<marc:subfield code="b"><xsl:value-of select="marc:subfield[@code='c'][2]" /></marc:subfield>
												<marc:subfield code="c"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:value-of select="marc:subfield[@code='c']" /></marc:subfield>
												<marc:subfield code="c"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:otherwise>											
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="g"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
							</marc:datafield>
						</xsl:for-each>
						<!-- 300<=215 -->
						<xsl:for-each select="$s215">
							<marc:datafield tag="300" ind1=" " ind2=" ">
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='c']">
										<xsl:for-each select="marc:subfield[@code='a']"><marc:subfield code="a"><xsl:value-of select="concat(text(),' :')" /></marc:subfield></xsl:for-each>
										<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='c'],' ;')" /></marc:subfield>
										<xsl:for-each select="marc:subfield[@code='d']"><marc:subfield code="c"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
										<xsl:choose>
											<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
												<marc:subfield code="e">
													<xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(),' + ')" /></xsl:for-each>
													<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
												</marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<xsl:for-each select="marc:subfield[@code='e']"><marc:subfield code="e"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
											</xsl:otherwise>
										</xsl:choose>										
									</xsl:when>
									<xsl:otherwise>
										<xsl:for-each select="marc:subfield[@code='a']"><marc:subfield code="a"><xsl:value-of select="concat(text(),' ;')" /></marc:subfield></xsl:for-each>									
										<xsl:for-each select="marc:subfield[@code='d']"><marc:subfield code="c"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
										<xsl:choose>
											<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
												<marc:subfield code="e">
													<xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(),' + ')" /></xsl:for-each>
													<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
												</marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<xsl:for-each select="marc:subfield[@code='e']"><marc:subfield code="e"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</marc:datafield>
						</xsl:for-each>
						<!-- 490<=225 -->
						<xsl:for-each select="$s225[@ind1='1']">
							<marc:datafield tag="490" ind1="0" ind2=" "><xsl:call-template name="serise-490"/></marc:datafield>
						</xsl:for-each>
						<xsl:for-each select="$s225[@ind1='2']">
							<marc:datafield tag="490" ind1="1" ind2=" "><xsl:call-template name="serise-490"/></marc:datafield>
						</xsl:for-each>
						<xsl:for-each select="$s225[@ind1='0']">
							<marc:datafield tag="490" ind1="1" ind2=" "><xsl:call-template name="serise-490"/></marc:datafield>
						</xsl:for-each>
						<!-- 500<=300,304,305,307,308,312,314 -->
						<xsl:for-each select="$s300">
							<marc:datafield tag="500" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
							</marc:datafield>
						</xsl:for-each>
						<xsl:for-each select="$s304">
							<marc:datafield tag="500" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
							</marc:datafield>
						</xsl:for-each>
						<xsl:for-each select="$s305">
							<marc:datafield tag="500" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
							</marc:datafield>
						</xsl:for-each>
						<xsl:for-each select="$s307">
							<marc:datafield tag="500" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
							</marc:datafield>
						</xsl:for-each>
						<xsl:for-each select="$s308">
							<marc:datafield tag="500" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
							</marc:datafield>
						</xsl:for-each>
						<xsl:for-each select="$s312">
							<marc:datafield tag="500" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
							</marc:datafield>
						</xsl:for-each>
						<xsl:for-each select="$s314">
							<marc:datafield tag="500" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
							</marc:datafield>
						</xsl:for-each>
						<!-- 504<=320 -->
						<xsl:for-each select="$s320">
							<marc:datafield tag="504" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
							</marc:datafield>
						</xsl:for-each>
						<!-- 505<=327 -->
						<xsl:for-each select="$s327[@ind1='0']">
							<xsl:choose>
								<xsl:when test="$s327[@ind2='1']">
									<marc:datafield tag="505" ind1="1" ind2="0">
										<xsl:for-each select="marc:subfield[@code='a']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='b']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='c']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='d']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='e']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='f']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='g']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='h']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='i']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>						
									</marc:datafield>
								</xsl:when>
								<xsl:otherwise>
									<marc:datafield tag="505" ind1="1" ind2=" ">
										<marc:subfield code="a">
											<xsl:choose>
												<xsl:when test="count(marc:subfield[@code='a']) &gt; 1">
													<xsl:for-each select="marc:subfield[@code='a'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' -- ')" /></xsl:for-each>
													<xsl:for-each select="marc:subfield[@code='a'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="marc:subfield[@code='a']" />
												</xsl:otherwise>	
											</xsl:choose>
										</marc:subfield>
									</marc:datafield>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
						<xsl:for-each select="$s327[@ind1='1']">
							<xsl:choose>
								<xsl:when test="$s327[@ind2='1']">
									<marc:datafield tag="505" ind1="0" ind2="0">
										<xsl:for-each select="marc:subfield[@code='a']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='b']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='c']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='d']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='e']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='f']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='g']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='h']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='i']">
											<marc:subfield code="t"><xsl:value-of select="concat(text(), ' -- ')" /></marc:subfield>
										</xsl:for-each>										
									</marc:datafield>
								</xsl:when>
								<xsl:otherwise>
									<marc:datafield tag="505" ind1="0" ind2=" ">
										<marc:subfield code="a">
											<xsl:choose>
												<xsl:when test="count(marc:subfield[@code='a']) &gt; 1">
													<xsl:for-each select="marc:subfield[@code='a'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' -- ')" /></xsl:for-each>
													<xsl:for-each select="marc:subfield[@code='a'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="marc:subfield[@code='a']" />
												</xsl:otherwise>	
											</xsl:choose>
										</marc:subfield>									
									</marc:datafield>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>	
						<!-- 520<=330 -->
						<xsl:for-each select="$s330">
							<marc:datafield tag="520" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
							</marc:datafield>
						</xsl:for-each>	
						<!-- 521<=333 -->
						<xsl:for-each select="$s333">
							<marc:datafield tag="521" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
							</marc:datafield>
						</xsl:for-each>							
						<!-- 546<=302 -->
						<xsl:for-each select="$s302">
							<marc:datafield tag="546" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
							</marc:datafield>
						</xsl:for-each>
						<!-- 533<=325 -->
						<xsl:for-each select="$s325">
							<marc:datafield tag="533" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
							</marc:datafield>
						</xsl:for-each>
						<!-- 538<=337 -->
						<xsl:for-each select="$s337">
							<marc:datafield tag="538" ind1=" " ind2=" ">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
							</marc:datafield>
						</xsl:for-each>
						<!-- 600<=600 -->
						<xsl:for-each select="$s600">
							<marc:datafield tag="600"><xsl:call-template name="person"/></marc:datafield>
						</xsl:for-each>
						<!-- 610<=601 0 -->
						<xsl:for-each select="$s601[@ind1='0']">
							<marc:datafield tag="610"><xsl:call-template name="group"/></marc:datafield>
						</xsl:for-each>
						<!-- 611<=601 1 -->
						<xsl:for-each select="$s601[@ind1='1']">
							<marc:datafield tag="611"><xsl:call-template name="meeting"/></marc:datafield>
						</xsl:for-each>						
						<!-- 630<=605 -->
						<xsl:for-each select="$s605">
							<marc:datafield tag="630" ind1="0" ind2="0">
								<xsl:call-template name="title"/>
								<xsl:for-each select="marc:subfield[@code='m']"><marc:subfield code="l"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
							</marc:datafield>
						</xsl:for-each>
						<!-- 650<=606 -->
						<xsl:for-each select="$s606">
							<marc:datafield tag="650" ind1=" " ind2="0">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
								<xsl:for-each select="marc:subfield[@code='x']"><marc:subfield code="x"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
								<xsl:for-each select="marc:subfield[@code='y']"><marc:subfield code="z"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
								<xsl:for-each select="marc:subfield[@code='z']"><marc:subfield code="y"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
								<xsl:for-each select="marc:subfield[@code='j']"><marc:subfield code="v"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
							</marc:datafield>
						</xsl:for-each>
						<!-- 651<=607 -->
						<xsl:for-each select="$s607">
							<marc:datafield tag="651" ind1=" " ind2="0">
								<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
								<xsl:for-each select="marc:subfield[@code='x']"><marc:subfield code="x"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
								<xsl:for-each select="marc:subfield[@code='y']"><marc:subfield code="z"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
								<xsl:for-each select="marc:subfield[@code='z']"><marc:subfield code="y"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
								<xsl:for-each select="marc:subfield[@code='j']"><marc:subfield code="v"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
							</marc:datafield>
						</xsl:for-each>
						<!-- 653<=610 -->
						<xsl:for-each select="$s610">
							<marc:datafield tag="653">
								<xsl:attribute name="ind1"><xsl:value-of select="@ind1" /></xsl:attribute>
								<xsl:attribute name="ind2"><xsl:value-of select="' '" /></xsl:attribute>
								<xsl:for-each select="marc:subfield[@code='a']"><marc:subfield code="a"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
							</marc:datafield>
						</xsl:for-each>
						<!-- 700<=700 -->
						<xsl:for-each select="$s700">
							<marc:datafield tag="700"><xsl:call-template name="person"/></marc:datafield>
						</xsl:for-each>
						<!-- 700<=701 -->
						<xsl:for-each select="$s701">
							<marc:datafield tag="700"><xsl:call-template name="person"/></marc:datafield>
						</xsl:for-each>
						<!-- 700<=702 -->
						<xsl:for-each select="$s702">
							<marc:datafield tag="700"><xsl:call-template name="person"/></marc:datafield>
						</xsl:for-each>
						<!-- 710<=710 -->
						<xsl:for-each select="$s710[@ind1='0']">
							<marc:datafield tag="710"><xsl:call-template name="group"/></marc:datafield>
						</xsl:for-each>
						<!-- 710<=711 -->
						<xsl:for-each select="$s711[@ind1='0']">
							<marc:datafield tag="710"><xsl:call-template name="group"/></marc:datafield>
						</xsl:for-each>
						<!-- 711<=711 -->
						<xsl:for-each select="$s711[@ind1='1']">
							<marc:datafield tag="711"><xsl:call-template name="meeting"/></marc:datafield>
						</xsl:for-each>	
						<!-- 710<=712 -->
						<xsl:for-each select="$s712[@ind1='0']">
							<marc:datafield tag="710"><xsl:call-template name="group"/></marc:datafield>
						</xsl:for-each>
						<!-- 711<=712 -->
						<xsl:for-each select="$s712[@ind1='1']">
							<marc:datafield tag="711"><xsl:call-template name="meeting"/></marc:datafield>
						</xsl:for-each>	
						<!-- 776<=452 -->
						<xsl:for-each select="$s452">
							<marc:datafield tag="776" ind1="0" ind2=" "><xsl:call-template name="link-title"/></marc:datafield>
						</xsl:for-each>
						<!-- 765<=454 -->
						<xsl:for-each select="$s454">
							<marc:datafield tag="765" ind1="0" ind2=" "><xsl:call-template name="link-title"/></marc:datafield>
						</xsl:for-each>	
						<!-- 773<=461 -->
						<xsl:for-each select="$s461">
							<marc:datafield tag="773" ind1="0" ind2=" "><xsl:call-template name="link-title"/></marc:datafield>
						</xsl:for-each>	
						<!-- 774<=462 -->
						<xsl:for-each select="$s462">
							<marc:datafield tag="774" ind1="0" ind2=" "><xsl:call-template name="link-title"/></marc:datafield>
						</xsl:for-each>						
						<!-- 830<=225 2\,410 -->
						<xsl:for-each select="$s225[@ind1='2']"><xsl:call-template name="serise-830"/></xsl:for-each>
						<xsl:for-each select="$s225[@ind1='0']"><xsl:call-template name="serise-830"/></xsl:for-each>
				</marc:record>
			</xsl:for-each>	
		</marc:collection>
	</xsl:template>
	<xsl:template name="publishing-code">
		<xsl:variable name="s102" select="marc:datafield[@tag='102']"/>	
			<xsl:choose>
				<xsl:when test="$s102/marc:subfield[@code='a']='us'">us </xsl:when>
				<xsl:when test="$s102/marc:subfield[@code='a']='KR'">kr </xsl:when>
				<xsl:when test="$s102/marc:subfield[@code='a']='ca'">ca </xsl:when>
				<xsl:when test="$s102/marc:subfield[@code='a']='uk'">uk </xsl:when>	
				<xsl:when test="$s102/marc:subfield[@code='a']='ne'">ne </xsl:when>
				<xsl:when test="$s102/marc:subfield[@code='a']='gw'">gw </xsl:when>
				<xsl:when test="$s102/marc:subfield[@code='a']='fr'">fr </xsl:when>
				<xsl:when test="$s102/marc:subfield[@code='a']='ph'">ph </xsl:when>
				<xsl:when test="$s102/marc:subfield[@code='a']='ru'">ru </xsl:when>
				<xsl:when test="$s102/marc:subfield[@code='a']='RU'">ru </xsl:when>				
				<xsl:when test="$s102/marc:subfield[@code='a']='au'">au </xsl:when>
				<xsl:when test="$s102/marc:subfield[@code='a']='bw'">bw </xsl:when>
				<xsl:when test="$s102/marc:subfield[@code='a']='ii'">ii </xsl:when>	
				<xsl:when test="$s102/marc:subfield[@code='a']='cf'">cf </xsl:when>
				<xsl:when test="$s102/marc:subfield[@code='a']='sz'">sz </xsl:when>
				<xsl:when test="$s102/marc:subfield[@code='a']='si'">si </xsl:when>
				<xsl:when test="$s102/marc:subfield[@code='a']='jp'">jp </xsl:when>	
				<xsl:when test="$s102/marc:subfield[@code='a']='JP'">jp </xsl:when>				
				<xsl:otherwise>cc </xsl:otherwise>
			</xsl:choose>			
	</xsl:template>
	<xsl:template name="title-author">
		<xsl:choose>
			<xsl:when test="marc:subfield[@code='i']">
				<xsl:choose>
					<xsl:when test="marc:subfield[@code='h']">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='d']">
								<xsl:choose>
									<xsl:when test="count(marc:subfield[@code='d']) &gt; 1">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='e']">
												<xsl:choose>
													<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='f']">
																<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:choose>
																	<xsl:when test="marc:subfield[@code='g']">
																		<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:otherwise>
														</xsl:choose>														
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='f']">
																<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:choose>
																	<xsl:when test="marc:subfield[@code='g']">
																		<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each></marc:subfield>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='f']">
														<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='g']">
																<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='e']">
												<xsl:choose>
													<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='f']">
																<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:choose>
																	<xsl:when test="marc:subfield[@code='g']">
																		<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:otherwise>
														</xsl:choose>														
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='f']">
																<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:choose>
																	<xsl:when test="marc:subfield[@code='g']">
																		<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='f']">
														<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='g']">
																<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>		
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='e']">
										<xsl:choose>
											<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='f']">
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='g']">
																<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>												
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='f']">
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='g']">
																<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
										<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='f']">
												<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
											</xsl:when>
											<xsl:otherwise>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='g']">
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>						
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='d']">
								<xsl:choose>
									<xsl:when test="count(marc:subfield[@code='d']) &gt; 1">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='e']">
												<xsl:choose>
													<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='f']">
																<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:choose>
																	<xsl:when test="marc:subfield[@code='g']">
																		<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='f']">
																<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:choose>
																	<xsl:when test="marc:subfield[@code='g']">
																		<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each></marc:subfield>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='f']">
														<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='g']">
																<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='e']">
												<xsl:choose>
													<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='f']">
																<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:choose>
																	<xsl:when test="marc:subfield[@code='g']">
																		<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='f']">
																<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:choose>
																	<xsl:when test="marc:subfield[@code='g']">
																		<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='f']">
														<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='g']">
																<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>		
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='e']">
										<xsl:choose>
											<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='f']">
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='g']">
																<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>												
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='f']">
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='g']">
																<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>	
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
										<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='f']">
												<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
											</xsl:when>
											<xsl:otherwise>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='g']">
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:otherwise>
										</xsl:choose>	
									</xsl:otherwise>
								</xsl:choose>						
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>		
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="marc:subfield[@code='h']">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='d']">
								<xsl:choose>
									<xsl:when test="count(marc:subfield[@code='d']) &gt; 1">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='e']">
												<xsl:choose>
													<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='h'][position() &lt; last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='f']">
																<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:choose>
																	<xsl:when test="marc:subfield[@code='g']">
																		<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:otherwise>
														</xsl:choose>														
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='h'][position() &lt; last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='f']">
																<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:choose>
																	<xsl:when test="marc:subfield[@code='g']">
																		<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:otherwise>
														</xsl:choose>	
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='h'][position() &lt; last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each></marc:subfield>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='f']">
														<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='g']">
																<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>	
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='e']">
												<xsl:choose>
													<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='f']">
																<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:choose>
																	<xsl:when test="marc:subfield[@code='g']">
																		<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:otherwise>
														</xsl:choose>															
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='f']">
																<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:choose>
																	<xsl:when test="marc:subfield[@code='g']">
																		<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:otherwise>
														</xsl:choose>	
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='f']">
														<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='g']">
																<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>	
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>		
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='e']">
										<xsl:choose>
											<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='h'][position() &lt; last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='f']">
														<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='g']">
																<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>												
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='h'][position() &lt; last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='f']">
														<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='g']">
																<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
										<xsl:for-each select="marc:subfield[@code='h'][position() &lt; last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='f']">
												<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
											</xsl:when>
											<xsl:otherwise>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='g']">
														<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(),' /')" /></marc:subfield></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>						
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='d']">
								<xsl:choose>
									<xsl:when test="count(marc:subfield[@code='d']) &gt; 1">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='e']">
												<xsl:choose>
													<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),' = ')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], ' = ')" /></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='f']">
																<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:choose>
																	<xsl:when test="marc:subfield[@code='g']">
																		<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' = ')" /></marc:subfield>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each></marc:subfield>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='f']">
														<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='g']">
																<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='e']">
												<xsl:choose>
													<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),' = ')" /></xsl:for-each>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='f']">
																<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:choose>
																	<xsl:when test="marc:subfield[@code='g']">
																		<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], ' = ')" /></marc:subfield>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='f']">
																<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:choose>
																	<xsl:when test="marc:subfield[@code='g']">
																		<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' =')" /></marc:subfield>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='f']">
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each></marc:subfield>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='g']">
																<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each></marc:subfield>
															</xsl:when>
															<xsl:otherwise>
																<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each></marc:subfield>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>												
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>		
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='e']">
										<xsl:choose>
											<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='f']">
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='g']">
																<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each>
															</xsl:when>
															<xsl:otherwise>
																<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>												
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='f']">
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each></marc:subfield>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="marc:subfield[@code='g']">
																<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each></marc:subfield>
															</xsl:when>
															<xsl:otherwise>
																<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e']"><xsl:value-of select="text()" /></xsl:for-each></marc:subfield>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>													
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='f']">
												<marc:subfield code="a"><xsl:for-each select="marc:subfield[@code='a']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<xsl:choose>
													<xsl:when test="marc:subfield[@code='g']">
														<marc:subfield code="a"><xsl:for-each select="marc:subfield[@code='a']"><xsl:value-of select="concat(text(),' /')" /></xsl:for-each></marc:subfield>
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:for-each select="marc:subfield[@code='a']"><xsl:value-of select="text()" /></xsl:for-each></marc:subfield>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:otherwise>
										</xsl:choose>											
									</xsl:otherwise>
								</xsl:choose>						
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>			
	</xsl:template>
	<xsl:template name="title">
		<xsl:choose>
			<xsl:when test="marc:subfield[@code='i']">
				<xsl:choose>
					<xsl:when test="marc:subfield[@code='h']">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='d']">
								<xsl:choose>
									<xsl:when test="count(marc:subfield[@code='d']) &gt; 1">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='e']">
												<xsl:choose>
													<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='e']">
												<xsl:choose>
													<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>		
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='e']">
										<xsl:choose>
											<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
										<xsl:for-each select="marc:subfield[@code='h']"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>						
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='d']">
								<xsl:choose>
									<xsl:when test="count(marc:subfield[@code='d']) &gt; 1">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='e']">
												<xsl:choose>
													<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='e']">
												<xsl:choose>
													<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>		
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='e']">
										<xsl:choose>
											<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
										<xsl:for-each select="marc:subfield[@code='i'][position() &lt; last()]"><marc:subfield code="p"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='i'][last()]"><marc:subfield code="p"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>						
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>		
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="marc:subfield[@code='h']">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='d']">
								<xsl:choose>
									<xsl:when test="count(marc:subfield[@code='d']) &gt; 1">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='e']">
												<xsl:choose>
													<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='h'][position() &lt; last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='h'][position() &lt; last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='h'][position() &lt; last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='e']">
												<xsl:choose>
													<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='h'][position() &lt; last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='h'][position() &lt; last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='h'][position() &lt; last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(),' = ')" /></marc:subfield></xsl:for-each>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>		
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='e']">
										<xsl:choose>
											<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),'.')" /></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='h'][position() &lt; last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], '.')" /></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='h'][position() &lt; last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
												<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], '.')" /></marc:subfield>
										<xsl:for-each select="marc:subfield[@code='h'][position() &lt; last()]"><marc:subfield code="n"><xsl:value-of select="concat(text(), ',')" /></marc:subfield></xsl:for-each>
										<xsl:for-each select="marc:subfield[@code='h'][last()]"><marc:subfield code="n"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>						
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='d']">
								<xsl:choose>
									<xsl:when test="count(marc:subfield[@code='d']) &gt; 1">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='e']">
												<xsl:choose>
													<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),' = ')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], ' = ')" /></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' = ')" /></marc:subfield>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='d'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' = ')" /></xsl:for-each></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='d'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='e']">
												<xsl:choose>
													<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="concat(text(),' = ')" /></xsl:for-each>
														<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
														<marc:subfield code="b"><xsl:value-of select="concat(marc:subfield[@code='e'], ' = ')" /></marc:subfield>
														<xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' =')" /></marc:subfield>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='d']"><xsl:value-of select="text()" /></xsl:for-each></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>		
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='e']">
										<xsl:choose>
											<xsl:when test="count(marc:subfield[@code='e']) &gt; 1">
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:for-each select="marc:subfield[@code='e'][position() &lt; last()]"><xsl:value-of select="concat(text(), ' : ')" /></xsl:for-each></marc:subfield>
												<xsl:for-each select="marc:subfield[@code='e'][last()]"><xsl:value-of select="text()" /></xsl:for-each>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'], ' :')" /></marc:subfield>
												<marc:subfield code="b"><xsl:value-of select="marc:subfield[@code='e']" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
									</xsl:otherwise>
								</xsl:choose>						
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
	<xsl:template name="link-title">
		<xsl:choose>
			<xsl:when test="marc:subfield[@code='i']">
				<xsl:choose>
					<xsl:when test="marc:subfield[@code='h']">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='e']">
								<marc:subfield code="t"><xsl:value-of select="concat(marc:subfield[@code='a'], ' : ', marc:subfield[@code='e'], '. ', marc:subfield[@code='h'], ', ', marc:subfield[@code='i'])" /></marc:subfield>
							</xsl:when>
							<xsl:otherwise>
								<marc:subfield code="t"><xsl:value-of select="concat(marc:subfield[@code='a'],'. ', marc:subfield[@code='h'], ', ', marc:subfield[@code='i'])" /></marc:subfield>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='e']">
								<marc:subfield code="t"><xsl:value-of select="concat(marc:subfield[@code='a'], ' : ', marc:subfield[@code='e'], '. ', marc:subfield[@code='i'])" /></marc:subfield>
							</xsl:when>
							<xsl:otherwise>
								<marc:subfield code="t"><xsl:value-of select="concat(marc:subfield[@code='a'], '. ', marc:subfield[@code='i'])" /></marc:subfield>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="marc:subfield[@code='h']">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='e']">
								<marc:subfield code="t"><xsl:value-of select="concat(marc:subfield[@code='a'], ' : ', marc:subfield[@code='e'], '. ', marc:subfield[@code='h'])" /></marc:subfield>
							</xsl:when>
							<xsl:otherwise>
								<marc:subfield code="t"><xsl:value-of select="concat(marc:subfield[@code='a'],'. ', marc:subfield[@code='h'])" /></marc:subfield>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='e']">
								<marc:subfield code="t"><xsl:value-of select="concat(marc:subfield[@code='a'], ' : ', marc:subfield[@code='e'])" /></marc:subfield>
							</xsl:when>
							<xsl:otherwise>
								<marc:subfield code="t"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:for-each select="marc:subfield[@code='b']"><marc:subfield code="h"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
	</xsl:template>
	<xsl:template name="person">
		<xsl:choose>
			<xsl:when test="marc:subfield[@code='4']">
				<xsl:choose>
					<xsl:when test="marc:subfield[@code='f']">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='g']">
								<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='g'],')(', ''),',')" /></marc:subfield>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='c'][2]">
										<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='c'][2],')(',''),',')" /></marc:subfield>					
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='b']">
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'],', ',marc:subfield[@code='b'],',')" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'],',')" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
						<marc:subfield code="d">
							<xsl:choose>
								<xsl:when test="substring-after(marc:subfield[@code='f'],'-') = ')'">
									<xsl:value-of select="translate(marc:subfield[@code='f'],')(', '')" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="ends-with(marc:subfield[@code='f'],'-')">
											<xsl:value-of select="translate(marc:subfield[@code='f'],')(', '')" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="concat(translate(marc:subfield[@code='f'],')(',''),',')" />
										</xsl:otherwise>
									</xsl:choose>								
								</xsl:otherwise>
							</xsl:choose>
						</marc:subfield>				
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='g']">
								<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='g'],')(', ''),',')" /></marc:subfield>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='c'][2]">
										<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='c'][2],')(',''),',')" /></marc:subfield>					
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='b']">
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'],', ',marc:subfield[@code='b'],',')" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'],',')" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="marc:subfield[@code='f']">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='g']">
								<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='g'],')(', ''),',')" /></marc:subfield>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='c'][2]">
										<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='c'][2],')(',''),',')" /></marc:subfield>					
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='b']">
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'],', ',marc:subfield[@code='b'],',')" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'],',')" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
						<marc:subfield code="d">
							<xsl:choose>
								<xsl:when test="substring-after(marc:subfield[@code='f'],'-') = ')'">
									<xsl:value-of select="translate(marc:subfield[@code='f'],')(', '')" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="ends-with(marc:subfield[@code='f'],'-')">
											<xsl:value-of select="translate(marc:subfield[@code='f'],')(', '')" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="translate(marc:subfield[@code='f'],')(','')" />
										</xsl:otherwise>
									</xsl:choose>								
								</xsl:otherwise>
							</xsl:choose>
						</marc:subfield>				
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='g']">
								<marc:subfield code="a"><xsl:value-of select="translate(marc:subfield[@code='g'],')(', '')" /></marc:subfield>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='c'][2]">
										<marc:subfield code="a"><xsl:value-of select="translate(marc:subfield[@code='c'][2],')(','')" /></marc:subfield>					
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='b']">
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a'],', ',marc:subfield[@code='b']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:for-each select="marc:subfield[@code='4'][position() &lt; last()]"><marc:subfield code="e"><xsl:value-of select="concat(text(),',')" /></marc:subfield></xsl:for-each>
		<xsl:for-each select="marc:subfield[@code='4'][last()]"><marc:subfield code="e"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
		<xsl:choose>
			<xsl:when test="marc:subfield[@code='c'][2]"/>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="marc:subfield[@code='g']"/>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='b']"/>
							<xsl:otherwise>
								<xsl:for-each select="marc:subfield[@code='9']"><marc:subfield code="9"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>						
		</xsl:choose>
	</xsl:template>
	<xsl:template name="group">
		<xsl:attribute name="ind1"><xsl:value-of select="@ind2" /></xsl:attribute>
		<xsl:attribute name="ind2"><xsl:value-of select="' '" /></xsl:attribute>
		<xsl:choose>
			<xsl:when test="marc:subfield[@code='b']">
				<marc:subfield code="a"><xsl:value-of select="concat(marc:subfield[@code='a'],'.')" /></marc:subfield>
				<xsl:for-each select="marc:subfield[@code='b']"><marc:subfield code="b"><xsl:value-of select="concat(text(),'.')" /></marc:subfield></xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:for-each select="marc:subfield[@code='4']"><marc:subfield code="e"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
	</xsl:template>
	<xsl:template name="meeting">
		<xsl:attribute name="ind1"><xsl:value-of select="@ind2" /></xsl:attribute>
		<xsl:attribute name="ind2"><xsl:value-of select="' '" /></xsl:attribute>
		<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']" /></marc:subfield>
		<xsl:choose>
			<xsl:when test="marc:subfield[@code='e']">
				<xsl:choose>
					<xsl:when test="marc:subfield[@code='f']">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='d']">
								<marc:subfield code="n"><xsl:value-of select="concat(marc:subfield[@code='d'],' :')" /></marc:subfield>
								<marc:subfield code="d"><xsl:value-of select="concat(marc:subfield[@code='f'],' :')" /></marc:subfield>
								<marc:subfield code="c"><xsl:value-of select="marc:subfield[@code='e']" /></marc:subfield>
							</xsl:when>
							<xsl:otherwise>
								<marc:subfield code="d"><xsl:value-of select="concat(marc:subfield[@code='f'],' :')" /></marc:subfield>
								<marc:subfield code="c"><xsl:value-of select="marc:subfield[@code='e']" /></marc:subfield>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='d']">
								<marc:subfield code="n"><xsl:value-of select="concat(marc:subfield[@code='d'],' :')" /></marc:subfield>
								<marc:subfield code="c"><xsl:value-of select="marc:subfield[@code='e']" /></marc:subfield>
							</xsl:when>
							<xsl:otherwise>
								<marc:subfield code="c"><xsl:value-of select="marc:subfield[@code='e']" /></marc:subfield>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="marc:subfield[@code='c']">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='f']">
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='d']">
										<marc:subfield code="n"><xsl:value-of select="concat(marc:subfield[@code='d'],' :')" /></marc:subfield>
										<marc:subfield code="d"><xsl:value-of select="concat(marc:subfield[@code='f'],' :')" /></marc:subfield>
										<marc:subfield code="c"><xsl:value-of select="marc:subfield[@code='c']" /></marc:subfield>
									</xsl:when>
									<xsl:otherwise>
										<marc:subfield code="d"><xsl:value-of select="concat(marc:subfield[@code='f'],' :')" /></marc:subfield>
										<marc:subfield code="c"><xsl:value-of select="marc:subfield[@code='c']" /></marc:subfield>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='d']">
										<marc:subfield code="n"><xsl:value-of select="concat(marc:subfield[@code='d'],' :')" /></marc:subfield>
										<marc:subfield code="c"><xsl:value-of select="marc:subfield[@code='c']" /></marc:subfield>
									</xsl:when>
									<xsl:otherwise>
										<marc:subfield code="c"><xsl:value-of select="marc:subfield[@code='c']" /></marc:subfield>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='f']">
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='d']">
										<marc:subfield code="n"><xsl:value-of select="concat(marc:subfield[@code='d'],' :')" /></marc:subfield>
										<marc:subfield code="d"><xsl:value-of select="marc:subfield[@code='f']" /></marc:subfield>
									</xsl:when>
									<xsl:otherwise>
										<marc:subfield code="d"><xsl:value-of select="marc:subfield[@code='f']" /></marc:subfield>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="marc:subfield[@code='d']">
									<marc:subfield code="n"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>				
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:for-each select="marc:subfield[@code='4']"><marc:subfield code="e"><xsl:value-of select="text()" /></marc:subfield></xsl:for-each>
	</xsl:template>
	<xsl:template name="serise-490">
		<xsl:choose>
			<xsl:when test="marc:subfield[@code='v']">
				<xsl:choose>
					<xsl:when test="marc:subfield[@code='i']">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='h']">
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='e']">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='d']">
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '. ', marc:subfield[@code='h'], ', ', marc:subfield[@code='i'], ' ;')" /></marc:subfield>
												<marc:subfield code="v"><xsl:value-of select="concat(marc:subfield[@code='v'], ' =')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '. ', marc:subfield[@code='h'], ', ', marc:subfield[@code='i'], ' ;')" /></marc:subfield>
												<marc:subfield code="v"><xsl:value-of select="marc:subfield[@code='v']" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>					
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='d']">
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '. ', marc:subfield[@code='h'], ', ', marc:subfield[@code='i'], ' ;')" /></marc:subfield>
												<marc:subfield code="v"><xsl:value-of select="concat(marc:subfield[@code='v'], ' =')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '. ', marc:subfield[@code='h'], ', ', marc:subfield[@code='i'], ' ;')" /></marc:subfield>
												<marc:subfield code="v"><xsl:value-of select="marc:subfield[@code='v']" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='e']">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='d']">
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '. ', marc:subfield[@code='i'], ' ;')" /></marc:subfield>
												<marc:subfield code="v"><xsl:value-of select="concat(marc:subfield[@code='v'], ' =')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '. ', marc:subfield[@code='i'], ' ;')" /></marc:subfield>
												<marc:subfield code="v"><xsl:value-of select="marc:subfield[@code='v']" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>					
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='d']">
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''),'. ', marc:subfield[@code='i'], ' ;')" /></marc:subfield>
												<marc:subfield code="v"><xsl:value-of select="concat(marc:subfield[@code='v'], ' =')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '. ', marc:subfield[@code='i'], ' ;')" /></marc:subfield>
												<marc:subfield code="v"><xsl:value-of select="marc:subfield[@code='v']" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='h']">
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='e']">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='d']">
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '. ', marc:subfield[@code='h'], ' ;')" /></marc:subfield>
												<marc:subfield code="v"><xsl:value-of select="concat(marc:subfield[@code='v'], ' =')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '. ', marc:subfield[@code='h'], ' ;')" /></marc:subfield>
												<marc:subfield code="v"><xsl:value-of select="marc:subfield[@code='v']" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>					
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='d']">
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '. ', marc:subfield[@code='h'], ' ;')" /></marc:subfield>
												<marc:subfield code="v"><xsl:value-of select="concat(marc:subfield[@code='v'], ' =')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '. ', marc:subfield[@code='h'], ' ;')" /></marc:subfield>
												<marc:subfield code="v"><xsl:value-of select="marc:subfield[@code='v']" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='e']">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='d']">
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], ' ;')" /></marc:subfield>
												<marc:subfield code="v"><xsl:value-of select="concat(marc:subfield[@code='v'], ' =')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], ' ;')" /></marc:subfield>
												<marc:subfield code="v"><xsl:value-of select="marc:subfield[@code='v']" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>					
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='d']">
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' ;')" /></marc:subfield>
												<marc:subfield code="v"><xsl:value-of select="concat(marc:subfield[@code='v'], ' =')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' ;')" /></marc:subfield>
												<marc:subfield code="v"><xsl:value-of select="marc:subfield[@code='v']" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>												
					</xsl:otherwise>
				</xsl:choose>										
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="marc:subfield[@code='i']">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='h']">
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='e']">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='d']">
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '. ', marc:subfield[@code='h'], ', ', marc:subfield[@code='i'], ' =')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '. ', marc:subfield[@code='h'], ', ', marc:subfield[@code='i'])" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>					
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='d']">
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '. ', marc:subfield[@code='h'], ', ', marc:subfield[@code='i'], ' =')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '. ', marc:subfield[@code='h'], ', ', marc:subfield[@code='i'])" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='e']">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='d']">
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '. ', marc:subfield[@code='i'], ' =')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '. ', marc:subfield[@code='i'])" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>					
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='d']">
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''),'. ', marc:subfield[@code='i'], ' =')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '. ', marc:subfield[@code='i'])" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='h']">
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='e']">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='d']">
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], marc:subfield[@code='h'], ' =')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], marc:subfield[@code='h'])" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>					
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='d']">
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '. ', marc:subfield[@code='h'], ' =')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '. ', marc:subfield[@code='h'])" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='e']">
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='d']">
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], ' =')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'])" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>					
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='d']">
												<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' =')" /></marc:subfield>
												<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='d']" /></marc:subfield>
											</xsl:when>
											<xsl:otherwise>
												<marc:subfield code="a"><xsl:value-of select="translate(marc:subfield[@code='a'],',.=','')" /></marc:subfield>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>												
					</xsl:otherwise>
				</xsl:choose>										
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="serise-830">
		<marc:datafield tag="830" ind1=" " ind2="0">
			<xsl:choose>
				<xsl:when test="marc:subfield[@code='v']">
					<xsl:choose>
						<xsl:when test="marc:subfield[@code='i']">
							<xsl:choose>
								<xsl:when test="marc:subfield[@code='h']">
									<xsl:choose>
										<xsl:when test="marc:subfield[@code='e']">
											<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '.')" /></marc:subfield>
											<marc:subfield code="n"><xsl:value-of select="concat(marc:subfield[@code='h'], ',')" /></marc:subfield>
											<marc:subfield code="p"><xsl:value-of select="concat(marc:subfield[@code='i'], ' ;')" /></marc:subfield>
											<marc:subfield code="v"><xsl:value-of select="concat(marc:subfield[@code='v'], '.')" /></marc:subfield>
										</xsl:when>
										<xsl:otherwise>
											<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '.')" /></marc:subfield>
											<marc:subfield code="n"><xsl:value-of select="concat(marc:subfield[@code='h'], ',')" /></marc:subfield>
											<marc:subfield code="p"><xsl:value-of select="concat(marc:subfield[@code='i'], ' ;')" /></marc:subfield>
											<marc:subfield code="v"><xsl:value-of select="concat(marc:subfield[@code='v'], '.')" /></marc:subfield>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="marc:subfield[@code='e']">
											<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '.')" /></marc:subfield>
											<marc:subfield code="p"><xsl:value-of select="concat(marc:subfield[@code='i'], ' ;')" /></marc:subfield>
											<marc:subfield code="v"><xsl:value-of select="concat(marc:subfield[@code='v'], '.')" /></marc:subfield>
										</xsl:when>
										<xsl:otherwise>
											<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '.')" /></marc:subfield>
											<marc:subfield code="p"><xsl:value-of select="concat(marc:subfield[@code='i'], ' ;')" /></marc:subfield>
											<marc:subfield code="v"><xsl:value-of select="concat(marc:subfield[@code='v'], '.')" /></marc:subfield>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="marc:subfield[@code='h']">
									<xsl:choose>
										<xsl:when test="marc:subfield[@code='e']">
											<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '.')" /></marc:subfield>
											<marc:subfield code="n"><xsl:value-of select="concat(marc:subfield[@code='h'], ' ;')" /></marc:subfield>
											<marc:subfield code="v"><xsl:value-of select="concat(marc:subfield[@code='v'], '.')" /></marc:subfield>
										</xsl:when>
										<xsl:otherwise>
											<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '.')" /></marc:subfield>
											<marc:subfield code="n"><xsl:value-of select="concat(marc:subfield[@code='h'], ' ;')" /></marc:subfield>
											<marc:subfield code="v"><xsl:value-of select="concat(marc:subfield[@code='v'], '.')" /></marc:subfield>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="marc:subfield[@code='e']">
											<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '.')" /></marc:subfield>
											<marc:subfield code="v"><xsl:value-of select="concat(marc:subfield[@code='v'], '.')" /></marc:subfield>
										</xsl:when>
										<xsl:otherwise>
											<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' ;')" /></marc:subfield>
											<marc:subfield code="v"><xsl:value-of select="concat(marc:subfield[@code='v'], '.')" /></marc:subfield>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>												
						</xsl:otherwise>
					</xsl:choose>										
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="marc:subfield[@code='i']">
							<xsl:choose>
								<xsl:when test="marc:subfield[@code='h']">
									<xsl:choose>
										<xsl:when test="marc:subfield[@code='e']">
											<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '.')" /></marc:subfield>
											<marc:subfield code="n"><xsl:value-of select="concat(marc:subfield[@code='h'], ',')" /></marc:subfield>
											<marc:subfield code="p"><xsl:value-of select="concat(marc:subfield[@code='i'], '.')" /></marc:subfield>
										</xsl:when>
										<xsl:otherwise>
											<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '.')" /></marc:subfield>
											<marc:subfield code="n"><xsl:value-of select="concat(marc:subfield[@code='h'], ',')" /></marc:subfield>
											<marc:subfield code="p"><xsl:value-of select="concat(marc:subfield[@code='i'], '.')" /></marc:subfield>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="marc:subfield[@code='e']">
											<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '.')" /></marc:subfield>
											<marc:subfield code="p"><xsl:value-of select="concat(marc:subfield[@code='i'], '.')" /></marc:subfield>
										</xsl:when>
										<xsl:otherwise>
											<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '.')" /></marc:subfield>
											<marc:subfield code="p"><xsl:value-of select="concat(marc:subfield[@code='i'], '.')" /></marc:subfield>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="marc:subfield[@code='h']">
									<xsl:choose>
										<xsl:when test="marc:subfield[@code='e']">
											<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '.')" /></marc:subfield>
											<marc:subfield code="n"><xsl:value-of select="concat(marc:subfield[@code='h'], '.')" /></marc:subfield>
										</xsl:when>
										<xsl:otherwise>
											<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '.')" /></marc:subfield>
											<marc:subfield code="n"><xsl:value-of select="concat(marc:subfield[@code='h'], '.')" /></marc:subfield>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="marc:subfield[@code='e']">
											<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), ' : ', marc:subfield[@code='e'], '.')" /></marc:subfield>
										</xsl:when>
										<xsl:otherwise>
											<marc:subfield code="a"><xsl:value-of select="concat(translate(marc:subfield[@code='a'],',.=',''), '.')" /></marc:subfield>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>												
						</xsl:otherwise>
					</xsl:choose>										
				</xsl:otherwise>
			</xsl:choose>						
		</marc:datafield>		
	</xsl:template>
</xsl:stylesheet>
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
					<!-- 头标区转换，MARC21中文献类型p没有对应，按照普通图书处理-->
					<marc:leader>
						<xsl:variable name="leader00-05" select="'00000n'"/>
						<xsl:variable name="leader06" select="translate(substring(marc:leader,7,1),'mot','lmb')"/>
						<xsl:variable name="leader07-23" select="'m0#2200000###450#'"/>
						<xsl:value-of select="concat($leader00-05, $leader06, $leader07-23)"/>
					</marc:leader>
					<!-- 005 文献修改时间 -->
					<marc:controlfield tag="005"><xsl:value-of select="marc:controlfield[@tag='005']" /></marc:controlfield>
					<!-- 010<=020 ISBN -->
					<xsl:if test="marc:datafield[@tag='020'][1]">
						<marc:datafield tag="010" ind1=" " ind2=" ">
							<marc:subfield code="a"><xsl:value-of select="marc:datafield[@tag='020'][1]/marc:subfield[@code='a']" /></marc:subfield>
							<xsl:if test="marc:datafield[@tag='020'][1]/marc:subfield[@code='z']">
								<marc:subfield code="z"><xsl:value-of select="marc:datafield[@tag='020']/marc:subfield[@code='z']" /></marc:subfield>
							</xsl:if>
						</marc:datafield>
					</xsl:if>
					<xsl:if test="marc:datafield[@tag='020'][2]">
						<marc:datafield tag="010" ind1=" " ind2=" ">
							<marc:subfield code="a"><xsl:value-of select="marc:datafield[@tag='020'][2]/marc:subfield[@code='a']" /></marc:subfield>
							<xsl:if test="marc:datafield[@tag='020'][2]/marc:subfield[@code='z']">
								<marc:subfield code="z"><xsl:value-of select="marc:datafield[@tag='020']/marc:subfield[@code='z']" /></marc:subfield>
							</xsl:if>
						</marc:datafield>
					</xsl:if>
					<!-- 011<=022 ISSN -->
					<xsl:if test="marc:datafield[@tag='022']">
						<marc:datafield tag="011" ind1=" " ind2=" ">
							<marc:subfield code="a"><xsl:value-of select="marc:datafield[@tag='022']/marc:subfield[@code='a']" /></marc:subfield>
							<xsl:if test="marc:datafield[@tag='022']/marc:subfield[@code='z']">	
								<marc:subfield code="y"><xsl:value-of select="marc:datafield[@tag='022']/marc:subfield[@code='z']" /></marc:subfield>
							</xsl:if>
							<xsl:if test="marc:datafield[@tag='022']/marc:subfield[@code='y']">	
								<marc:subfield code="z"><xsl:value-of select="marc:datafield[@tag='020']/marc:subfield[@code='y']" /></marc:subfield>						
							</xsl:if>
						</marc:datafield>
					</xsl:if>
					<!-- 013<=024 ISMC音乐出版物编码 -->
					<xsl:if test="marc:datafield[@tag='024'][@ind1='2']">
						<marc:datafield tag="013" ind1=" " ind2=" ">
							<marc:subfield code="a"><xsl:value-of select="marc:datafield[@tag='024']/marc:subfield[@code='a']" /></marc:subfield>
						</marc:datafield>
					</xsl:if>
					<!-- 016<=024 ISRC音像编码 -->
					<xsl:if test="marc:datafield[@tag='024'][@ind1='0']">
						<marc:datafield tag="016" ind1=" " ind2=" ">
							<marc:subfield code="a"><xsl:value-of select="marc:datafield[@tag='024']/marc:subfield[@code='a']" /></marc:subfield>
						</marc:datafield>
					</xsl:if>
					<!-- 035<=001 其他系统号 -->
					<xsl:if test="marc:datafield[@tag='001']">
						<marc:controlfield tag="035" ind1=" " ind2=" ">
							<marc:subfield code="a"><xsl:value-of select="marc:controlfield[@tag='001']" /></marc:subfield>
						</marc:controlfield>
					</xsl:if>
					<!-- 100<=008 -->
					<xsl:variable name="s008" select="marc:controlfield[@tag='008']"/>
						<marc:datafield tag="100" ind1=" " ind2=" ">
							<marc:subfield code="a">
								<xsl:variable name="dest00-07" select="substring($s008,1,6)"/>
								<xsl:variable name="dest08" select="translate(substring($s008,7,1), 'cdusrqmtpe', 'abcdefghij')"/>
								<xsl:variable name="dest09-16" select="substring($s008,8,8)"/>
								<xsl:variable name="dest17" select="translate(substring($s008,23,1), 'abjcdeg ', 'bcadekmu')"/>
								<xsl:variable name="dest18-19" select="'  '"/>
								<xsl:variable name="dest20" select="translate(substring($s008,29,1), 'fslcio ', 'abcefhy')"/>	
								<xsl:variable name="dest21">
									<xsl:choose>
										<xsl:when test="substring($s008,39,1) = ' '">0</xsl:when>
										<xsl:otherwise>1</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="dest22-24" select="substring($s008,36,3)"/>
								<xsl:variable name="dest25-35" select="'y50      ea'"/>
								<xsl:value-of select="concat('20', $dest00-07, $dest08, $dest09-16, $dest17, $dest18-19, $dest20, $dest21, $dest22-24, $dest25-35)"/>
							</marc:subfield>
						</marc:datafield>
					<!-- 101<=041 -->
					<xsl:for-each select="marc:datafield[@tag='041']">
						<datafield tag="101">
							<xsl:attribute name="ind1"><xsl:value-of select="@ind1" /></xsl:attribute>
							<xsl:attribute name="ind2"><xsl:value-of select="' '" /></xsl:attribute>
							<xsl:for-each select="marc:subfield[@code='a']"><subfield code="a"><xsl:value-of select="text()" /></subfield></xsl:for-each>
							<xsl:for-each select="marc:subfield[@code='b']"><subfield code="d"><xsl:value-of select="text()" /></subfield></xsl:for-each>
							<xsl:for-each select="marc:subfield[@code='d']"><subfield code="a"><xsl:value-of select="text()" /></subfield></xsl:for-each>
							<xsl:for-each select="marc:subfield[@code='e']"><subfield code="h"><xsl:value-of select="text()" /></subfield></xsl:for-each>
							<xsl:for-each select="marc:subfield[@code='f']"><subfield code="e"><xsl:value-of select="text()" /></subfield></xsl:for-each>
							<xsl:for-each select="marc:subfield[@code='g']"><subfield code="i"><xsl:value-of select="text()" /></subfield></xsl:for-each>
							<xsl:for-each select="marc:subfield[@code='h']"><subfield code="c"><xsl:value-of select="text()" /></subfield></xsl:for-each>
							<xsl:for-each select="marc:subfield[@code='k']"><subfield code="b"><xsl:value-of select="text()" /></subfield></xsl:for-each>
							<xsl:for-each select="marc:subfield[@code='j']"><subfield code="j"><xsl:value-of select="text()" /></subfield></xsl:for-each>
						</datafield>
					</xsl:for-each>				
					<!-- 新增102音像资源出版国别 -->
					<xsl:if test="substring($s008,36,3)='chi'">
						<xsl:if test="substring(marc:leader,7,1)='j'"><xsl:call-template name="publishing-country"/></xsl:if>
						<xsl:if test="substring(marc:leader,7,1)='g'"><xsl:call-template name="publishing-country"/></xsl:if>
					</xsl:if>
					<!-- 115<=007录像制品形态特征 -->
					<xsl:variable name="s007" select="marc:controlfield[@tag='007']"/>
						<xsl:if test="substring($s007,1,1)='v'">
							<marc:datafield tag="115" ind1=" " ind2=" ">
								<marc:subfield code="a">
									<xsl:variable name="vd01-03" select="translate(substring($s008,19,3),'-','#')"/>
									<xsl:variable name="vd04" select="translate(substring($s007,4,1),'bcmn|','abcuu')"/>
									<xsl:variable name="vd05" select="translate(substring($s007,6,1),'#|','yu')"/>
									<xsl:variable name="vd06" select="translate(substring($s007,7,1),'#|','xu')"/>
									<xsl:variable name="vd07" select="translate(substring($s007,8,1),'mr','nm')"/>
									<xsl:variable name="vd09" select="translate(substring($s008,35,1),'lnuz|','beddd')"/>
									<xsl:variable name="vd16" select="translate(substring($s007,5,1),'jkmopqv|','iiiijjgu')"/>
									<xsl:value-of select="concat('c',$vd01-03,$vd04,$vd05,$vd06,$vd07,'x',$vd09,'x    b',$vd16,'xxc')" />
								</marc:subfield>							
							</marc:datafield>	
						</xsl:if>
					<!-- 126<=007录音制品形态特征 -->
						<xsl:if test="substring($s007,1,1)='s'">
							<marc:datafield tag="126" ind1=" " ind2=" ">
								<marc:subfield code="a">
									<xsl:variable name="sd00" select="translate(substring($s007,2,1),'dtsgweqiu|','abcdefghzz')"/>
									<xsl:variable name="sd01" select="translate(substring($s007,4,1),'fklopr|','glknopx')"/>
									<xsl:variable name="sd02" select="translate(substring($s007,5,1),'mqs|','acbz')"/>
									<xsl:variable name="sd03" select="translate(substring($s007,6,1),'mns|','bxau')"/>
									<xsl:variable name="sd04" select="translate(substring($s007,7,1),'gn|','hxx')"/>
									<xsl:variable name="sd05" select="translate(substring($s007,8,1),'lmnop|','daxbcx')"/>
									<xsl:variable name="sd06" select="translate(substring($s007,9,1),'n|','xx')"/>
									<xsl:variable name="sd07-12" select="translate(substring($s008,25,6),'#|','  ')"/>
									<xsl:variable name="sd13" select="translate(substring($s007,14,1),'de|','cbu')"/>
									<xsl:variable name="sd14" select="translate(substring($s007,13,1),'cdefn|','fcdexu')"/>
									<xsl:value-of select="concat($sd00,$sd01,$sd02,$sd03,$sd04,$sd05,$sd06,sd07-12,$sd13,$sd14)" />
								</marc:subfield>
								<marc:subfield code="b">
									<xsl:variable name="sdb00" select="translate(substring($s007,10,1),'abdimnrst|','cdeabxfghx')"/>
									<xsl:variable name="sdb01" select="translate(substring($s007,11,1),'bcgilmnpsw|','zazbbexdcgx')"/>
									<xsl:variable name="sdb02" select="translate(substring($s007,12,1),'hln|','baxx')"/>
									<xsl:value-of select="concat($sdb00, $sdb01, $sdb02)" />
								</marc:subfield>
							</marc:datafield>
						</xsl:if>
					<xsl:variable name="s100" select="marc:datafield[@tag='100']"/>
					<xsl:variable name="s110" select="marc:datafield[@tag='110']"/>					
					<xsl:variable name="s111" select="marc:datafield[@tag='111']"/>
					<xsl:variable name="s130" select="marc:datafield[@tag='130']"/>
					<xsl:variable name="s240" select="marc:datafield[@tag='240']"/>
					<xsl:variable name="s245" select="marc:datafield[@tag='245']"/>
					<xsl:variable name="s246" select="marc:datafield[@tag='246']"/>
					<xsl:variable name="s250" select="marc:datafield[@tag='250']"/>
					<xsl:variable name="s260" select="marc:datafield[@tag='260']"/>
					<xsl:variable name="s264" select="marc:datafield[@tag='264']"/>
					<xsl:variable name="s490" select="marc:datafield[@tag='490']"/>
					<xsl:variable name="s500" select="marc:datafield[@tag='500']"/>
					<xsl:variable name="s505" select="marc:datafield[@tag='505']"/>
					<xsl:variable name="s520" select="marc:datafield[@tag='520']"/>
					<xsl:variable name="s700" select="marc:datafield[@tag='700']"/>
					<xsl:variable name="s710" select="marc:datafield[@tag='710']"/>
					<xsl:variable name="s740" select="marc:datafield[@tag='740']"/>
					<xsl:variable name="s830" select="marc:datafield[@tag='830']"/>
					<xsl:variable name="s800" select="marc:datafield[@tag='800']"/>
					<xsl:variable name="s880" select="marc:datafield[@tag='880']"/>
					<!-- 200<=245 -->
					<marc:datafield tag="200" ind1="0" ind2="0">
						<xsl:for-each select="$s245">
							<xsl:choose>
								<xsl:when test="marc:subfield[@code='6']"/>
								<xsl:otherwise>
									<xsl:call-template name="title-statement-1"/>
									<xsl:call-template name="title-statement-2"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
						<marc:subfield code="b"><xsl:call-template name="record-type"/></marc:subfield>
						<xsl:for-each select="$s245">
							<xsl:choose>
								<xsl:when test="marc:subfield[@code='6']"/>
								<xsl:otherwise>
									<xsl:call-template name="title-statement-3"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>				
						<xsl:for-each select="$s880">
							<xsl:if test="contains(marc:subfield[@code='6'],'245')"><xsl:call-template name="title-statement-1"/></xsl:if>
						</xsl:for-each>
						<xsl:if test="substring($s008,36,3)='chi'">
							<marc:subfield code="9"><xsl:value-of select="translate($s245/marc:subfield[@code='a'],'/=:.,','')"/></marc:subfield>
						</xsl:if>	
						<xsl:for-each select="$s880">
							<xsl:if test="contains(marc:subfield[@code='6'],'245')"><xsl:call-template name="title-statement-2"/></xsl:if>
						</xsl:for-each>						
						<marc:subfield code="b"><xsl:call-template name="record-type"/></marc:subfield>
						<xsl:for-each select="$s880">
							<xsl:if test="contains(marc:subfield[@code='6'],'245')"><xsl:call-template name="title-statement-3"/></xsl:if>
						</xsl:for-each>
					</marc:datafield>
					<!-- 205<=250 -->
					<xsl:for-each select="$s250">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='6']"/>
							<xsl:otherwise><xsl:call-template name="edition-statement"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>					
					<xsl:for-each select="$s880">
						<xsl:if test="contains(marc:subfield[@code='6'],'250')"><xsl:call-template name="edition-statement"/></xsl:if>
					</xsl:for-each>
					<!-- 210<=264/260 -->
					<xsl:for-each select="$s264">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='6']"/>
							<xsl:otherwise><xsl:call-template name="publication-statement"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					<xsl:for-each select="$s260">
						<xsl:choose>
							<xsl:when test="$s264"/>
							<xsl:when test="marc:subfield[@code='6']"/>
							<xsl:otherwise><xsl:call-template name="publication-statement"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					<xsl:for-each select="$s880">
						<xsl:if test="contains(marc:subfield[@code='6'],'264')"><xsl:call-template name="publication-statement"/></xsl:if>	
						<xsl:if test="contains(marc:subfield[@code='6'],'260')"><xsl:call-template name="publication-statement"/></xsl:if>
					</xsl:for-each>
					<!-- 215<=300 还是保留的英文 -->
					<xsl:call-template name="physical-description"/>
					<!-- 225<=830/490 800? -->
					<xsl:if test="$s490[@ind1='0']">
						<xsl:for-each select="$s490">
							<xsl:choose>
								<xsl:when test="marc:subfield[@code='6']"/>
								<xsl:otherwise><xsl:call-template name="series-statement0"/></xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
						<xsl:for-each select="$s880">
							<xsl:if test="contains(marc:subfield[@code='6'],'490')"><xsl:call-template name="series-statement0"/></xsl:if>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="$s490[@ind1='1']">
						<xsl:for-each select="$s830">
							<xsl:choose>
								<xsl:when test="marc:subfield[@code='6']"/>
								<xsl:otherwise><xsl:call-template name="series-statement1"/></xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>			
						<xsl:for-each select="$s880">
							<xsl:if test="contains(marc:subfield[@code='6'],'830')"><xsl:call-template name="series-statement1"/></xsl:if>
						</xsl:for-each>
					</xsl:if>
					<!-- 300<=500 -->
					<xsl:for-each select="$s500">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='6']"/>
							<xsl:otherwise><xsl:call-template name="transform-note"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>					
					<xsl:for-each select="$s880">
						<xsl:if test="contains(marc:subfield[@code='6'],'500')"><xsl:call-template name="transform-note"/></xsl:if>
					</xsl:for-each>
					<!-- 327<=505 -->
					<xsl:for-each select="$s505">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='6']"/>						
							<xsl:otherwise><xsl:call-template name="contents-note"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					<xsl:for-each select="$s880">
						<xsl:if test="contains(marc:subfield[@code='6'],'505')"><xsl:call-template name="contents-note"/></xsl:if>
					</xsl:for-each>	
					<!-- 330<=520 -->
					<xsl:for-each select="$s520">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='6']"/>						
							<xsl:otherwise><xsl:call-template name="transform-summary"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>					
					<xsl:for-each select="$s880">
						<xsl:if test="contains(marc:subfield[@code='6'],'520')"><xsl:call-template name="transform-summary"/></xsl:if>
					</xsl:for-each>
					<!-- 500<=130/240 -->
					<xsl:for-each select="$s130">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='6']"/>
							<xsl:otherwise><xsl:call-template name="uniform-title"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					<xsl:for-each select="$s240">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='6']"/>
							<xsl:otherwise><xsl:call-template name="uniform-title"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					<xsl:for-each select="$s880">
						<xsl:if test="contains(marc:subfield[@code='6'],'130')"><xsl:call-template name="uniform-title"/></xsl:if>	
						<xsl:if test="contains(marc:subfield[@code='6'],'240')"><xsl:call-template name="uniform-title"/></xsl:if>
					</xsl:for-each>
					<!-- 510<=246 31 -->
					<xsl:for-each select="$s246[@ind1='3'][@ind2='1']">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='6']"/>
							<xsl:otherwise>
								<marc:datafield tag="510" ind1="1" ind2=" "><xsl:call-template name="transform-title"/></marc:datafield>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					<xsl:for-each select="$s880[@ind1='3'][@ind2='1']">
						<marc:datafield tag="510" ind1="1" ind2=" "><xsl:call-template name="transform-title"/></marc:datafield>
					</xsl:for-each>		
					<!-- 512<=246 34封面题名 -->
					<xsl:call-template name="other-title">
						<xsl:with-param name="indicator" select="'4'"/>
						<xsl:with-param name="dsttag" select="512"/>
						<xsl:with-param name="type" select="'cover'"/>
						<xsl:with-param name="type2" select="'Cover'"/>
					</xsl:call-template>
					<!-- 513<=246 35附加题名页题名 -->
					<xsl:call-template name="other-title">
						<xsl:with-param name="indicator" select="'5'"/>
						<xsl:with-param name="dsttag" select="'513'"/>
						<xsl:with-param name="type" select="'added'"/>
						<xsl:with-param name="type2" select="'Added'"/>
					</xsl:call-template>						
					<!-- 516<=246 38书脊题名 -->
					<xsl:call-template name="other-title">
						<xsl:with-param name="indicator" select="'8'"/>
						<xsl:with-param name="dsttag" select="'516'"/>
						<xsl:with-param name="type" select="'spine'"/>
						<xsl:with-param name="type2" select="'Spine'"/>	
					</xsl:call-template>
					<!-- 517<=246 30 -->
					<xsl:for-each select="$s246[@ind1='3'][@ind2='0']">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='6']"/>
							<xsl:otherwise>					
								<marc:datafield tag="517" ind1="1" ind2=" "><xsl:call-template name="title"/></marc:datafield>
							</xsl:otherwise>
						</xsl:choose>									
					</xsl:for-each>
					<xsl:for-each select="$s880[@ind1='3'][@ind2='0']">
						<marc:datafield tag="517" ind1="1" ind2=" "><xsl:call-template name="title"/></marc:datafield>
					</xsl:for-each>
					<!-- 517<=505 -->
					<xsl:for-each select="$s505">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='6']"/>
							<xsl:otherwise><xsl:call-template name="analytical-title"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					<xsl:for-each select="$s880">
						<xsl:if test="contains(marc:subfield[@code='6'],'505')"><xsl:call-template name="analytical-title"/></xsl:if>
					</xsl:for-each>
					<!-- 517<=740 -->
					<xsl:for-each select="$s740">
						<xsl:choose>
							<xsl:when test="$s505[@ind2='0']"/>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='6']"/>
									<xsl:otherwise>								
										<marc:datafield tag="517" ind1="1" ind2=" "><xsl:call-template name="title"/></marc:datafield>
									</xsl:otherwise>	
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>	
					<xsl:for-each select="$s880">
						<xsl:if test="contains(marc:subfield[@code='6'],'740')">
							<xsl:choose>
								<xsl:when test="$s505[@ind2='0']"/>
								<xsl:otherwise>
									<marc:datafield tag="517" ind1="1" ind2=" "><xsl:call-template name="title"/></marc:datafield>											
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</xsl:for-each>
					<!-- 701<=100/700[1] -->
					<xsl:call-template name="transform-100-700-1"/>
					<!-- 701<=700[1]/700[2][3] -->
					<xsl:call-template name="transform-700-2-3"/>
					<!-- 702<=700[4-] -->						
					<xsl:call-template name="transform-700-4"/>
					<!-- 711<=110 -->
					<xsl:call-template name="transform-110"/>
					<!-- 711<=111 -->
					<xsl:call-template name="transform-111"/>
					<!-- 712<=710 -->
					<xsl:call-template name="transform-710"/>					
				</marc:record>
			</xsl:for-each>
		</marc:collection>
	</xsl:template>
	<xsl:template name="publishing-country">
		<xsl:variable name="s008" select="marc:controlfield[@tag='008']"/>
		<xsl:variable name="s880" select="marc:datafield[@tag='880']"/>	
			<marc:datafield tag="102" ind1=" " ind2=" ">
				<marc:subfield code="a"><xsl:value-of select="'CN'" /></marc:subfield>
				<xsl:for-each select="$s880">
					<xsl:if test="contains(marc:subfield[@code='6'],'260')">
						<xsl:choose>
							<xsl:when test="contains(marc:subfield[@code='6'],'264')"/>
							<xsl:otherwise>
								<marc:subfield code="b"><xsl:value-of select="translate(marc:subfield[@code='a'][1],'];市:[','')" /></marc:subfield>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:if test="contains(marc:subfield[@code='6'],'264')">
						<marc:subfield code="b"><xsl:value-of select="translate(marc:subfield[@code='a'][1],'];市:[','')" /></marc:subfield>
					</xsl:if>
				</xsl:for-each>
			</marc:datafield>
	</xsl:template>	
	<xsl:template name="title-statement-1">
		<marc:subfield code="a"><xsl:value-of select="translate(marc:subfield[@code='a'],'/=:.,;','')"/></marc:subfield>
	</xsl:template>
	<xsl:template name="title-statement-2">
		<xsl:if test="ends-with(.,';')">
			<marc:subfield code="a"><xsl:value-of select="translate(marc:subfield[@code='b'],'/=:.,','')"/></marc:subfield>
		</xsl:if>
		<xsl:if test="contains(.,' :')">
			<xsl:choose>
				<xsl:when test="contains(marc:subfield[@code='b'],' =')">
					<marc:subfield code="e"><xsl:value-of select="translate(substring-before(marc:subfield[@code='b'],'='),'/=.,','')"/></marc:subfield>
				</xsl:when>
				<xsl:otherwise>
					<marc:subfield code="e"><xsl:value-of select="translate(marc:subfield[@code='b'],'/=.,','')"/></marc:subfield>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='n'][1]">
			<marc:subfield code="h"><xsl:value-of select="translate(marc:subfield[@code='n'][1],'/=,','')"/></marc:subfield>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='n'][2]">
			<xsl:choose>
				<xsl:when test="contains(.,' =')"/>
				<xsl:otherwise>
					<marc:subfield code="h"><xsl:value-of select="translate(marc:subfield[@code='n'][2],'/','')"/></marc:subfield>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>		
		<xsl:if test="marc:subfield[@code='p'][1]">
			<xsl:value-of select="position()"></xsl:value-of>
			<marc:subfield code="i"><xsl:value-of select="translate(marc:subfield[@code='p'][1],'/=.','')"/></marc:subfield>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='p'][2]">
			<xsl:choose>
				<xsl:when test="contains(.,' =')"/>
				<xsl:otherwise>
					<marc:subfield code="i"><xsl:value-of select="translate(marc:subfield[@code='p'][2],'/','')"/></marc:subfield>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="title-statement-3">
		<xsl:if test="contains(.,' =')">
			<marc:subfield code="d">
				<xsl:choose>
					<xsl:when test="contains(.,' :')">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='n'][2]">
								<xsl:value-of select="substring-before(substring-after(.,' ='),' .')" />
							</xsl:when>
							<xsl:when test="marc:subfield[@code='p'][2]">
								<xsl:value-of select="substring-before(substring-after(.,' ='),' .')" />
							</xsl:when>
							<xsl:otherwise><xsl:value-of select="substring-before(substring-after(.,' ='),' /')" /></xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="translate(marc:subfield[@code='b'],'/.,','')"/></xsl:otherwise>
				</xsl:choose>
			</marc:subfield>
			<xsl:if test="marc:subfield[@code='n'][2]">
				<marc:subfield code="h"><xsl:value-of select="translate(marc:subfield[@code='n'][2],'/=,','')"/></marc:subfield>
			</xsl:if>
			<xsl:if test="marc:subfield[@code='p'][2]">
				<marc:subfield code="i"><xsl:value-of select="translate(marc:subfield[@code='p'][2],'/=','')"/></marc:subfield>
			</xsl:if>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="contains(marc:subfield[@code='c'],' ; ')">
				<subfield code="f"><xsl:value-of select="substring-before(marc:subfield[@code='c'],' ; ')" /></subfield>
				<subfield code="g"><xsl:value-of select="translate(substring-after(marc:subfield[@code='c'],' ; '),'.','')" /></subfield>
			</xsl:when>
			<xsl:otherwise>
				<subfield code="f"><xsl:value-of select="translate(marc:subfield[@code='c'],'.','')" /></subfield>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>	
	<xsl:template name="record-type">
		<xsl:choose>
			<xsl:when test="substring(marc:leader,7,1)='c'">乐谱</xsl:when>
			<xsl:when test="substring(marc:leader,7,1)='d'">乐谱手稿</xsl:when>
			<xsl:when test="substring(marc:leader,7,1)='e'">地图</xsl:when>
			<xsl:when test="substring(marc:leader,7,1)='f'">地图手稿</xsl:when>
			<xsl:when test="substring(marc:leader,7,1)='g'">录像制品</xsl:when>
			<xsl:when test="substring(marc:leader,7,1)='i'">录音制品</xsl:when>
			<xsl:when test="substring(marc:leader,7,1)='j'">录音制品</xsl:when>
			<xsl:when test="substring(marc:leader,7,1)='k'">二维图形</xsl:when>
			<xsl:when test="substring(marc:leader,7,1)='m'">电子资源</xsl:when>
			<xsl:when test="substring(marc:leader,7,1)='0'">多媒体资源</xsl:when>
			<xsl:when test="substring(marc:leader,7,1)='r'">三维制品</xsl:when>
			<xsl:when test="substring(marc:leader,7,1)='t'">手稿</xsl:when>
			<xsl:otherwise>专著</xsl:otherwise>
		</xsl:choose>
	</xsl:template>		
	<xsl:template name="edition-statement">
		<marc:datafield tag="205" ind1=" " ind2=" ">
			<marc:subfield code="a"><xsl:value-of select="translate(marc:subfield[@code='a'],'.','')"/></marc:subfield>
		</marc:datafield>
	</xsl:template>
	<xsl:template name="publication-statement">
		<marc:datafield tag="210" ind1=" " ind2=" ">
			<xsl:choose>
				<xsl:when test="contains(marc:subfield[@code='b'][1],';')">
					<marc:subfield code="a"><xsl:value-of select="substring-before(marc:subfield[@code='a'][1],':')"/></marc:subfield>
					<marc:subfield code="c"><xsl:value-of select="substring-before(marc:subfield[@code='b'][1],';')"/></marc:subfield>
					<marc:subfield code="a"><xsl:value-of select="substring-before(marc:subfield[@code='a'][2],':')"/></marc:subfield>
					<marc:subfield code="c"><xsl:value-of select="substring-before(marc:subfield[@code='b'][2],',')"/></marc:subfield>
				</xsl:when>
				<xsl:when test="contains(marc:subfield[@code='b'][1],':')">
					<marc:subfield code="a"><xsl:value-of select="substring-before(marc:subfield[@code='a'],':')"/></marc:subfield>
					<marc:subfield code="c"><xsl:value-of select="substring-before(marc:subfield[@code='b'][1],':')"/></marc:subfield>
					<marc:subfield code="c"><xsl:value-of select="substring-before(marc:subfield[@code='b'][2],',')"/></marc:subfield>
				</xsl:when>
				<xsl:when test="contains(marc:subfield[@code='a'][1],';')">
					<marc:subfield code="a"><xsl:value-of select="substring-before(marc:subfield[@code='a'][1],';')"/></marc:subfield>
					<marc:subfield code="a"><xsl:value-of select="substring-before(marc:subfield[@code='a'][2],':')"/></marc:subfield>
					<marc:subfield code="c"><xsl:value-of select="substring-before(marc:subfield[@code='b'],',')"/></marc:subfield>
				</xsl:when>
				<xsl:otherwise>
					<marc:subfield code="a"><xsl:value-of select="substring-before(marc:subfield[@code='a'],':')"/></marc:subfield>
					<marc:subfield code="c"><xsl:value-of select="substring-before(marc:subfield[@code='b'],',')"/></marc:subfield>
				</xsl:otherwise>
			</xsl:choose>
			<marc:subfield code="d"><xsl:value-of select="translate(marc:subfield[@code='c'],'.','')"/></marc:subfield>
		</marc:datafield>
	</xsl:template>	
	<xsl:template name="physical-description">
		<marc:datafield tag="215" ind1=" " ind2=" ">
			<xsl:for-each select="marc:datafield[@tag='300']">
				<marc:subfield code="a"><xsl:value-of select="translate(marc:subfield[@code='a'],':;','')"/></marc:subfield>
				<xsl:if test="marc:subfield[@code='b']">
					<marc:subfield code="c"><xsl:value-of select="translate(marc:subfield[@code='b'],';','')"/></marc:subfield>
				</xsl:if>
				<marc:subfield code="d"><xsl:value-of select="translate(marc:subfield[@code='c'],'.+','')"/></marc:subfield>
				<xsl:if test="marc:subfield[@code='e']">
					<marc:subfield code="e"><xsl:value-of select="marc:subfield[@code='e']"/></marc:subfield>
				</xsl:if>
			</xsl:for-each>
		</marc:datafield>
	</xsl:template>
	<xsl:template name="series-statement0">
		<marc:datafield tag="225" ind1="2" ind2=" ">
			<xsl:choose>
				<xsl:when test="contains(marc:subfield[@code='a'],'.')">
					<xsl:choose>
						<xsl:when test="contains(marc:subfield[@code='a'],',')">
							<marc:subfield code="a"><xsl:value-of select="substring-before(marc:subfield[@code='a'],'.')" /></marc:subfield>
							<marc:subfield code="h">
								<xsl:value-of select="translate(substring(marc:subfield[@code='a'],string-length(substring-before(marc:subfield[@code='a'],'.'))+2,string-length(substring-before(marc:subfield[@code='a'],','))-string-length(substring-before(marc:subfield[@code='a'],'.'))),',','')" />
							</marc:subfield>
							<marc:subfield code="i">
								<xsl:value-of select="translate(substring(marc:subfield[@code='a'],string-length(substring-before(marc:subfield[@code='a'],','))+2,string-length(substring-before(marc:subfield[@code='a'],';'))-string-length(substring-before(marc:subfield[@code='a'],','))),';','')" />
							</marc:subfield>
						</xsl:when>
						<xsl:otherwise>
							<marc:subfield code="a"><xsl:value-of select="translate(marc:subfield[@code='a'],';','')" /></marc:subfield>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<marc:subfield code="a"><xsl:value-of select="substring-before(marc:subfield[@code='a'],';')" /></marc:subfield>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="marc:subfield[@code='v']">
				<marc:subfield code="v"><xsl:value-of select="marc:subfield[@code='v']" /></marc:subfield>
			</xsl:if>
		</marc:datafield>
	</xsl:template>
	<xsl:template name="series-statement1">
		<marc:datafield tag="225" ind1="2" ind2=" ">
			<marc:subfield code="a"><xsl:value-of select="translate(marc:subfield[@code='a'],';.','')" /></marc:subfield>
			<xsl:if test="marc:subfield[@code='n']">
				<marc:subfield code="h"><xsl:value-of select="translate(marc:subfield[@code='n'],',;','')" /></marc:subfield>
			</xsl:if>
			<xsl:if test="marc:subfield[@code='p']">
				<marc:subfield code="i"><xsl:value-of select="translate(marc:subfield[@code='p'],';','')" /></marc:subfield>
			</xsl:if>
			<xsl:if test="marc:subfield[@code='v']">
				<marc:subfield code="v"><xsl:value-of select="translate(marc:subfield[@code='v'],'.','')" /></marc:subfield>
			</xsl:if>
		</marc:datafield>
	</xsl:template>	
	<xsl:template name="transform-note">
		<marc:datafield tag="300" ind1=" " ind2=" ">
			<marc:subfield code="a"><xsl:value-of select="translate(marc:subfield[@code='a'],',.','，。')"/></marc:subfield>
		</marc:datafield>
	</xsl:template>
	<xsl:template name="contents-note">
		<xsl:choose>
			<xsl:when test="ind1='0'">
				<marc:datafield tag="327" ind1="1" ind2=" ">
					<xsl:choose>
						<xsl:when test="marc:subfield[@code='t']">
							<xsl:for-each select="marc:subfield[@code='t']">
								<marc:subfield code="a"><xsl:value-of select="translate(.,'-','')"/></marc:subfield>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']"/></marc:subfield>												
						</xsl:otherwise>
					</xsl:choose>
				</marc:datafield>
			</xsl:when>
			<xsl:otherwise>
				<marc:datafield tag="327" ind1="0" ind2=" ">
					<xsl:choose>
						<xsl:when test="marc:subfield[@code='t']">
							<xsl:for-each select="marc:subfield[@code='t']">
								<marc:subfield code="a"><xsl:value-of select="translate(.,'-','')"/></marc:subfield>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<marc:subfield code="a"><xsl:value-of select="marc:subfield[@code='a']"/></marc:subfield>												
						</xsl:otherwise>
					</xsl:choose>										
				</marc:datafield>
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>	
	<xsl:template name="transform-summary">
		<marc:datafield tag="330" ind1=" " ind2=" ">
			<marc:subfield code="a"><xsl:value-of select="translate(marc:subfield[@code='a'],',.','，。')"/></marc:subfield>
		</marc:datafield>
	</xsl:template>	
	<xsl:template name="uniform-title">
		<marc:datafield tag="500" ind1="1" ind2="0"><xsl:call-template name="title"/></marc:datafield>
	</xsl:template>
	<xsl:template name="title">
		<marc:subfield code="a"><xsl:value-of select="translate(marc:subfield[@code='a'],'.','')"/></marc:subfield>
		<xsl:if test="marc:subfield[@code='n']">
			<marc:subfield code="h"><xsl:value-of select="translate(marc:subfield[@code='n'],',.','')" /></marc:subfield>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='p']">
			<marc:subfield code="i"><xsl:value-of select="translate(marc:subfield[@code='p'],'.','')" /></marc:subfield>
		</xsl:if>	
	</xsl:template>
	<xsl:template name="transform-title">
		<marc:subfield code="a"><xsl:value-of select="translate(marc:subfield[@code='a'],':.,','')"/></marc:subfield>
		<xsl:if test="marc:subfield[@code='b']">
			<marc:subfield code="e"><xsl:value-of select="translate(marc:subfield[@code='b'],'.','')"/></marc:subfield>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='n']">
			<marc:subfield code="h"><xsl:value-of select="translate(marc:subfield[@code='n'],',','')"/></marc:subfield>
		</xsl:if>	
		<xsl:if test="marc:subfield[@code='p']">
			<marc:subfield code="i"><xsl:value-of select="marc:subfield[@code='p']"/></marc:subfield>
		</xsl:if>	
	</xsl:template>	
	<xsl:template name="other-title">
		<xsl:param name="indicator"/>
		<xsl:param name="dsttag"/>
		<xsl:param name="type"/>
		<xsl:param name="type2"/>
		<xsl:variable name="s246" select="marc:datafield[@tag='246']"/>	
		<xsl:variable name="s880" select="marc:datafield[@tag='880']"/>	
		<xsl:for-each select="$s246[@ind1='3'][@ind2=$indicator]">
			<xsl:choose>
				<xsl:when test="marc:subfield[@code='6']"/>
				<xsl:otherwise>
					<marc:datafield tag="{$dsttag}" ind1="1" ind2=" "><xsl:call-template name="transform-title"/></marc:datafield>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<xsl:for-each select="$s880[@ind1='3'][@ind2=$indicator]">
			<marc:datafield tag="{$dsttag}" ind1="1" ind2=" "><xsl:call-template name="transform-title"/></marc:datafield>
		</xsl:for-each>
		<xsl:for-each select="$s246[@ind1='1'][@ind2=' ']">
			<xsl:if test="contains(marc:subfield[@code='i'],$type)">
				<xsl:choose>
					<xsl:when test="marc:subfield[@code='6']"/>
					<xsl:otherwise>
						<marc:datafield tag="{$dsttag}" ind1="1" ind2=" "><xsl:call-template name="transform-title"/></marc:datafield>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="$s880[@ind1='1'][@ind2=' ']">
			<xsl:if test="contains(marc:subfield[@code='i'],$type)">
				<marc:datafield tag="{$dsttag}" ind1="1" ind2=" "><xsl:call-template name="transform-title"/></marc:datafield>
			</xsl:if>
		</xsl:for-each>		
		<xsl:for-each select="$s246[@ind1='1'][@ind2=' ']">
			<xsl:if test="contains(marc:subfield[@code='i'],$type2)">
				<xsl:choose>
					<xsl:when test="marc:subfield[@code='6']"/>
					<xsl:otherwise>
						<marc:datafield tag="{$dsttag}" ind1="1" ind2=" "><xsl:call-template name="transform-title"/></marc:datafield>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="$s880[@ind1='1'][@ind2=' ']">
			<xsl:if test="contains(marc:subfield[@code='i'],$type2)">
				<marc:datafield tag="{$dsttag}" ind1="1" ind2=" "><xsl:call-template name="transform-title"/></marc:datafield>
			</xsl:if>
		</xsl:for-each>			
	</xsl:template>	
	<xsl:template name="analytical-title">
		<xsl:if test="marc:subfield[@code='t']">
			<xsl:for-each select="marc:subfield[@code='t']">
				<marc:datafield tag="517" ind1="1" ind2=" ">
					<marc:subfield code="a"><xsl:value-of select="translate(.,'-.','')"/></marc:subfield>
				</marc:datafield>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>	
	<xsl:template name="transform-person">
		<marc:subfield code="a">
			<xsl:value-of select="substring(marc:subfield[@code='a'],1,string-length(marc:subfield[@code='a'])-1)" />
		</marc:subfield>
		<xsl:for-each select="marc:subfield[@code='d']">
			<marc:subfield code="f"><xsl:value-of select="translate(.,',','')" /></marc:subfield>
		</xsl:for-each>
		<xsl:for-each select="marc:subfield[@code='e']">
			<marc:subfield code="4"><xsl:value-of select="translate(.,',.','')" /></marc:subfield>
		</xsl:for-each>		
	</xsl:template>
	<xsl:template name="transform-organization">
		<xsl:attribute name="ind1">0</xsl:attribute>
		<xsl:attribute name="ind2"><xsl:value-of select="@ind1" /></xsl:attribute>
		<marc:subfield code="a">
			<xsl:value-of select="substring(marc:subfield[@code='a'],1,string-length(marc:subfield[@code='a'])-1)" />
		</marc:subfield>
		<xsl:for-each select="marc:subfield[@code='b']">
			<marc:subfield code="b"><xsl:value-of select="substring(.,1,string-length(.)-1)" /></marc:subfield>
		</xsl:for-each>
		<xsl:for-each select="marc:subfield[@code='e']">
			<marc:subfield code="4"><xsl:value-of select="translate(.,',.','')" /></marc:subfield>
		</xsl:for-each>	
	</xsl:template>
	<xsl:template name="transform-meeting">
		<xsl:attribute name="ind1">1</xsl:attribute>
		<xsl:attribute name="ind2"><xsl:value-of select="@ind1" /></xsl:attribute>
		<marc:subfield code="a">
			<xsl:value-of select="substring(marc:subfield[@code='a'],1,string-length(marc:subfield[@code='a'])-1)" />
		</marc:subfield>
		<xsl:for-each select="marc:subfield[@code='n']">
			<marc:subfield code="d"><xsl:value-of select="substring(.,1,string-length(.)-1)" /></marc:subfield>
		</xsl:for-each>
		<xsl:for-each select="marc:subfield[@code='c']">
			<marc:subfield code="e"><xsl:value-of select="translate(.,',.','')" /></marc:subfield>
		</xsl:for-each>		
		<xsl:for-each select="marc:subfield[@code='d']">
			<marc:subfield code="f"><xsl:value-of select="translate(.,',.','')" /></marc:subfield>
		</xsl:for-each>		
	</xsl:template>	
	<xsl:template name="transform-100-700-1">
		<xsl:variable name="s100" select="marc:datafield[@tag='100']"/>
		<xsl:variable name="s700" select="marc:datafield[@tag='700']"/>
		<xsl:variable name="s880" select="marc:datafield[@tag='880']"/>
		<xsl:variable name="No1-700" select="substring-after($s700[1]/marc:subfield[@code='6'],'-')"/>
		<xsl:variable name="No2-700" select="substring-after($s700[2]/marc:subfield[@code='6'],'-')"/>
		<xsl:variable name="No3-700" select="substring-after($s700[3]/marc:subfield[@code='6'],'-')"/>
		<xsl:choose>
			<xsl:when test="$s100">
				<xsl:for-each select="$s100">
					<xsl:choose>
						<xsl:when test="contains($s880[1]/marc:subfield[@code='6'],'100')"/>
						<xsl:otherwise>
							<marc:datafield tag="701" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<xsl:for-each select="$s880">
					<xsl:if test="contains(marc:subfield[@code='6'],'100')">
						<marc:datafield tag="701" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="$s880">
					<xsl:if test="substring-before(substring-after(marc:subfield[@code='6'],'-'),'/')=$No1-700">
						<marc:datafield tag="701" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>									
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each select="$s700[1]">
					<xsl:choose>
						<xsl:when test="marc:subfield[@code='6']"/>
						<xsl:otherwise>
							<marc:datafield tag="701" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="transform-700-2-3">
		<xsl:variable name="s100" select="marc:datafield[@tag='100']"/>
		<xsl:variable name="s700" select="marc:datafield[@tag='700']"/>
		<xsl:variable name="s880" select="marc:datafield[@tag='880']"/>
		<xsl:variable name="No1-700" select="substring-after($s700[1]/marc:subfield[@code='6'],'-')"/>
		<xsl:variable name="No2-700" select="substring-after($s700[2]/marc:subfield[@code='6'],'-')"/>
		<xsl:variable name="No3-700" select="substring-after($s700[3]/marc:subfield[@code='6'],'-')"/>	
		<xsl:choose>
			<xsl:when test="$s100">
				<xsl:for-each select="$s880">
					<xsl:if test="substring-before(substring-after(marc:subfield[@code='6'],'-'),'/')=$No1-700">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='e'][1]=$s100/marc:subfield[@code='e'][1]">
								<marc:datafield tag="701" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
							</xsl:when>
							<xsl:otherwise>
								<marc:datafield tag="702" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each select="$s700[1]">
					<xsl:choose>
						<xsl:when test="marc:subfield[@code='6']"/>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="marc:subfield[@code='e'][1]=$s100/marc:subfield[@code='e'][1]">
									<marc:datafield tag="701" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
								</xsl:when>
								<xsl:otherwise>
									<marc:datafield tag="702" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>									
				<xsl:for-each select="$s880">
					<xsl:if test="substring-before(substring-after(marc:subfield[@code='6'],'-'),'/')=$No2-700">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='e'][1]=$s100/marc:subfield[@code='e'][1]">
								<marc:datafield tag="701" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
							</xsl:when>
							<xsl:otherwise>
								<marc:datafield tag="702" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each select="$s700[2]">
					<xsl:choose>
						<xsl:when test="marc:subfield[@code='6']"/>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="marc:subfield[@code='e'][1]=$s100/marc:subfield[@code='e'][1]">
									<marc:datafield tag="701" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
								</xsl:when>
								<xsl:otherwise>
									<marc:datafield tag="702" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>									
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="$s880">
					<xsl:if test="substring-before(substring-after(marc:subfield[@code='6'],'-'),'/')=$No2-700">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='e'][1]=$s700[1]/marc:subfield[@code='e'][1]">
								<marc:datafield tag="701" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
							</xsl:when>
							<xsl:otherwise>
								<marc:datafield tag="702" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each select="$s700[2]">
					<xsl:choose>
						<xsl:when test="marc:subfield[@code='6']"/>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="marc:subfield[@code='e'][1]=$s700[1]/marc:subfield[@code='e'][1]">
									<marc:datafield tag="701" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
								</xsl:when>
								<xsl:otherwise>
									<marc:datafield tag="702" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>									
				<xsl:for-each select="$s880">
					<xsl:if test="substring-before(substring-after(marc:subfield[@code='6'],'-'),'/')=$No3-700">
						<xsl:choose>
							<xsl:when test="marc:subfield[@code='e'][1]=$s700[1]/marc:subfield[@code='e'][1]">
								<marc:datafield tag="701" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
							</xsl:when>
							<xsl:otherwise>
								<marc:datafield tag="702" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each select="$s700[3]">
					<xsl:choose>
						<xsl:when test="marc:subfield[@code='6']"/>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="marc:subfield[@code='e'][1]=$s700[1]/marc:subfield[@code='e'][1]">
									<marc:datafield tag="701" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
								</xsl:when>
								<xsl:otherwise>
									<marc:datafield tag="702" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>
	<xsl:template name="transform-700-4">
		<xsl:variable name="s100" select="marc:datafield[@tag='100']"/>
		<xsl:variable name="s700" select="marc:datafield[@tag='700']"/>
		<xsl:variable name="s880" select="marc:datafield[@tag='880']"/>
		<xsl:variable name="No1-700" select="substring-after($s700[1]/marc:subfield[@code='6'],'-')"/>
		<xsl:variable name="No2-700" select="substring-after($s700[2]/marc:subfield[@code='6'],'-')"/>
		<xsl:variable name="No3-700" select="substring-after($s700[3]/marc:subfield[@code='6'],'-')"/>
		<xsl:for-each select="$s880">
			<xsl:if test="contains(marc:subfield[@code='6'],'700')">
				<xsl:choose>
					<xsl:when test="$s100">
						<xsl:choose>
							<xsl:when test="substring-before(substring-after(marc:subfield[@code='6'],'-'),'/')=$No1-700"/>
							<xsl:when test="substring-before(substring-after(marc:subfield[@code='6'],'-'),'/')=$No2-700"/>
							<xsl:otherwise>
								<marc:datafield tag="702" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="substring-before(substring-after(marc:subfield[@code='6'],'-'),'/')=$No1-700"/>
							<xsl:when test="substring-before(substring-after(marc:subfield[@code='6'],'-'),'/')=$No2-700"/>
							<xsl:when test="substring-before(substring-after(marc:subfield[@code='6'],'-'),'/')=$No3-700"/>
							<xsl:otherwise>
								<marc:datafield tag="702" ind1=" " ind2="0"><xsl:call-template name="transform-person"/></marc:datafield>
							</xsl:otherwise>
						</xsl:choose>											
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>	
		</xsl:for-each>		
	</xsl:template>
	<xsl:template name="transform-110">
		<xsl:variable name="s110" select="marc:datafield[@tag='110']"/>
		<xsl:variable name="s880" select="marc:datafield[@tag='880']"/>
		<xsl:for-each select="$s880">
			<xsl:if test="contains(marc:subfield[@code='6'],'110')">
				<marc:datafield tag="711"><xsl:call-template name="transform-organization"/></marc:datafield>
			</xsl:if>									
		</xsl:for-each>
		<xsl:for-each select="$s110">
			<xsl:choose>
				<xsl:when test="marc:subfield[@code='6']"/>
				<xsl:otherwise>
					<marc:datafield tag="711"><xsl:call-template name="transform-organization"/></marc:datafield>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>	
	</xsl:template>
	<xsl:template name="transform-111">
		<xsl:variable name="s111" select="marc:datafield[@tag='111']"/>
		<xsl:variable name="s880" select="marc:datafield[@tag='880']"/>		
		<xsl:for-each select="$s880">
			<xsl:if test="contains(marc:subfield[@code='6'],'111')">
				<marc:datafield tag="711"><xsl:call-template name="transform-organization"/></marc:datafield>
			</xsl:if>									
		</xsl:for-each>
		<xsl:for-each select="$s111">
			<xsl:choose>
				<xsl:when test="marc:subfield[@code='6']"/>
				<xsl:otherwise>
					<marc:datafield tag="711"><xsl:call-template name="transform-organization"/></marc:datafield>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>	
	</xsl:template>
	<xsl:template name="transform-710">
		<xsl:variable name="s710" select="marc:datafield[@tag='710']"/>
		<xsl:variable name="s880" select="marc:datafield[@tag='880']"/>
		<xsl:for-each select="$s880">
			<xsl:if test="contains(marc:subfield[@code='6'],'710')">
				<marc:datafield tag="712" ind1="0" ind2="2"><xsl:call-template name="transform-organization"/></marc:datafield>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="$s710">
			<xsl:choose>
				<xsl:when test="marc:subfield[@code='6']"/>
				<xsl:otherwise>
					<marc:datafield tag="712" ind1="0" ind2="2"><xsl:call-template name="transform-organization"/></marc:datafield>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>	
	</xsl:template>
</xsl:stylesheet>
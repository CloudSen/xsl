<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    /**
     * 
     * <cqh工卡>
     * @author [011096] yangyunsen@czy.inner.com
     * @see [jobcard.dtd]
     * @date 2017/8/3 17:30
     * @version 1.0
     * @Description 解析cqh task
     */
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:lxslt="http://xml.apache.org/xslt"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions">
    <xsl:output method="html" indent="yes" encoding="utf-8"/>
    
    <xsl:template match="subtask">
        <div class="subtask-effect">
            <xsl:apply-templates select="effect"></xsl:apply-templates>
        </div>
        <!-- 工卡号 -->
        <div class="subtask-jcNo">
            <p>
                <xsl:text>SUBTASK&#160;</xsl:text>
                <xsl:value-of select="./@chapnbr"/>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="./@sectnbr"/>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="./@subjnbr"/>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="./@func"/>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="./@seq"/>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="./@confltr"/>
            </p>
        </div>
        <xsl:apply-templates select="sign | chgdesc | list1 | deleted
            | warning | warning-zh | caution | caution-zh
            | cqh-warning | cqh-warning-zh | cqh-caution | cqh-caution-zh
            | refblock | grphcref | refext | refint
            | para | table | unlist | numlist |  note | note-zh |  cqh-note | cqh-note-zh | input 
            | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action"></xsl:apply-templates>
    </xsl:template>

    <!-- 显示Topic的模板 -->
    <xsl:template match="topic">
        <!-- 显示topic -->
        <xsl:element name="div">
            <xsl:attribute name="class">topicDiv</xsl:attribute>
            <xsl:element name="div">
                <xsl:attribute name="class">topicSeq</xsl:attribute>
                <xsl:if test="title='Job Set-up'">
                    <xsl:text>1.</xsl:text>
                </xsl:if>
                <xsl:if test="title='Procedure'">
                    <xsl:text>2.</xsl:text>
                </xsl:if>
                <xsl:if test="title='Close-up'">
                    <xsl:text>3.</xsl:text>
                </xsl:if>
            </xsl:element>
            <!-- 显示topic的标题 -->
            <xsl:apply-templates select="title | title-zh | effect
                | warning | warning-zh | caution | caution-zh
                | cqh-warning | cqh-warning-zh | cqh-caution | cqh-caution-zh
                | refblock | grphcref | refext | refint"/>
        </xsl:element>
    </xsl:template>

    <!-- title模板 -->
    <xsl:template match="title">
        <div class="title">
            <xsl:choose>
                <xsl:when test="local-name(parent::node()) = 'topic'">
                    <u><xsl:value-of select="."/></u>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <!-- title-zh模板 -->
    <xsl:template match="title-zh">
        <div class="title-zh">
            <xsl:choose>
                <xsl:when test="local-name(parent::node()) = 'topic'">
                    <u><xsl:value-of select="."/></u>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <!-- grphcref模板 -->
    <xsl:template match="grphcref">
        <div style="width:558px;">
            <span>(</span>
            <xsl:choose>
                <xsl:when test="../@lang = 'zh'">
                    <xsl:text>参考.</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>Ref.</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:element name="a">
                <xsl:attribute name="class">
                    <xsl:text>img</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text>
                    <xsl:value-of select="@refid"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
            <span>)</span><br/>
        </div>
    </xsl:template>
    
    <!-- 标题遍历模板 -->
    <xsl:template match="list1">
        <xsl:element name="div">
            <xsl:attribute name="class">list1Div</xsl:attribute>
            <div class="list1Others">
                <xsl:apply-templates select="effect | ltitle | ltitle-zh | cqh-action  | cqh-condition | cqh-result  | table"></xsl:apply-templates>
            </div>
            <div class="list1Content">
                <xsl:apply-templates select="l1item | sign | cqh-judge"></xsl:apply-templates>
                <!-- <ol start="1" type="1">
                    <xsl:for-each select="./l1item">
                        <div class="l1item">
                            <xsl:choose>
                                <xsl:when test="parent::sign">
                                    <xsl:call-template name="signCommon"></xsl:call-template>
                                    <li><xsl:call-template name="content"></xsl:call-template></li>
                                </xsl:when>
                                <xsl:when test="parent::cqh-judge">
                                    <xsl:choose>
                                        <xsl:when test="ancestor-or-self::sign">
                                            <xsl:call-template name="signCommon"></xsl:call-template>
                                            <li><xsl:call-template name="content"></xsl:call-template></li>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <li><xsl:call-template name="l1item"></xsl:call-template></li>
                                        </xsl:otherwise>
                                    </xsl:choose>                            
                                </xsl:when>
                                <xsl:otherwise>
                                    <li><xsl:call-template name="l1item"></xsl:call-template></li>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>
                    </xsl:for-each>
                </ol> -->
            </div>
        </xsl:element>
    </xsl:template>
    <!-- l1item一级标题模板 -->
    <xsl:template match="l1item" name="l1item">
        <xsl:call-template name="getIndexL1item">
            <xsl:with-param name="elemName" select="name()"/>
        </xsl:call-template>
        <xsl:apply-templates select=" warning | warning-zh | note | note-zh | caution 
            | caution-zh | cqh-note | cqh-note-zh | cqh-caution | cqh-caution-zh
            | cqh-warning | cqh-warning-zh
            | para | table | list2 | cqh-action | unlist | numlist | cblst 
            | input | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action | sign"></xsl:apply-templates>
    </xsl:template>
    <!-- list2模板 -->
    <xsl:template match="list2">
        <xsl:element name="div">
            <xsl:attribute name="class">list2Div</xsl:attribute>
            <div class="list2Others">
                <xsl:apply-templates select="effect | ltitle | ltitle-zh | cqh-action | table"></xsl:apply-templates>
            </div>
            <div class="list2Content">
                <xsl:apply-templates select="l2item | sign | cqh-judge"></xsl:apply-templates>
                <!-- <ol start="a" type="a">
                    <xsl:for-each select="./l2item">
                        <div class="l2item">
                            <xsl:choose>
                                <xsl:when test="parent::sign">
                                    <xsl:call-template name="signCommon"></xsl:call-template>
                                    <li><xsl:call-template name="content"></xsl:call-template></li>
                                </xsl:when>
                                <xsl:when test="parent::cqh-judge">
                                    <xsl:choose>
                                        <xsl:when test="ancestor-or-self::sign">
                                            <xsl:call-template name="signCommon"></xsl:call-template>
                                            <li><xsl:call-template name="content"></xsl:call-template></li>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <li><xsl:call-template name="l2item"></xsl:call-template></li>
                                        </xsl:otherwise>
                                    </xsl:choose>                            
                                </xsl:when>
                                <xsl:otherwise>
                                    <li><xsl:call-template name="l2item"></xsl:call-template></li>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>
                    </xsl:for-each>
                </ol> -->
            </div>
                <!--  
                <xsl:apply-templates select="effect | ltitle | ltitle-zh | cqh-action | cqh-judge | cqh-condition | cqh-result  | table"></xsl:apply-templates>
                -->
        </xsl:element>
    </xsl:template>
    <!-- l2item模板 -->
    <xsl:template match="l2item" name="l2item">
        <xsl:call-template name="getIndexL2item">
            <xsl:with-param name="elemName" select="name()"/>
        </xsl:call-template>
        <xsl:apply-templates select=" warning | warning-zh | note | note-zh | caution 
            | caution-zh | cqh-note | cqh-note-zh | cqh-caution | cqh-caution-zh
            | cqh-warning | cqh-warning-zh
            | para | table | list3 | cqh-action | unlist | numlist | cblst 
            | input | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action | sign"></xsl:apply-templates>
    </xsl:template>
    <!-- list3模板 -->
    <xsl:template match="list3">
        <xsl:element name="div">
            <xsl:attribute name="class">list3Div</xsl:attribute>
            <div class="list3Others">
                <xsl:apply-templates select="effect | ltitle | ltitle-zh | cqh-action | cqh-judge | cqh-condition | cqh-result   | table"></xsl:apply-templates>
            </div>
            <div class="list3Content">
                <xsl:apply-templates select="l3item | sign | cqh-judge"></xsl:apply-templates>
                <!-- <ol class="list3ol" start="1" type="1">
                    <xsl:for-each select="./l3item">
                        <div class="l3item">
                            <xsl:choose>
                                <xsl:when test="parent::sign">
                                    <xsl:call-template name="signCommon"></xsl:call-template>
                                    <li class="list3li"><xsl:call-template name="content"></xsl:call-template></li>
                                </xsl:when>
                                <xsl:when test="parent::cqh-judge">
                                    <xsl:choose>
                                        <xsl:when test="ancestor-or-self::sign">
                                            <xsl:call-template name="signCommon"></xsl:call-template>
                                            <li class="list3li"><xsl:call-template name="content"></xsl:call-template></li>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <li class="list3li"><xsl:call-template name="l3item"></xsl:call-template></li>
                                        </xsl:otherwise>
                                    </xsl:choose>                            
                                </xsl:when>
                                <xsl:otherwise>
                                    <li class="list3li"><xsl:call-template name="l3item"></xsl:call-template></li>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>
                    </xsl:for-each>
                </ol> -->
            </div>
        </xsl:element>
    </xsl:template>
    <!-- l3item模板 -->
    <xsl:template match="l3item" name="l3item">
        <xsl:apply-templates select=" warning | warning-zh | note | note-zh | caution 
            | caution-zh | cqh-note | cqh-note-zh | cqh-caution | cqh-caution-zh
            | cqh-warning | cqh-warning-zh
            | para | table | list4 | cqh-action | unlist | numlist | cblst 
            | input | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action | sign"></xsl:apply-templates>
    </xsl:template>
    <!-- list4....5....6...7的模板 -->
    <xsl:template match="list4">
        <xsl:element name="div">
            <xsl:attribute name="class">list4Div</xsl:attribute>
            <div class="list4Others">
                <xsl:apply-templates select="effect | ltitle | ltitle-zh | cqh-action | cqh-judge | cqh-condition | cqh-result   | table"></xsl:apply-templates>
            </div>
            <div class="list4Content">
                <xsl:apply-templates select="l4item | sign | cqh-judge"></xsl:apply-templates>
                <!-- <ol class="list4ol" start="a" type="a">
                    <xsl:for-each select="./l4item">
                        <div class="l4item">
                            <xsl:choose>
                                <xsl:when test="parent::sign">
                                    <xsl:call-template name="signCommon"></xsl:call-template>
                                    <li class="list4li"><xsl:call-template name="content"></xsl:call-template></li>
                                </xsl:when>
                                <xsl:when test="parent::cqh-judge">
                                    <xsl:choose>
                                        <xsl:when test="ancestor-or-self::sign">
                                            <xsl:call-template name="signCommon"></xsl:call-template>
                                            <li class="list4li"><xsl:call-template name="content"></xsl:call-template></li>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <li class="list4li"><xsl:call-template name="l4item"></xsl:call-template></li>
                                        </xsl:otherwise>
                                    </xsl:choose>                            
                                </xsl:when>
                                <xsl:otherwise>
                                    <li class="list4li"><xsl:call-template name="l4item"></xsl:call-template></li>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>
                    </xsl:for-each>
                </ol>-->
            </div>
        </xsl:element>
    </xsl:template>
    <xsl:template match="l4item" name="l4item">
        <xsl:apply-templates select=" warning | warning-zh | note | note-zh | caution 
            | caution-zh | cqh-note | cqh-note-zh | cqh-caution | cqh-caution-zh
            | cqh-warning | cqh-warning-zh
            | para | table | list5 | cqh-action | unlist | numlist | cblst 
            | input | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action | sign"></xsl:apply-templates>
    </xsl:template>
    <xsl:template match="list5">
        <xsl:element name="div">
            <xsl:attribute name="class">list5Div</xsl:attribute>
            <div class="list5Others">
                <xsl:apply-templates select="effect | ltitle | ltitle-zh | cqh-action  | cqh-condition | cqh-result  | table"></xsl:apply-templates>
            </div>
            <div class="list5Content">
                <xsl:apply-templates select="l5item | sign | cqh-judge"></xsl:apply-templates>
                <!-- <ol class="list5ol">
                    <xsl:for-each select="./l5item">
                        <div class="l5item">
                            <xsl:choose>
                                <xsl:when test="parent::sign">
                                    <xsl:call-template name="signCommon"></xsl:call-template>
                                    <li class="list5li" ><xsl:call-template name="content"></xsl:call-template></li>
                                </xsl:when>
                                <xsl:when test="parent::cqh-judge">
                                    <xsl:choose>
                                        <xsl:when test="ancestor-or-self::sign">
                                            <xsl:call-template name="signCommon"></xsl:call-template>
                                            <li class="list5li"><xsl:call-template name="content"></xsl:call-template></li>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <li class="list5li"><xsl:call-template name="l5item"></xsl:call-template></li>
                                        </xsl:otherwise>
                                    </xsl:choose>                            
                                </xsl:when>
                                <xsl:otherwise>
                                    <li class="list5li"><xsl:call-template name="l5item"></xsl:call-template></li>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>
                    </xsl:for-each>
                </ol>-->
            </div>
                <!--
                <xsl:apply-templates select="effect | ltitle | ltitle-zh | cqh-action | cqh-judge | cqh-condition | cqh-result | sign  | table"></xsl:apply-templates>
                -->
        </xsl:element>
    </xsl:template>
    <xsl:template match="l5item" name="l5item">
        <xsl:apply-templates select=" warning | warning-zh | note | note-zh | caution 
            | caution-zh | cqh-note | cqh-note-zh | cqh-caution | cqh-caution-zh
            | cqh-warning | cqh-warning-zh
            | para | table | list6 | cqh-action | unlist | numlist | cblst 
            | input | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action | sign"></xsl:apply-templates>
    </xsl:template>
    <xsl:template match="list6">
        <xsl:element name="div">
            <xsl:attribute name="class">list6Div</xsl:attribute>
            <div class="list6Others">
                <xsl:apply-templates select="effect | ltitle | ltitle-zh | cqh-action  | cqh-condition | cqh-result   | table"></xsl:apply-templates>
            </div>
            <div class="list6Content">
                <xsl:apply-templates select="l6item | sign | cqh-judge"></xsl:apply-templates>
                <!-- <ol class="list6ol" start="1" type="1">
                    <xsl:for-each select="./l6item">
                        <div class="l6item">
                            <xsl:choose>
                                <xsl:when test="parent::sign">
                                    <xsl:call-template name="signCommon"></xsl:call-template>
                                    <li class="list6li" ><xsl:call-template name="content"></xsl:call-template></li>
                                </xsl:when>
                                <xsl:when test="parent::cqh-judge">
                                    <xsl:choose>
                                        <xsl:when test="ancestor-or-self::sign">
                                            <xsl:call-template name="signCommon"></xsl:call-template>
                                            <li class="list6li" ><xsl:call-template name="content"></xsl:call-template></li>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <li class="list6li" ><xsl:call-template name="l6item"></xsl:call-template></li>
                                        </xsl:otherwise>
                                    </xsl:choose>                            
                                </xsl:when>
                                <xsl:otherwise>
                                    <li class="list6li" ><xsl:call-template name="l6item"></xsl:call-template></li>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>
                    </xsl:for-each>
                </ol> -->
            </div>                
        </xsl:element>
    </xsl:template>
    <xsl:template match="l6item" name="l6item">
        <xsl:apply-templates select=" warning | warning-zh | note | note-zh | caution 
            | caution-zh | cqh-note | cqh-note-zh | cqh-caution | cqh-caution-zh
            | cqh-warning | cqh-warning-zh
            | para | table | list7 | cqh-action | unlist | numlist | cblst 
            | input | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action | sign"></xsl:apply-templates>
    </xsl:template>
    <xsl:template match="list7">
        <xsl:element name="div">
            <xsl:attribute name="class">list7Div</xsl:attribute>
            <div class="list7Others">
                <xsl:apply-templates select="effect | ltitle | ltitle-zh | cqh-action  | cqh-condition | cqh-result   | table"></xsl:apply-templates>
            </div>
            <div class="list7Content">
                <xsl:apply-templates select="l7item | sign | cqh-judge"></xsl:apply-templates>
                <!-- <ol class="list7ol" start="1" type="1">
                    <xsl:for-each select="./l7item">
                        <div class="l7item">
                            <xsl:choose>
                                <xsl:when test="parent::sign">
                                    <xsl:call-template name="signCommon"></xsl:call-template>
                                    <li class="list7li"><xsl:call-template name="content"></xsl:call-template></li>
                                </xsl:when>
                                <xsl:when test="parent::cqh-judge">
                                    <xsl:choose>
                                        <xsl:when test="ancestor-or-self::sign">
                                            <xsl:call-template name="signCommon"></xsl:call-template>
                                            <li class="list7li"><xsl:call-template name="content"></xsl:call-template></li>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <li class="list7li"><xsl:call-template name="l7item"></xsl:call-template></li>
                                        </xsl:otherwise>
                                    </xsl:choose>                            
                                </xsl:when>
                                <xsl:otherwise>
                                    <li class="list7li"><xsl:call-template name="l7item"></xsl:call-template></li>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>
                    </xsl:for-each>
                </ol> -->
            </div>
        </xsl:element>
    </xsl:template>
    <xsl:template match="l7item" name="l7item">
        <xsl:apply-templates select=" warning | warning-zh | note | note-zh | caution 
            | caution-zh | cqh-note | cqh-note-zh | cqh-caution | cqh-caution-zh
            | cqh-warning | cqh-warning-zh
            | para | table | cqh-action | unlist | numlist | cblst 
            | input | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action | sign"></xsl:apply-templates>
    </xsl:template>
  
    <!-- cqh-action模板 -->
    <xsl:template match="cqh-action">
        <xsl:choose>
            <xsl:when test="string(@val) = 'start'">
                <xsl:element name="img">
                    <xsl:attribute name="class">img</xsl:attribute>
                    <xsl:attribute name="src">img/judge_start.jpg</xsl:attribute>
                    <xsl:attribute name="width">100%</xsl:attribute>
                </xsl:element>
            </xsl:when>
            <xsl:when test="string(@val) = 'end'">
                <xsl:element name="img">
                    <xsl:attribute name="class">img</xsl:attribute>
                    <xsl:attribute name="src">img/judge_end.jpg</xsl:attribute>
                    <xsl:attribute name="width">100%</xsl:attribute>
                </xsl:element>
            </xsl:when>
        </xsl:choose>
        <xsl:apply-templates select="cb | con | csn | equ | grphcref
            | ein | einmfr | ncon | pan | refext | refint
            | sub | super | ted | toc | txtgrphc
            | std | zone| expd | stdname | tor 
            | table | para 
            | list1 |l1item | list2 |l2item | list3 |l3item | list4 |l4item | list5 |l5item
            | list6 |l6item | list7 |l7item | unlist | numlist 
            | note | note-zh | warning | warning-zh | caution | caution-zh
            | cqh-note | cqh-note-zh | cqh-warning| cqh-warning-zh | cqh-caution | cqh-caution-zh
            | sign |  cqh-judge | cqh-condition | cqh-result
            | refblock | toolnbr | refmedia 
            | grsymbol | tadetail |riskdetail| cqh-content"></xsl:apply-templates>
    </xsl:template>
    
    <!-- para模板 -->
    <xsl:template match="para">
        <xsl:choose>
            <!-- 有bold属性 -->
            <xsl:when test="@lang = 'bold'">
                <b><xsl:value-of select="."/></b>
            </xsl:when>
            <!-- 没有任何子标签 -->
            <xsl:when test="count(child::*)=0">
                <span><xsl:value-of select="."/><br/></span>
            </xsl:when>
            
            <!-- 包含参考的para -->
            <xsl:when test="./refblock">
                <span>
                    <xsl:value-of select="./text()"/>
                    <xsl:apply-templates select="refblock"></xsl:apply-templates>
                </span>
            </xsl:when>
            <!-- 含stdnamede的para -->
            <xsl:when test="./stdname">
                <span>
                    <xsl:copy-of select="self::node()"/><br/>
                </span>
            </xsl:when>
            <!-- 含con的para -->
            <xsl:when test="./con">
                <span>
                    <xsl:copy-of select="self::node()"/><br/>oooooooooooooooooooooooooo
                </span>
            </xsl:when>
            <!-- 含refext的para -->
            <xsl:when test="./refext">
                <span>
                    <xsl:value-of select="."/><br/>
                </span>
            </xsl:when>
            <!-- 含ein的para -->
            <xsl:when test="./ein">
                <xsl:value-of select="text()"/>
                <xsl:apply-templates select="ein"></xsl:apply-templates>
                <xsl:value-of select="substring-after(.,./ein)"/><br/>
            </xsl:when>
            <!-- 含pan的para -->
            <xsl:when test="./pan">
                <xsl:apply-templates select="pan"></xsl:apply-templates>
            </xsl:when>
            
            <xsl:when test="./con">
                <p><xsl:value-of select="."/><br/></p>
            </xsl:when>
            <!-- 包含tor的para -->
            <xsl:when test="./tor">
                <xsl:if test="normalize-space(@lang)='zh'">
                    <xsl:value-of select="."></xsl:value-of>  <br/>
                </xsl:if>
                <xsl:if test="normalize-space(@lang)!='zh'">
                    <xsl:value-of select="."></xsl:value-of>
                    <xsl:for-each select="./tor/torvalue">
                        <xsl:if test="position()=1"> 													
                            to between 	
                            <xsl:value-of select="./@min"/>
                            and 													
                            <xsl:value-of select="./@max"/> 													
                            <xsl:text> </xsl:text>								
                            <xsl:value-of select="./@unit"/> 												
                        </xsl:if> 												
                        <xsl:if test="position()!=1"> 													
                            ( 
                            <xsl:value-of select="./@min"/>
                            and
                            <xsl:value-of select="./@max"/>
                            <xsl:text> </xsl:text>	
                            <xsl:value-of select="./@unit"/> 
                            ) 
                        </xsl:if>  
                    </xsl:for-each>
                    <br/>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="refblock | stdname | refext| ein
                    | pan | grphcref | toolnbr"></xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- refblock模板 -->
    <xsl:template match="refblock">
        <xsl:apply-templates select="refint | refext | grphcref"></xsl:apply-templates>
    </xsl:template>
    
    <!-- refint模板 -->
    <xsl:template match="refint">
        <span>
            <xsl:text>(</xsl:text>
            <xsl:apply-templates select="effect"></xsl:apply-templates>
            <a class="ref">
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text>
                    <xsl:value-of select="./@refid"/>
                </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="../../@lang = 'zh'">
                        <xsl:text>参考.</xsl:text>
                        <xsl:text>TASK. </xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text>)。</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Ref.</xsl:text>
                        <xsl:text>TASK. </xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text>).</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </a>
        </span>
        <br/>
    </xsl:template>
    
    <!-- 有效性模板 -->
    <xsl:template match="effect">
        <xsl:call-template name="output-tokens">
            <xsl:with-param name="list" select="@effrg"/>
            <xsl:with-param name="separator" select="' '"></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <!-- stdname模板 -->
    <xsl:template match="stdname">
        <span>
            <xsl:value-of select="../text()"/>
            <xsl:value-of select="."/>
            <xsl:value-of select="substring-after(../.,.)"/>
        </span><br/>
    </xsl:template>
    
    <!-- refext模板 -->
    <xsl:template match="refext">
        <span>
            <xsl:value-of select="../text()"/>
            <xsl:value-of select="."/>
            <xsl:value-of select="substring-after(../.,.)"/>
        </span><br/>
    </xsl:template>
    
    <!-- ein模板 -->
    <xsl:template match="ein">
        <span>
            <xsl:text>FIN:</xsl:text>
            <xsl:value-of select="."/>
        </span>
    </xsl:template>
    
    <!-- unlist模板 -->
    <xsl:template match="unlist">
        <xsl:apply-templates select="unlitem"></xsl:apply-templates>
    </xsl:template>
    <!-- unlitem模板-->
    <xsl:template match="unlitem">
        <span>
            <xsl:text>-&#160;&#160;</xsl:text>
            <xsl:apply-templates select="para"></xsl:apply-templates>
        </span>
    </xsl:template>
    
    <!-- warning note caution等警告模板 模糊匹配 -->
    <xsl:template match="warning | warning-zh | note | note-zh | caution 
        | caution-zh | cqh-note | cqh-note-zh | cqh-caution | cqh-caution-zh
        | cqh-warning | cqh-warning-zh">
        <xsl:choose>
            <xsl:when test="self::warning">
                <xsl:element name="div">
                    <xsl:attribute name="class">warning warningContent</xsl:attribute>
                    <xsl:element name="p">
                        <span class="warning"><u><xsl:text>WARNING:</xsl:text></u></span>
                        <xsl:apply-templates select="para|unlist"></xsl:apply-templates>
                    </xsl:element>
                </xsl:element>  
            </xsl:when>
            <xsl:when test="self::warning-zh">
                <xsl:element name="div">
                    <xsl:attribute name="class">warning warningContent</xsl:attribute>
                    <xsl:element name="p">
                        <span class="warning"><u><xsl:text>警告:</xsl:text></u></span>
                        <xsl:apply-templates select="para|unlist"></xsl:apply-templates>
                    </xsl:element>
                </xsl:element>  
            </xsl:when>
            <xsl:when test="self::cqh-warning">
                <xsl:element name="div">
                    <xsl:attribute name="class">warning warningContent</xsl:attribute>
                    <xsl:element name="p">
                        <span class="warning"><u><xsl:text>CQH WARNING:</xsl:text></u></span>
                        <xsl:apply-templates select="para|unlist"></xsl:apply-templates>
                    </xsl:element>
                </xsl:element>  
            </xsl:when>
            <xsl:when test="self::cqh-warning-zh">
                <xsl:element name="div">
                    <xsl:attribute name="class">warning warningContent</xsl:attribute>
                    <xsl:element name="p">
                        <span class="warning"><u><xsl:text>春秋警告:</xsl:text></u></span>
                        <xsl:apply-templates select="para|unlist"></xsl:apply-templates>
                    </xsl:element>
                </xsl:element>  
            </xsl:when>
            <xsl:when test="self::note">
                <xsl:element name="div">
                    <xsl:attribute name="class">note warningContent</xsl:attribute>
                    <xsl:element name="p">
                        <span class="note"><u><xsl:text>NOTE:</xsl:text></u></span>
                        <xsl:apply-templates select="para|unlist"></xsl:apply-templates>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:when test="self::note-zh">
                <xsl:element name="div">
                    <xsl:attribute name="class">note warningContent</xsl:attribute>
                    <xsl:element name="p">
                        <span class="note"><u><xsl:text>注意:</xsl:text></u></span>
                        <xsl:apply-templates select="para|unlist"></xsl:apply-templates>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:when test="self::cqh-note">
                <xsl:element name="div">
                    <xsl:attribute name="class">note warningContent</xsl:attribute>
                    <xsl:element name="p">
                        <span class="note"><u><xsl:text>CQH NOTE:</xsl:text></u></span>
                        <xsl:apply-templates select="para|unlist"></xsl:apply-templates>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:when test="self::cqh-note-zh">
                <xsl:element name="div">
                    <xsl:attribute name="class">note warningContent</xsl:attribute>
                    <xsl:element name="p">
                        <span class="note"><u><xsl:text>春秋注意:</xsl:text></u></span>
                        <xsl:apply-templates select="para|unlist"></xsl:apply-templates>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:when test="self::caution">
                <xsl:element name="div">
                    <xsl:attribute name="class">caution warningContent</xsl:attribute>
                    <xsl:element name="p">
                        <span class="caution"><u><xsl:text>CAUTION:</xsl:text></u></span>
                        <xsl:apply-templates select="para|unlist"></xsl:apply-templates>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:when test="self::caution-zh">
                <xsl:element name="div">
                    <xsl:attribute name="class">caution warningContent</xsl:attribute>
                    <xsl:element name="p">
                        <span class="caution"><u><xsl:text>告诫:</xsl:text></u></span>
                        <xsl:apply-templates select="para|unlist"></xsl:apply-templates>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:when test="self::cqh-caution">
                <xsl:element name="div">
                    <xsl:attribute name="class">caution warningContent</xsl:attribute>
                    <xsl:element name="p">
                        <span class="caution"><u><xsl:text>CQH CAUTION:</xsl:text></u></span>
                        <xsl:apply-templates select="para|unlist"></xsl:apply-templates>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:when test="self::cqh-caution-zh">
                <xsl:element name="div">
                    <xsl:attribute name="class">caution warningContent</xsl:attribute>
                    <xsl:element name="p">
                        <span class="caution"><u><xsl:text>春秋告诫:</xsl:text></u></span>
                        <xsl:apply-templates select="para|unlist"></xsl:apply-templates>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- sign签署模板 -->
    <xsl:template match="sign">
        <div class="signContent">
            <!-- 签署单选框 -->
            <div class="radioDiv">
                <xsl:element name="input">
                    <xsl:attribute name="type">radio</xsl:attribute>
                    <xsl:attribute name="id"><xsl:value-of select="./@id"/></xsl:attribute>
                    <xsl:attribute name="name">radio_work</xsl:attribute>
                    <xsl:attribute name="signId"><xsl:value-of select="./mech/@authid"/></xsl:attribute>
                    <xsl:attribute name="isrii"><xsl:if test="string(./mech/@checklevel) = '' or string(./mech/@checklevel) = 'RCI'">N</xsl:if><xsl:if test="string(./mech/@checklevel) != '' and string(./mech/@checklevel) = 'RII'">Y</xsl:if></xsl:attribute>
                </xsl:element>
            </div>
            <!-- 签署详细信息 -->
            <div class="signDiv">
                <xsl:element name="span">
                    <xsl:attribute name="id">
                        <xsl:value-of select="./mech/@authid"/>
                    </xsl:attribute>
                    <xsl:text>授权：</xsl:text>
                    <xsl:value-of select="./mech/@authname"/><br/>
                </xsl:element>
                <xsl:element name="span">
                    <xsl:text>工作：</xsl:text>
                </xsl:element>
                <xsl:element name="input">
                    <xsl:attribute name="id">
                        <xsl:value-of select="concat(string(./@id),'_',string('workState'))"></xsl:value-of>
                    </xsl:attribute>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat(string(./@id),'_',string('workState'))"></xsl:value-of>
                    </xsl:attribute>
                    <xsl:attribute name="type">text</xsl:attribute>
                    <xsl:attribute name="value"></xsl:attribute>
                    <xsl:attribute name="class">input</xsl:attribute>
                    <xsl:attribute name="disabled">true</xsl:attribute>
                </xsl:element>
                <xsl:element name="span">
                    <xsl:text>工作者：</xsl:text>
                </xsl:element>
                <xsl:element name="input">
                    <xsl:attribute name="id">
                        <xsl:value-of select="concat(string(./@id),'_',string('worker'))"></xsl:value-of>
                    </xsl:attribute>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat(string(./@id),'_',string('worker'))"></xsl:value-of>
                    </xsl:attribute>
                    <xsl:attribute name="type"> <xsl:value-of select="./mech/mechname/input/@type"/></xsl:attribute>
                    <xsl:attribute name="value"> <xsl:value-of select="./mech/mechname/input/@value"/></xsl:attribute>
                    <xsl:attribute name="class">input</xsl:attribute>
                    <xsl:attribute name="disabled">true</xsl:attribute>
                </xsl:element>
                <xsl:element name="span">
                    <xsl:text>工作时间：</xsl:text>
                </xsl:element>
                <xsl:element name="input">
                    <xsl:attribute name="id">
                        <xsl:value-of select="concat(string(./@id),'_',string('workdate'))"></xsl:value-of>
                    </xsl:attribute>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat(string(./@id),'_',string('workdate'))"></xsl:value-of>
                    </xsl:attribute>
                    <xsl:attribute name="type"> <xsl:value-of select="./mech/mechdate/input/@type"/></xsl:attribute>
                    <xsl:attribute name="value"> <xsl:value-of select="./mech/mechdate/input/@value"/></xsl:attribute>
                    <xsl:attribute name="class">input</xsl:attribute>
                    <xsl:attribute name="disabled">true</xsl:attribute>
                </xsl:element><br/>
                    <!-- 判断是否有检验要求 -->
                <xsl:if test="string(./mech/@checklevel)!=''">
                    <xsl:element name="span">
                        <xsl:value-of select="./mech/@checklevel"/><xsl:text>:</xsl:text>
                    </xsl:element>
                    <xsl:element name="input">
                        <xsl:attribute name="id">
                            <xsl:value-of select="concat(string(./@id),'_',string('checkstate'))"></xsl:value-of>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:value-of select="concat(string(./@id),'_',string('checkstate'))"></xsl:value-of>
                        </xsl:attribute>
                        <xsl:attribute name="name">checkType</xsl:attribute>
                        <xsl:attribute name="type">text</xsl:attribute>
                        <xsl:attribute name="class">input</xsl:attribute>
                        <xsl:attribute name="disabled">true</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="span">
                        <xsl:text>检验者：</xsl:text>
                    </xsl:element>
                    <xsl:element name="input">
                        <xsl:attribute name="id">
                            <xsl:value-of select="concat(string(./@id),'_',string('checker'))"></xsl:value-of>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:value-of select="concat(string(./@id),'_',string('checker'))"></xsl:value-of>
                        </xsl:attribute>
                        <xsl:attribute name="type"> <xsl:value-of select="./insp/inspname/input/@type"/></xsl:attribute>
                        <xsl:attribute name="value"> <xsl:value-of select="./insp/inspname/input/@value"/></xsl:attribute>
                        <xsl:attribute name="class">input</xsl:attribute>
                        <xsl:attribute name="disabled">true</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="span">
                        <xsl:text>检验时间：</xsl:text>
                    </xsl:element>
                    <xsl:element name="input">
                        <xsl:attribute name="id">
                            <xsl:value-of select="concat(string(./@id),'_',string('checkdate'))"></xsl:value-of>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:value-of select="concat(string(./@id),'_',string('checkdate'))"></xsl:value-of>
                        </xsl:attribute>
                        <xsl:attribute name="type"> <xsl:value-of select="./insp/inspdate/input/@type"/></xsl:attribute>
                        <xsl:attribute name="value"> <xsl:value-of select="./insp/inspdate/input/@value"/></xsl:attribute>
                        <xsl:attribute name="class">input</xsl:attribute>
                        <xsl:attribute name="disabled">true</xsl:attribute>
                    </xsl:element>
                </xsl:if>
            </div>
            <div class="signDetail">
                <xsl:apply-templates select="mech | insp | list1 | list2 | list3 | list4 | list5| list6 | list7 
                    | l1item | l2item | l3item | l4item | l5item | l6item | l7item| note | note-zh | warning | warning-zh | caution | caution-zh
                    | cqh-note | cqh-note-zh | cqh-warning| cqh-warning-zh | cqh-caution | cqh-caution-zh
                    | sign | cqh-judge | cqh-condition | cqh-result | refblock | toolnbr | refmedia 
                    | cb | con | csn | equ | grphcref | cblst
                    | ein | einmfr | ncon | pan | refext | refint
                    | sub | super | ted | toc | txtgrphc
                    | std | zone| expd | stdname | tor 
                    | table | para | unlist | numlist
                    | grsymbol | tadetail | cqh-content|subtask|input"></xsl:apply-templates>
            </div>
        </div>
    </xsl:template>
    
    <!-- 签署模板 -->
    <xsl:template name="signCommon">
        <div class="signContent">
            <!-- 签署单选框 -->
            <div class="radioDiv">
                <xsl:element name="input">
                    <xsl:attribute name="type">radio</xsl:attribute>
                    <xsl:attribute name="id"><xsl:value-of select="./@id"/></xsl:attribute>
                    <xsl:attribute name="name">radio_work</xsl:attribute>
                </xsl:element>
            </div>
            <!-- 签署详细信息 -->
            <div class="signDiv">
                <div>
                    <xsl:element name="span">
                        <xsl:attribute name="id">
                            <xsl:value-of select="../mech/@authid | ../../mech/@authid"/>
                        </xsl:attribute>
                        <xsl:text>授权：</xsl:text>
                        <xsl:value-of select="../mech/@authname | ../../mech/@authname"/><br/>
                    </xsl:element>
                </div>
                <div>
                    <xsl:element name="span">
                        <xsl:text>工作：</xsl:text>
                    </xsl:element>
                    <xsl:element name="input">
                        <xsl:attribute name="id">workStatus</xsl:attribute>
                        <xsl:attribute name="name">workStatus</xsl:attribute>
                        <xsl:attribute name="type">text</xsl:attribute>
                        <xsl:attribute name="value"></xsl:attribute>
                        <xsl:attribute name="class">input</xsl:attribute>
                        <xsl:attribute name="disabled">true</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="span">
                        <xsl:text>工作者：</xsl:text>
                    </xsl:element>
                    <xsl:element name="input">
                        <xsl:attribute name="id"> <xsl:value-of select="../mech/mechname/input/@id | ../../mech/mechname/input/@id"/></xsl:attribute>
                        <xsl:attribute name="type"> <xsl:value-of select="../mech/mechname/input/@type | ../../mech/mechname/input/@type"/></xsl:attribute>
                        <xsl:attribute name="value"> <xsl:value-of select="../mech/mechname/input/@value | ../../mech/mechname/input/@value"/></xsl:attribute>
                        <xsl:attribute name="class">input</xsl:attribute>
                        <xsl:attribute name="disabled">true</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="span">
                        <xsl:text>工作时间：</xsl:text>
                    </xsl:element>
                    <xsl:element name="input">
                        <xsl:attribute name="id"> <xsl:value-of select="../mech/mechdate/input/@id | ../../mech/mechdate/input/@id"/></xsl:attribute>
                        <xsl:attribute name="type"> <xsl:value-of select="../mech/mechdate/input/@type | ../../mech/mechdate/input/@type"/></xsl:attribute>
                        <xsl:attribute name="value"> <xsl:value-of select="../mech/mechdate/input/@value | ../../mech/mechdate/input/@value"/></xsl:attribute>
                        <xsl:attribute name="class">input</xsl:attribute>
                        <xsl:attribute name="disabled">true</xsl:attribute>
                    </xsl:element>
                </div>
                <div>
                    <!-- 判断是否有检验要求 -->
                    <xsl:if test="string(../mech/@checklevel)!='' or string(../../mech/@checklevel)!='' ">
                        <xsl:element name="span">
                            <xsl:value-of select="./mech/@checklevel"/><xsl:text>:</xsl:text>
                        </xsl:element>
                        <xsl:element name="input">
                            <xsl:attribute name="id">checkType</xsl:attribute>
                            <xsl:attribute name="name">checkType</xsl:attribute>
                            <xsl:attribute name="type">text</xsl:attribute>
                            <xsl:attribute name="value"> <xsl:value-of select="../mech/@checklevel | ../../mech/@checklevel"/></xsl:attribute>
                            <xsl:attribute name="class">input</xsl:attribute>
                            <xsl:attribute name="disabled">true</xsl:attribute>
                        </xsl:element>
                        <xsl:text>检验者：</xsl:text>
                        <xsl:element name="input">
                            <xsl:attribute name="id"> <xsl:value-of select="../insp/inspname/input/@id | ../../insp/inspname/input/@id"/></xsl:attribute>
                            <xsl:attribute name="type"> <xsl:value-of select="../insp/inspname/input/@type | ../../insp/inspname/input/@type"/></xsl:attribute>
                            <xsl:attribute name="value"> <xsl:value-of select="../insp/inspname/input/@value | ../../insp/inspname/input/@value"/></xsl:attribute>
                            <xsl:attribute name="class">input</xsl:attribute>
                            <xsl:attribute name="disabled">true</xsl:attribute>
                        </xsl:element>
                        <xsl:text>检验时间：</xsl:text>
                        <xsl:element name="input">
                            <xsl:attribute name="id"> <xsl:value-of select="../insp/inspdate/input/@id | ../../insp/inspdate/input/@id"/></xsl:attribute>
                            <xsl:attribute name="type"> <xsl:value-of select="../insp/inspdate/input/@type | ../../insp/inspdate/input/@type"/></xsl:attribute>
                            <xsl:attribute name="value"> <xsl:value-of select="../insp/inspdate/input/@value | ../../insp/inspdate/input/@value"/></xsl:attribute>
                            <xsl:attribute name="class">input</xsl:attribute>
                            <xsl:attribute name="disabled">true</xsl:attribute>
                        </xsl:element>
                    </xsl:if>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="content">
            <xsl:apply-templates select="mech | insp | list1 | list2 | list3 | list4 | list5| list6 | list7 
                | l1item | l2item | l3item | l4item | l5item | l6item | l7item| note | note-zh | warning | warning-zh | caution | caution-zh
                | cqh-note | cqh-note-zh | cqh-warning| cqh-warning-zh | cqh-caution | cqh-caution-zh
                | sign | cqh-judge | cqh-condition | cqh-result | refblock | toolnbr | refmedia 
                | cb | con | csn | equ | grphcref |cblst
                | ein | einmfr | ncon | pan | refext | refint
                | sub | super | ted | toc | txtgrphc
                | std | zone| expd | stdname | tor 
                | table | para | unlist | numlist
                | grsymbol | tadetail | cqh-content|subtask"></xsl:apply-templates>
    </xsl:template>
    
    <!-- cqh-judge模板 -->
    <xsl:template match="cqh-judge">
        <xsl:apply-templates select="cb | con | grphcref
            | pan | refext | refint
            | sub | super | ted | toc | txtgrphc | cqh-result | cqh-condition | sign
            | std | zone| expd | stdname | tor 
            | table | para 
            | effect | chgdesc | regulatory 
            | list1  | list2   | list3 | list4 | list5
            | list6  | list7   | unlist | numlist 
            | l1item | l2item | l3item | l4item | l5item | l6item | l7item
            | note | note-zh | warning | warning-zh | caution | caution-zh
            | cqh-note | cqh-note-zh | cqh-warning| cqh-warning-zh | cqh-caution | cqh-caution-zh
            | refblock | toolnbr | refmedia
            | grsymbol"></xsl:apply-templates>
    </xsl:template>
    
    <!-- cblst跳开关模板 -->
    <xsl:template match="cblst">
        <table class="table">
            <thead>
                <th>PANEL</th>
                <th>DESCRIPTION</th>
                <th>FIN</th>
                <th>LOCATION</th>
            </thead>
        <xsl:apply-templates select="cbsublst"></xsl:apply-templates>
        </table>
    </xsl:template>
    <!-- cbsublst -->
    <xsl:template match="cbsublst">
        <xsl:apply-templates select="effect"></xsl:apply-templates>
        <xsl:if test="./ein">
            <tr>
                <td colspan="4" style="text-align:left;">
                    <xsl:apply-templates select="ein[@type='EXACT']"></xsl:apply-templates>
                </td>
            </tr>
        </xsl:if>
        <xsl:apply-templates select="cbdata"></xsl:apply-templates>
    </xsl:template>
    <!-- cbdata表格模板 -->
    <xsl:template match="cbdata">
        <tbody>
            <!-- 有几个cbdata就有几行 -->
            <xsl:for-each select=".">
                <tr>
                    <td colspan="4" style="text-align:left;">
                        <xsl:apply-templates select="effect"></xsl:apply-templates>
                    </td>
                </tr>
                <tr>
                    <td>
                        <xsl:apply-templates select="pan[@pantype]"></xsl:apply-templates>
                    </td>
                    <td>
                        <xsl:apply-templates select="cbname"></xsl:apply-templates>
                    </td>
                    <td>
                        <xsl:apply-templates select="cb"></xsl:apply-templates>
                    </td>
                    <td>
                        <xsl:apply-templates select="cbloc"></xsl:apply-templates>
                    </td>
                </tr>
            </xsl:for-each>
        </tbody>
    </xsl:template>
    <!-- cb 模板 -->
    <xsl:template match="cb">
        <xsl:value-of select="."/>
    </xsl:template>
    <!-- cbname模板 -->
    <xsl:template match="cbname">
        <xsl:value-of select="." disable-output-escaping="yes"/>
    </xsl:template>
    <!-- pan模板 -->
    <xsl:template match="pan">
        <xsl:value-of select="."/><br/>
    </xsl:template>
    <!-- cbloc模板 -->
    <xsl:template match="cbloc">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- mech模板 -->
    <xsl:template match="mech">
        <!-- 
             <xsl:apply-templates select="mechname | mechdate"></xsl:apply-templates>
        -->
    </xsl:template>
    
    <!-- mechname模板 -->
    <xsl:template match="mechname">
        <xsl:apply-templates select="input"></xsl:apply-templates>
    </xsl:template>
    
    <!-- mechdate模板 -->
    <xsl:template match="mechdate">
        <xsl:apply-templates select="input"></xsl:apply-templates><br/>
    </xsl:template>
    
    <!-- input模板-->
    <xsl:template match="input">
        <xsl:choose>
            <xsl:when test="local-name(parent::node()) = 'sign'">
                <div class="checkInput">
                    <xsl:element name="input">
                        <xsl:attribute name="class">input</xsl:attribute>
                        <xsl:attribute name="align">center</xsl:attribute>
                        <xsl:attribute name="style">width:100% !important;</xsl:attribute>
                        <xsl:attribute name="signId"><xsl:value-of select="normalize-space(../@id)"></xsl:value-of></xsl:attribute>
                        <xsl:if test="@id">
                            <xsl:attribute name="id">
                                <xsl:value-of select="@id"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:if test="@type">
                            <xsl:attribute name="type">
                                <xsl:value-of select="@type"/>
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:element>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="input">
                    <xsl:attribute name="class">input</xsl:attribute>
                    <xsl:attribute name="align">center</xsl:attribute>
                    <xsl:if test="@id">
                        <xsl:attribute name="id">
                            <xsl:value-of select="@id"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="@type">
                        <xsl:attribute name="type">
                            <xsl:value-of select="@type"/>
                        </xsl:attribute>
                    </xsl:if>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- table模板 -->
    <xsl:template match="table">
        <xsl:apply-templates select="title | title-zh | ftnote | graphic"></xsl:apply-templates>
        <table>
            <xsl:if test="not(local-name(parent::node()) = 'instructions')">
                <xsl:attribute name="class">table</xsl:attribute>
                <xsl:attribute name="style">text-align:left;</xsl:attribute>
            </xsl:if>
            <xsl:if test="local-name(parent::node()) = 'instructions'">
                <xsl:attribute name="width">558px</xsl:attribute>
            </xsl:if>
            <xsl:if test="local-name(parent::node()) = 'risk'">
                <xsl:attribute name="id">risk</xsl:attribute>
                <xsl:attribute name="style">text-align:center;</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="tgroup"></xsl:apply-templates>
        </table>
    </xsl:template>
    
    <!-- tgroup模板 -->
    <xsl:template match="tgroup">
        <xsl:apply-templates select="tbody | colspec | spanspec | thead | tfoot"></xsl:apply-templates>
    </xsl:template>
    
    <!-- thead模板 -->
    <xsl:template match="thead">
        <thead>
            <xsl:if test="@valign">
                <xsl:attribute name="valign">
                    <xsl:value-of select="@valign"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="colspec | row"></xsl:apply-templates>
        </thead>
    </xsl:template>
    
    <!-- tbody模板 -->
    <xsl:template match="tbody">
        <xsl:apply-templates select="row"></xsl:apply-templates>
    </xsl:template>
    
    <!-- colspec模板 -->
    <xsl:template match="colspec">
      
    </xsl:template>
    
    <!-- spanspec模板 -->
    <xsl:template match="spanspec">
        
    </xsl:template>
    
    <!-- row模板 -->
    <xsl:template match="row">
        <xsl:apply-templates select="effect"></xsl:apply-templates>
        <!-- 有几个row就有几行 -->
        <xsl:choose>
            <xsl:when test="local-name(parent::node()) = 'thead'">
                <xsl:apply-templates select="entry"></xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <tr><xsl:apply-templates select="entry"></xsl:apply-templates></tr>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- entry模板 -->
    <xsl:template match="entry">
        <xsl:choose>
            <xsl:when test="local-name(../parent::node())='thead'">
                <xsl:element name="th">
                    <xsl:if test="@valign">
                        <xsl:attribute name="valign">
                            <xsl:value-of select="@valign"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="@align">
                        <xsl:attribute name="align">
                            <xsl:value-of select="@align"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates select="para | regulatory | graphic | task | subtask | topic 
                        | list1 | list2 | list3 | list4 | list5 | list6 | list7 | effect | refblock | grphcref | refext | refint
                        | table | unlist | numlist |  note | note-zh |  cqh-note | cqh-note-zh | input 
                        | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action 
                        | sign | warning | warning-zh | caution | caution-zh
                        | cqh-warning | cqh-warning-zh | cqh-caution | cqh-caution-zh"></xsl:apply-templates>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="td">
                    <xsl:if test="@valign">
                        <xsl:attribute name="valign">
                            <xsl:value-of select="@valign"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="@align">
                        <xsl:attribute name="align">
                            <xsl:value-of select="@align"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test=". = '序号'">
                        <xsl:attribute name="width"><xsl:text>30px</xsl:text></xsl:attribute>
                    </xsl:if>
                    <!-- 合并单元格 -->
                    <xsl:if test="@nameend !=''">
                        <xsl:attribute name="colspan"><xsl:value-of select="number(substring(@nameend,4,4)) - number(substring(@namest,4,4)) + 1"></xsl:value-of></xsl:attribute>
                    </xsl:if>
                    <!-- 合并单元格 -->
                    <xsl:if test="@morerows !=''">
                        <xsl:attribute name="rowspan"><xsl:value-of select="@morerows + 1"></xsl:value-of></xsl:attribute>
                    </xsl:if>
                    <!-- 工卡封面时风险用到 -->
                    <xsl:if test="count(child::*)=0">
                        <xsl:value-of select="."></xsl:value-of>
                    </xsl:if>
                    <xsl:apply-templates select="para | regulatory | graphic | task | subtask | topic 
                        | list1 | list2 | list3 | list4 | list5 | list6 | list7 | effect | refblock | grphcref | refext | refint
                        | table | unlist | numlist |  note | note-zh |  cqh-note | cqh-note-zh | input 
                        | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action 
                        | sign | warning | warning-zh | caution | caution-zh
                        | cqh-warning | cqh-warning-zh | cqh-caution | cqh-caution-zh"></xsl:apply-templates>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- figSection模板 -->
    <xsl:template match="figSection">
        <xsl:apply-templates select="graphic"></xsl:apply-templates>
    </xsl:template>
    
    <!-- graphic模板 -->
    <xsl:template match="graphic">
        <xsl:apply-templates select="effect | title | title-zh | sheet | chgdesc"></xsl:apply-templates>
    </xsl:template>
    
    <!-- sheet模板 -->
    <xsl:template match="sheet">
        <xsl:apply-templates select="effect | chgdesc | title | title-zh | gdesc"></xsl:apply-templates>
    </xsl:template>
    
    <!-- chgdesc模板 -->
    <xsl:template match="chgdesc">
        <!-- 不要求显示 -->
    </xsl:template>
    
    <!-- 有效性拆分模板 ,拆一个显示一个-->
    <xsl:template name="output-tokens">
        <xsl:param name="list" />
        <xsl:param name="separator" />
        <xsl:variable name="newlist" select="concat(normalize-space($list), $separator)" />
        <xsl:variable name="first" select="substring-before($newlist, $separator)" />
        <xsl:variable name="remaining" select="substring-after($newlist, $separator)" />
        <span class="effrg">
            <xsl:choose>
                <xsl:when test="string($first)='001999'">
                    <span><xsl:text>ALL</xsl:text></span>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="substring($first,1,3)"/>
                    <xsl:text>-</xsl:text>
                    <xsl:value-of select="substring($first,4,6)"/>
                    <xsl:text> </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </span>
        <xsl:if test="substring-before($remaining, $separator) != ''">
            <xsl:call-template name="output-tokens">
                <xsl:with-param name="list" select="$remaining" />
                <xsl:with-param name="separator" select="$separator" />
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <!-- ********************************************************TASK**********************************************-->
    <xsl:template match="task">
        <xsl:apply-templates select="effect"></xsl:apply-templates>
        <!-- 工卡号 -->
        <div>
            <div>
                <p>
                    <xsl:text>TASK&#160;</xsl:text>
                    <xsl:value-of select="./@chapnbr"/>
                    <xsl:text>-</xsl:text>
                    <xsl:value-of select="./@sectnbr"/>
                    <xsl:text>-</xsl:text>
                    <xsl:value-of select="./@subjnbr"/>
                    <xsl:text>-</xsl:text>
                    <xsl:value-of select="./@func"/>
                    <xsl:text>-</xsl:text>
                    <xsl:value-of select="./@seq"/>
                    <xsl:text>-</xsl:text>
                    <xsl:value-of select="./@confltr"/>
                </p>
            </div>
        </div>
        <xsl:apply-templates select="atacode | chgdesc | title | title-zh | note | note-zh | assodata | regulatory | tfmatr | topic | graphic
            | refblock | grphcref | refext | refint | warning | warning-zh | caution | caution-zh | cqh-warning | cqh-warning-zh | cqh-caution | cqh-caution-zh
            | deleted | chgdesc"></xsl:apply-templates>
    </xsl:template>
    
    <!-- assodata模板 -->
    <xsl:template match="assodata">
        <xsl:apply-templates select="zonelst | einlst | taskreq | elapstim | manhour | nbrpers"></xsl:apply-templates>
    </xsl:template>
    
    <!-- einlst模板 -->
    <xsl:template match="einlst">
        <xsl:apply-templates select="eindata"></xsl:apply-templates>
    </xsl:template>
    
    <!-- eindata模板 -->
    <xsl:template match="eindata">
        <xsl:apply-templates select="effect | ein | einmfr"></xsl:apply-templates>
    </xsl:template>
    
    <!-- elapstim模板 -->
    <xsl:template match="elapstim">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- manhour模板 -->
    <xsl:template match="manhour">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- nbrpers模板 -->
    <xsl:template match="nbrpers">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- tfmatr模板 -->
    <xsl:template match="tfmatr">
        <xsl:apply-templates select="tools | consumables | expendables | parts | zones | references | pretopic"></xsl:apply-templates>
    </xsl:template>
    
    <!-- tools模板 -->
    <xsl:template match="tools">
        <xsl:choose>
            <!-- 有数据显示表格 没数据显示N/A -->
            <xsl:when test="./tool">
                <div>
                    <div>
                        <p>Fixtures,Tools,Test and Support Equipment</p>
                        <p>固定装置，工具，测试和支撑设备</p>
                    </div>
                    <div>
                        <table class="table">
                            <tr>
                                <th>REFERENCE<br/>参考
                                </th>
                                <th>DESIGNATION<br/>描述
                                </th>
                                <th>QTY<br/>数量
                                </th>
                                <th>SOURCE<br/>来源
                                </th>
                                <th>REMARK<br/>备注</th>
                            </tr>
                            <xsl:call-template name="tool"></xsl:call-template>
                        </table>
                    </div>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div>
                    <p>Fixtures,Tools,Test and Support Equipment</p>
                    <p>固定装置，工具，测试和支撑设备</p>
                    <p>N/A</p>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- tool模板 固定装置，工具，测试和支撑设备-->
    <xsl:template name="tool">
        <xsl:for-each-group select="//tool" group-by="effect/@effrg">
            <xsl:if test="normalize-space(effect/@effrg)!='' and (effect/@effrg)!='' ">
                <tr>
                    <td colspan="5" align="left"><xsl:apply-templates select="effect"></xsl:apply-templates></td>
                </tr>
                <xsl:for-each select="current-group()">
                    <tr>
                        <td><xsl:apply-templates select="pn"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="description"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="qty"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="type"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="remark"></xsl:apply-templates></td>
                    </tr>
                </xsl:for-each>
            </xsl:if>
        </xsl:for-each-group>
    </xsl:template>
    
    <!-- pn模板 -->
    <xsl:template match="pn">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- description模板 -->
    <xsl:template match="description">
        <xsl:apply-templates select="para"></xsl:apply-templates>
    </xsl:template>
    
    <!-- qty模板 -->
    <xsl:template match="qty">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- type模板 -->
    <xsl:template match="type">
        <xsl:value-of select="@val"/>
    </xsl:template>
    
    <!-- remark模板 -->
    <xsl:template match="remark">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- consumables模板 化工品-->
    <xsl:template match="consumables">
        <xsl:choose>
            <!-- 有数据显示表格 没数据显示N/A -->
            <xsl:when test="./consumable">
                <div>
                    <div>
                        <p>Consumable Materials</p>
                        <p>化工品</p>
                    </div>
                    <div>
                        <table class="table">
                            <tr>
                                <th>REFERENCE<br/>参考</th>
                                <th>DESIGNATION<br/>描述</th>
                                <th>QTY<br/>数量</th>
                                <th>SOURCE<br/>来源</th>
                                <th>REMARK<br/>备注</th>
                            </tr>
                            <xsl:call-template name="consumable"></xsl:call-template>
                        </table>
                    </div>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div>
                    <p>Consumable Materials</p>
                    <p>化工品</p>
                    <p>N/A</p>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- consumable模板 -->
    <xsl:template name="consumable">
        <xsl:for-each-group select="//consumable" group-by="effect/@effrg">
            <xsl:if test="normalize-space(effect/@effrg)!='' and (effect/@effrg)!='' ">
                <tr>
                    <td colspan="5" align="left"><xsl:apply-templates select="effect"></xsl:apply-templates></td>
                </tr>
                <xsl:for-each select="current-group()">
                    <tr>
                        <td><xsl:apply-templates select="pn"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="description"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="qty"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="type"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="remark"></xsl:apply-templates></td>
                    </tr>
                </xsl:for-each>
            </xsl:if>
        </xsl:for-each-group>
    </xsl:template>
    
    <!-- expendables模板 消耗型航材-->
    <xsl:template match="expendables">
        <xsl:choose>
            <!-- 有数据显示表格 没数据显示N/A -->
            <xsl:when test="./expendable">
                <div>
                    <div>
                        <p>Expendable Parts</p>
                        <p>消耗性航材</p>
                    </div>
                    <div>
                        <table class="table">
                            <tr>
                                <th>FIG.ITEM<br/>图中项目号</th>
                                <th>IPC-CSN</th>
                                <th>DESIGNATION<br/>描述</th>
                                <th>PN<br/>件号</th>
                                <th>QTY<br/>数量</th>
                                <th>SOURCE<br/>来源</th>
                                <th>REMARK<br/>备注</th>
                            </tr>
                            <xsl:call-template name="expendable"></xsl:call-template>
                        </table>
                    </div>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div>
                    <p>Expendable Parts</p>
                    <p>消耗性航材</p>
                    <p>N/A</p>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- expendable模板 -->
    <xsl:template name="expendable">
        <xsl:for-each-group select="//expendable" group-by="effect/@effrg">
            <xsl:if test="normalize-space(effect/@effrg)!='' and (effect/@effrg)!='' ">
                <tr>
                    <td colspan="7" align="left"><xsl:apply-templates select="effect"></xsl:apply-templates></td>
                </tr>
                <xsl:for-each select="current-group()">
                    <tr>
                        <td><xsl:apply-templates select="figitem"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="ipccsn"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="description"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="pn"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="qty"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="type"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="remark"></xsl:apply-templates></td>
                    </tr>
                </xsl:for-each>
            </xsl:if>
        </xsl:for-each-group>
    </xsl:template>
    
    <!-- figitem模板 -->
    <xsl:template match="figitem">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- ipccsn模板 -->
    <xsl:template match="ipccsn">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- parts模板 -->
    <xsl:template match="parts">
        <xsl:apply-templates select="part"></xsl:apply-templates>
    </xsl:template>
    
    <!-- part模板 -->
    <xsl:template match="part">
        <xsl:apply-templates select="figitem | pn | description | qty | effect | type | remark"></xsl:apply-templates>
    </xsl:template>
    
    <!-- zones模板 工作区域和接近盖板-->
    <xsl:template match="zones">
        <xsl:choose>
            <!-- 有数据显示表格 没数据显示N/A -->
            <xsl:when test="./zonelst">
                <div>
                    <div>
                        <p>Work Zones and Access Panels</p>
                        <p>工作区域和接近盖板</p>
                    </div>
                    <div>
                        <table class="table">
                            <tr>
                                <th>Zone/Access<br/>区域/接近</th>
                                <th>ZONE DESIGNATION<br/>区域描述</th>
                                <th>SOURCE<br/>来源</th>
                            </tr>
                            <xsl:call-template name="zonelst"></xsl:call-template>
                        </table>
                    </div>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div>
                    <p>Work Zones and Access Panels</p>
                    <p>工作区域和接近盖板</p>
                    <p>N/A</p>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- zonelst模板 -->
    <xsl:template name="zonelst">
        <xsl:for-each-group select="//zonelst" group-by="effect/@effrg">
            <xsl:if test="normalize-space(effect/@effrg)!='' and (effect/@effrg)!='' ">
                <tr>
                    <td colspan="5" align="left"><xsl:apply-templates select="effect"></xsl:apply-templates></td>
                </tr>
                <xsl:for-each select="current-group()">
                    <tr>
                        <td><xsl:apply-templates select="zone"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="description"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="type"></xsl:apply-templates></td>
                    </tr>
                </xsl:for-each>
            </xsl:if>
        </xsl:for-each-group>
    </xsl:template>
    
    <!-- zone模板 -->
    <xsl:template match="zone">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- finno模板 -->
    <xsl:template match="finno">
        <xsl:apply-templates select="para"></xsl:apply-templates>
    </xsl:template>
    
    <!-- references模板 -->
    <xsl:template match="references">
        <xsl:choose>
            <!-- 有数据显示表格 没数据显示N/A -->
            <xsl:when test="./ref">
                <div>
                    <div>
                        <p>Referenced Information</p>
                        <p>参考信息</p>
                    </div>
                    <div>
                        <table class="table">
                            <tr>
                                <th>REFERENCE<br/>参考</th>
                                <th>DESIGNATION<br/>描述</th>
                                <th>SOURCE<br/>来源</th>
                                <th>REMARK<br/>备注</th>
                            </tr>
                            <xsl:call-template name="ref"></xsl:call-template>
                        </table>
                    </div>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div>
                    <p>Referenced Information</p>
                    <p>参考信息</p>
                    <p>N/A</p>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- ref模板 -->
    <xsl:template name="ref">
        <xsl:for-each-group select="//ref" group-by="effect/@effrg">
            <xsl:if test="normalize-space(effect/@effrg)!='' and (effect/@effrg)!='' ">
                <tr>
                    <td colspan="5" align="left"><xsl:apply-templates select="effect"></xsl:apply-templates></td>
                </tr>
                <xsl:for-each select="current-group()">
                    <tr>
                        <td><xsl:apply-templates select="refnbr"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="reftitle"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="type"></xsl:apply-templates></td>
                        <td><xsl:apply-templates select="remark"></xsl:apply-templates></td>
                    </tr>
                </xsl:for-each>
            </xsl:if>
        </xsl:for-each-group>
    </xsl:template>
    
    <!-- refnbr模板 -->
    <xsl:template match="refnbr">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- reftitle模板 -->
    <xsl:template match="reftitle">
        <xsl:apply-templates select="para"></xsl:apply-templates>
    </xsl:template>
    
    <!-- pretopic模板 -->
    <xsl:template match="pretopic">
        <xsl:apply-templates select="title | title-zh | list1 | effect | para | table | unlist | numlist |  note | note-zh |  cqh-note | cqh-note-zh | input 
            | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action | sign"></xsl:apply-templates>
    </xsl:template>
    
    <!-- model模板 -->
    <xsl:template match="model">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- ata模板 -->
    <xsl:template match="ata">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- jccategory模板 -->
    <xsl:template match="jccategory">
        <xsl:value-of select="@category"></xsl:value-of>
    </xsl:template>
    
    <!-- jctype模板 -->
    <xsl:template match="jctype">
        <xsl:value-of select="@type"></xsl:value-of>
    </xsl:template>
    
    <!-- source模板 -->
    <xsl:template match="source">
        <xsl:value-of select="@value"></xsl:value-of>
    </xsl:template>
    
    <!-- operator模板 -->
    <xsl:template match="operator">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- oemversion模板 -->
    <xsl:template match="oemversion">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- sthours模板 -->
    <xsl:template match="sthours">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- jcversion模板 -->
    <xsl:template match="jcversion">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- auth模板 -->
    <xsl:template match="auth">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- qualv模板 -->
    <xsl:template match="qualv">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- reason模板 -->
    <xsl:template match="reason">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- panels模板 -->
    <xsl:template match="panels">
        <xsl:apply-templates select="pan"></xsl:apply-templates>
    </xsl:template>
    
    <!-- miscontent模板 -->
    <xsl:template match="miscontent">
        <tr>
            <td>机号<br/>A/C NO.</td>
            <td><bolder style="font-size:18px;font-weight:900;"><xsl:value-of select="acno"/></bolder></td>
            <td>机型<br/>A/C</td>
            <td><xsl:value-of select="model"/></td>
            <td>工卡号<br/>Job Card NO.</td>
            <td><xsl:value-of select="jcno"/></td>
            <td>生产指令<br/>Work Order</td>
            <td><xsl:value-of select="../../@barcode"/></td>
        </tr>
        <tr>
            <td>标题<br/>Title</td>
            <td colspan="7">
                <xsl:value-of select="title"/>
            </td>
        </tr>
        <tr>
            <td>首检<br/>Threshold</td>
            <td><xsl:value-of select="threshold"/></td>
            <td>重复检<br/>interval</td>
            <td><xsl:value-of select="interval"/></td>
            <td>MPD号<br/>MPD Item</td>
            <td><xsl:value-of select="mpd"/></td>
            <td>MS号<br/>MS Item</td>
            <td><xsl:value-of select="msno"/></td>
        </tr>
        <tr>
            <td>工种<br/>Skill</td>
            <td><xsl:value-of select="skill"/></td>
            <td>反馈要求<br/>Feedback</td>
            <td><xsl:value-of select="feedback"/></td>
            <td>MS工时<br/>MS MH</td>
            <td><xsl:value-of select="mshours"/></td>
            <td>必检<br/>RII</td>
            <td><xsl:value-of select="rii"/></td>
        </tr>
    </xsl:template>
    
    <!-- jcno模板 -->
    <xsl:template match="jcno">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- acno模板 -->
    <xsl:template match="acno">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- applic模板 -->
    <xsl:template match="applic">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- jobpart模板 -->
    <xsl:template match="jobpart">
        <xsl:apply-templates select="partname | pn | sn | position | fin | reference"></xsl:apply-templates>
    </xsl:template>
    
    <!-- partname模板 -->
    <xsl:template match="partname">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- sn模板 -->
    <xsl:template match="sn">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- position模板 -->
    <xsl:template match="position">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- fin模板 -->
    <xsl:template match="fin">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- threshold模板 -->
    <xsl:template match="threshold">
        <xsl:apply-templates select="limit"></xsl:apply-templates>
    </xsl:template>
    
    <!-- limit模板 -->
    <xsl:template match="limit">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- interval模板 -->
    <xsl:template match="interval">
        <xsl:apply-templates select="limit"></xsl:apply-templates>
    </xsl:template>
    
    <!-- skill模板 -->
    <xsl:template match="skill">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- feedback模板 -->
    <xsl:template match="feedback">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- mpd模板 -->
    <xsl:template match="mpd">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- mshours模板 -->
    <xsl:template match="mshours">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- msno模板 -->
    <xsl:template match="msno">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- rii模板 -->
    <xsl:template match="rii">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- role模板 -->
    <xsl:template match="role">
        <xsl:apply-templates select="originator | auditor | approval"></xsl:apply-templates>
    </xsl:template>
    
    <!-- originator模板 -->
    <xsl:template match="originator">
        <xsl:apply-templates select="username | userimage | date"></xsl:apply-templates>
    </xsl:template>
    
    <!-- username模板 -->
    <xsl:template match="username">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- userimage模板 -->
    <xsl:template match="userimage">
        <xsl:element name="img">
            <xsl:attribute name="src">
                <xsl:value-of select="@imagepath"></xsl:value-of>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
    
    <!-- date模板 -->
    <xsl:template match="date">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- auditor模板 -->
    <xsl:template match="auditor">
        <xsl:apply-templates select="username | userimage | date"></xsl:apply-templates>
    </xsl:template>
    
    <!-- approval模板 -->
    <xsl:template match="approval">
        <xsl:apply-templates select="username | userimage | date"></xsl:apply-templates>
    </xsl:template>
    
    <!-- accomplished模板 -->
    <xsl:template match="accomplished">
        <xsl:apply-templates select="base | finding | deferredtask | manhours | worker | confirmer"></xsl:apply-templates>
    </xsl:template>
    
    <!-- base模板 -->
    <xsl:template match="base">
        <xsl:apply-templates select="input"></xsl:apply-templates>
    </xsl:template>
    
    <!-- finding模板 -->
    <xsl:template match="finding">
        <xsl:apply-templates select="input"></xsl:apply-templates>
    </xsl:template>
    
    <!-- deferredtask模板 -->
    <xsl:template match="deferredtask">
        <xsl:apply-templates select="input"></xsl:apply-templates>
    </xsl:template>
    
    <!-- manhours模板 -->
    <xsl:template match="manhours">
        <xsl:apply-templates select="input"></xsl:apply-templates>
    </xsl:template>
    
    <!-- worker模板 -->
    <xsl:template match="worker">
        <xsl:apply-templates select="workername | workerimage | workerdate"></xsl:apply-templates>
    </xsl:template>
    
    <!-- workername模板 -->
    <xsl:template match="workername">
        <xsl:apply-templates select="input"></xsl:apply-templates>
    </xsl:template>
    
    <!-- workerimage模板 -->
    <xsl:template match="workerimage">
        <xsl:element name="img">
            <xsl:attribute name="src">
                <xsl:value-of select="."></xsl:value-of>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
    
    <!-- workerdate模板 -->
    <xsl:template match="workerdate">
        <xsl:apply-templates select="input"></xsl:apply-templates>
    </xsl:template>
    
    <!-- confirmer模板 -->
    <xsl:template match="confirmer">
        <xsl:apply-templates select="workername | workerimage | workerdate"></xsl:apply-templates>
    </xsl:template>
    
    <!-- risk模板 -->
    <xsl:template match="risk">
        <xsl:apply-templates select="table"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="cqh-result">
        <xsl:apply-templates select="input | table | sign"></xsl:apply-templates>
    </xsl:template>
    
    <!-- 获得当前层下，l1item元素的序号 -->
    <xsl:template name="getIndexL1item">
        <xsl:param name="elemName"/>
        <xsl:param name="initNo">1</xsl:param> <!-- 设置初始值，默认为1。 -->
        <xsl:value-of select="concat(string(count(preceding::*[name()=$elemName])+number($initNo)),'.')"/>
    </xsl:template>
    
    <!-- 获得当前层下，l2item元素的序号 -->
    <xsl:template name="getIndexL2item">
        <xsl:param name="elemName"/>
        <xsl:param name="initNo">1</xsl:param> <!-- 设置初始值，默认为1。 -->
        <xsl:number value="string(count(preceding::*[name()=$elemName])+number($initNo))" format="a"></xsl:number><xsl:text>.</xsl:text>
    </xsl:template>
    
    
    <!-- *******************************************cqhtask**************************************** -->
    <xsl:template match="actype">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="comprehension">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="version">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    
    <xsl:template match="sourcetype">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="wversion">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
</xsl:stylesheet>
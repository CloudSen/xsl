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
    
    <xsl:template match="/">
        <!-- <!DOCTYPE html> -->
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <style type="text/css">
                    body {
                    padding: 0px;
                    margin: 0px;
                    width: 558px;
                    font-family: Arail,"宋体",Arail;
                    font-size: 18px;
                    margin-left: 5px;
                    margin-right: 5px;
                    color: black;
                    }
                    .test_sign {
                    bgcolor:blue;
                    margin: 10px;
                    height: 400px;
                    width: 558px;
                    }
                    .list3ol {
                    list-style-type:none;		
                    counter-reset:sectioncounter;
                    }
                    .list3li:before {  
                    content:"(" counter(sectioncounter) ")";
                    counter-increment:sectioncounter;  
                    }
                    .list4ol {
                    list-style-type:none;		
                    counter-reset:sectioncounter;
                    }
                    .list4li:before {  
                    content:counter(sectioncounter) ")";   
                    counter-increment:sectioncounter;  
                    }
                    .list5ol {
                    list-style-type:lower-roman;
                    }
                    .list5li:before {  
                    }
                    .list6ol {
                    list-style-type:none;		
                    counter-reset:sectioncounter;
                    }
                    .list6li:before {  
                    content:"*";   
                    counter-increment:sectioncounter;  
                    }
                    .list7ol{
                    list-style-type:none;		
                    counter-reset:sectioncounter;
                    }
                    .list7li:before {  
                    content:"-";   
                    counter-increment:sectioncounter;  
                    }
                    ol li {
                    line-height: 20px;
                    }
                    .effrg {
                    color: red;
                    }
                    .signContent {
                    overflow: auto;
                    width: 100%;
                    height: auto;
                    }
                    .radioDiv {
                    width: 10%px;
                    height: auto;
                    float: left;
                    }
                    .signDiv {
                    height: auto;
                    width: 90%;
                    float: left;
                    font-family: Arail,"宋体",Arail;
                    font-size: 13px;
                    }
                    .signDetail {
                    clear: both;
                    }
                    .warning {
                    color: red;
                    font-family:Arail,"黑体";
                    }
                    .note {
                    color: purple;
                    font-family:Arail,"黑体";
                    }
                    .caution {
                    color: brown;
                    }
                    .warningContent {
                    width: 400px;
                    }
                    .table {
                    width: 100%;
                    text-align: center;
                    border:1px solid #000;
                    border-collapse: collapse;
                    padding: 0px;
                    }
                    .table tr td,th {
                    height: auto;
                    min-height: 40px;
                    font-size: 14px;
                    border:1px solid #000;
                    }
                    th {
                    background-color: rgb(192,192,192);
                    }
                    label {
                    border-top: none;
                    border-left: none;
                    border-right: none;
                    border-bottom: 1px solid #000;
                    width: 50px;
                    height: 18px;
                    display: inline-block;
                    }
                    .input {
                    border-top: none;
                    border-left: none;
                    border-right: none;
                    border-bottom: 1px solid #000;
                    width: 50px;
                    height: 30px;
                    background-color: white !important;
                    }
                    .table2 {
                    position: relative;
                    width: 100%;
                    text-align: center;
                    border:1px solid #000;
                    border-collapse: collapse;
                    padding: 0px;
                    }
                    .table2,.table2 tr th, .table2 tr td { 
                    border:1px solid #000;
                    }
                    #ac,#ac2,#acc,#risk {
                    width: 558px;  
                    text-align: center; 
                    border-collapse: collapse; 
                    padding: 0px;
                    font-size: 12px;
                    } 
                    #ac tr td,#acc tr td {
                    height: auto;
                    min-height: 50px;
                    width: 12.5%;
                    }
                    #risk tr td {
                    height: auto;
                    min-height: 50px;
                    width: auto;
                    }
                    #ac2 tr td {
                    height: auto;
                    min-height: 50px;
                    width: 16.6%;
                    }
                    #ac2,#acc,#risk {
                    border-top: 0px;
                    }
                    .noBorder  {
                    border-top:0px;
                    }
                    .tableHeader  {
                    text-align: center;
                    background-color: lightgray;
                    height: 30px !important;
                    }
                    .topicDiv  {
                    position: relative;
                    width: 558px;
                    margin: 0px 0px 0px;
                    }
                    .topicSeq {
                    float: left;
                    }
                    .title  {
                    float: left;
                    }
                    .title-zh {
                    clear:both;
                    margin-left: 12px;
                    }
                    .subtask-effect {
                    position: relative;
                    width: 558px;
                    margin: 0px 0px 0px;
                    }
                    .subtask-jcNo {
                    position: relative;
                    width: 558px;
                    margin: 0px 0px 0px;
                    }
                    .list1Div {
                    width: 100%;
                    }
                    .checkInput {
                    position: relative;
                    width: 80%;
                    margin: 5px auto 5px;
                    }
                </style>
            </head>
            <body>
                <div style="width:558px;">
                    <xsl:apply-templates select="cqhtask"></xsl:apply-templates>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="cqhtask">
        <xsl:apply-templates select="taskmetadata | instructions | figSection"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="taskmetadata">
        <xsl:apply-templates select="model | actype | comprehension | sthours | version 
            | auth | qualv | mpd | sourcetype | wversion | reason | role"></xsl:apply-templates>
        <!-- 表头 -->
        <table id="ac" class="table2" cellspacing="0" cellpadding="0">
            <tr>
                <td rowspan="2" style="width:140px;height: 40px;">
                    <img src="img/cqLogo.png" alt="cqLogo" width="140px"/>
                </td>
                <th style="width:300px;height: 10px;background-color:lightgray;">
                    <xsl:text>CQH TASK</xsl:text>
                </th>
                <td rowspan="2" style="width:140px;height: 40px;">
                    <xsl:text>alksfjlsfkd</xsl:text>
                </td>
            </tr>
            <tr>
                <td style="width:300px;height: 30px;">
                    <xsl:text>CQH-</xsl:text>
                    <xsl:value-of select="./model/text()"></xsl:value-of>
                </td>
            </tr>
            <tr>
                <td rowspan="2" style="width:140px;height: 60px;">
                    <xsl:text>A/C Reg:</xsl:text>
                    <xsl:value-of select="normalize-space('')"></xsl:value-of><br/>
                    <xsl:text>MSN:</xsl:text>
                </td>
                <td rowspan="2" style="width:140px;height: 60px;">
                    <xsl:text>alksfjlsfkd</xsl:text>
                </td>
                <td rowspan="2" style="width:140px;height: 60px;">
                    <xsl:text>TASK Rev:</xsl:text>
                    <xsl:value-of select="normalize-space(../@cqhchg)"></xsl:value-of>
                    <xsl:value-of select="normalize-space(version)"></xsl:value-of>
                </td>
            </tr>
            <tr>
            </tr>
        </table>
        <br/>
        <!-- 编写者等 -->
        <table  id="ac" class="table2" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <xsl:value-of select="normalize-space('标准工时')"></xsl:value-of><br/>
                    <xsl:value-of select="normalize-space('ST MH')"></xsl:value-of>
                </td>
                <td>
                    <xsl:value-of select="sthours"></xsl:value-of>
                </td>
                <td>
                    <xsl:value-of select="normalize-space('授权')"></xsl:value-of><br/>
                    <xsl:value-of select="normalize-space('Author')"></xsl:value-of>
                </td>
                <td>
                    <xsl:value-of select="auth"></xsl:value-of>
                </td>
            </tr>
            <tr>
                <td>
                    <xsl:value-of select="normalize-space('编写者')"></xsl:value-of><br/>
                    <xsl:value-of select="normalize-space('Author')"></xsl:value-of>
                </td>
                <td>
                    <xsl:value-of select="normalize-space('日期')"></xsl:value-of><br/>
                    <xsl:value-of select="normalize-space('Date')"></xsl:value-of>
                </td>
                <td>
                    <xsl:value-of select="normalize-space('审核者')"></xsl:value-of><br/>
                    <xsl:value-of select="normalize-space('Reviewer')"></xsl:value-of>
                </td>
                <td>
                    <xsl:value-of select="normalize-space('日期')"></xsl:value-of><br/>
                    <xsl:value-of select="normalize-space('Author')"></xsl:value-of>
                </td>
                <td>
                    <xsl:value-of select="normalize-space('批准者')"></xsl:value-of><br/>
                    <xsl:value-of select="normalize-space('Approver')"></xsl:value-of>
                </td>
                <td>
                    <xsl:value-of select="normalize-space('日期')"></xsl:value-of><br/>
                    <xsl:value-of select="normalize-space('Date')"></xsl:value-of>
                </td>
            </tr>
            <tr>
                <td>asdfasdf</td>
                <td>afasdf</td>
                <td>adfasdf</td>
                <td>asdff</td>
                <td>asfdaf</td>
                <td>asdfs</td>
            </tr>
        </table>
    </xsl:template>
    
    <!-- task -->
    <xsl:template match="instructions">
        <xsl:apply-templates select="table"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="figSection">
        <xsl:apply-templates select="graphic"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="model">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="actype">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="comprehension">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="sthours">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="version">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="auth">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="qualv">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="mpd">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="sourcetype">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="wversion">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="reason">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="role">
        <xsl:apply-templates select="originator | auditor | approval"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="originator">
        <xsl:apply-templates select="username | userimage | date"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="auditor">
        <xsl:apply-templates select="username | userimage | date"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="approval">
        <xsl:apply-templates select="username | userimage | date"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="username">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="userimage">
        <xsl:element name="img">
            <xsl:attribute name="src">
                <xsl:value-of select="@imagepath"></xsl:value-of>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="date">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    
    
 <!-- **************************************************************************************************** -->
   
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
                    <xsl:copy-of select="self::node()"/>
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
                    | pan | grphcref | toolnbr | tadetail | riskdetail"></xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="grphcref">
        <xsl:value-of select="."></xsl:value-of>
        <xsl:apply-templates select="effect"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="toolnbr">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="tadetail">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="riskdetail">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
   
    <xsl:template match="graphic">
        <xsl:apply-templates select="effect | chgdesc | title | title-zh | sheet"></xsl:apply-templates>
    </xsl:template>
    
    <!-- sheet模板 -->
    <xsl:template match="sheet">
        <xsl:apply-templates select="effect | chgdesc | title | title-zh | gdesc"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="gdesc">
        <xsl:apply-templates select="unlist | numlist"></xsl:apply-templates>
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
    
    <!-- title模板 -->
    <xsl:template match="title">
        <div>
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
        <div>
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
    
    <xsl:template match="chgdesc">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    <!-- 有效性模板 -->
    <xsl:template match="effect">
        <xsl:call-template name="output-tokens">
            <xsl:with-param name="list" select="@effrg"/>
            <xsl:with-param name="separator" select="' '"></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <!-- table模板 -->
    <xsl:template match="table">
        <xsl:apply-templates select="title | title-zh | ftnote | graphic"></xsl:apply-templates>
        <table>
            <xsl:if test="not(local-name(parent::node()) = 'instructions')">
                <xsl:attribute name="class">table</xsl:attribute>
                <xsl:attribute name="style">text-align:left;</xsl:attribute>
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
    
    <!-- **************************************************************************************************** -->
    
    
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
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
                        width: auto;
                        font-size: 18px;
                        font-family: Arail,"宋体";
                        color: black;
                    }
                    .effrg {
                        color: red;
                    }
                    .signContent {
                        overflow: auto;
                        width: auto;
                        height: auto;
                    }
                    .radioDiv {
                        width: 30px;
                        height: auto;
                        float: left;
                    }
                    .signDiv {
                        height: auto;
                        width: 470px;
                        float: left;
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
                        width: auto;
                        margin-left:40px;
                    }
                    .table {
                         width: auto;
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
                        height: 30px;
                        display: inline-block;
                    }
                    .input {
                         border-top: none;
                         border-left: none;
                         border-right: none;
                         border-bottom: 1px solid #000;
                         width: 100px;
                         height: 30px;
                    }
                </style>
            </head>
            <body>
                <xsl:apply-templates select="jobcard"></xsl:apply-templates>
            </body>
        </html>
    </xsl:template>
    
    <!-- jobcard顶级标签 -->
    <xsl:template match="jobcard">
        <xsl:apply-templates select="jobmetadata | instructions | figSection"></xsl:apply-templates>
    </xsl:template>
    
    <!-- instructions标签 -->
    <xsl:template match="instructions">
        <xsl:apply-templates select="table"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="subtask">
        <xsl:apply-templates select="effect"></xsl:apply-templates>
        <!-- 工卡号 -->
        <div>
            <div>
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
            <xsl:element name="p">
                <xsl:if test="title='Job Set-up'">
                    <xsl:text>1.</xsl:text>
                </xsl:if>
                <xsl:if test="title='Procedure'">
                    <xsl:text>2.</xsl:text>
                </xsl:if>
                <xsl:if test="title='Close-up'">
                    <xsl:text>3.</xsl:text>
                </xsl:if>
                <!-- 显示topic的标题 -->
                <xsl:apply-templates select="title | title-zh | effect
                    | warning | warning-zh | caution | caution-zh
                    | cqh-warning | cqh-warning-zh | cqh-caution | cqh-caution-zh
                    | refblock | grphcref | refext | refint"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <!-- title模板 -->
    <xsl:template match="title">
        <p id="title"><u><xsl:value-of select="."/></u></p>
    </xsl:template>
    
    <!-- title-zh模板 -->
    <xsl:template match="title-zh">
        <p id="title-zh"><u><xsl:value-of select="."/></u></p>
    </xsl:template>
    
    <!-- grphcref模板 -->
    <xsl:template match="grphcref">
        <p>
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
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text>
                    <xsl:value-of select="@refid"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
            <span>)</span><br/>
        </p>
    </xsl:template>
    
    <!-- 标题遍历模板 -->
    <xsl:template match="list1">
        <xsl:element name="div">
            <xsl:element name="p">
                <xsl:attribute name="class">sub_title</xsl:attribute>
                <xsl:apply-templates select="effect | cqh-action | cqh-judge | cqh-condition | cqh-result | sign | l1item"></xsl:apply-templates>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <!-- l1item一级标题模板 -->
    <xsl:template match="l1item">
        <xsl:apply-templates select=" warning | warning-zh | note | note-zh | caution 
            | caution-zh | cqh-note | cqh-note-zh | cqh-caution | cqh-caution-zh
            | cqh-warning | cqh-warning-zh
            | para | table | list2 | cqh-action | unlist | numlist | cblst 
            | input | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action | sign | cblst | art"></xsl:apply-templates>
    </xsl:template>
    <!-- list2模板 -->
    <xsl:template match="list2">
        <xsl:element name="div">
            <xsl:element name="p">
                <xsl:attribute name="class">sed_title</xsl:attribute>
                <xsl:apply-templates select="effect | ltitle | ltitle-zh | cqh-action | cqh-judge | cqh-condition | cqh-result | sign | l2item | table"></xsl:apply-templates>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <!-- l2item模板 -->
    <xsl:template match="l2item">
        <xsl:apply-templates select=" warning | warning-zh | note | note-zh | caution 
            | caution-zh | cqh-note | cqh-note-zh | cqh-caution | cqh-caution-zh
            | cqh-warning | cqh-warning-zh
            | para | table | list3 | cqh-action | unlist | numlist | cblst 
            | input | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action | sign"></xsl:apply-templates>
    </xsl:template>
    <!-- list3模板 -->
    <xsl:template match="list3">
        <xsl:element name="div">
            <xsl:element name="p">
                <xsl:attribute name="class">sed_title</xsl:attribute>
                <xsl:apply-templates select="effect | cqh-action | cqh-judge | cqh-condition | cqh-result | sign | l3item"></xsl:apply-templates>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <!-- l3item模板 -->
    <xsl:template match="l3item">
        <xsl:apply-templates select=" warning | warning-zh | note | note-zh | caution 
            | caution-zh | cqh-note | cqh-note-zh | cqh-caution | cqh-caution-zh
            | cqh-warning | cqh-warning-zh
            | para | table | list4 | cqh-action | unlist | numlist | cblst 
            | input | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action | sign"></xsl:apply-templates>
    </xsl:template>
    <!-- list4....5....6...7的模板 -->
    <xsl:template match="list4">
        <xsl:element name="div">
            <xsl:element name="p">
                <xsl:attribute name="class">sub_title</xsl:attribute>
                <xsl:apply-templates select="effect | cqh-action | cqh-judge | cqh-condition | cqh-result | sign | l4item"></xsl:apply-templates>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="l4item">
        <xsl:apply-templates select=" warning | warning-zh | note | note-zh | caution 
            | caution-zh | cqh-note | cqh-note-zh | cqh-caution | cqh-caution-zh
            | cqh-warning | cqh-warning-zh
            | para | table | list5 | cqh-action | unlist | numlist | cblst 
            | input | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action | sign"></xsl:apply-templates>
    </xsl:template>
    <xsl:template match="list5">
        <xsl:element name="div">
            <xsl:element name="p">
                <xsl:attribute name="class">sub_title</xsl:attribute>
                <xsl:apply-templates select="effect | cqh-action | cqh-judge | cqh-condition | cqh-result | sign | l5item"></xsl:apply-templates>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="l5item">
        <xsl:apply-templates select=" warning | warning-zh | note | note-zh | caution 
            | caution-zh | cqh-note | cqh-note-zh | cqh-caution | cqh-caution-zh
            | cqh-warning | cqh-warning-zh
            | para | table | list6 | cqh-action | unlist | numlist | cblst 
            | input | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action | sign"></xsl:apply-templates>
    </xsl:template>
    <xsl:template match="list6">
        <xsl:element name="div">
            <xsl:element name="p">
                <xsl:attribute name="class">sub_title</xsl:attribute>
                <xsl:apply-templates select="effect | cqh-action | cqh-judge | cqh-condition | cqh-result | sign | l6item"></xsl:apply-templates>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="l6item">
        <xsl:apply-templates select=" warning | warning-zh | note | note-zh | caution 
            | caution-zh | cqh-note | cqh-note-zh | cqh-caution | cqh-caution-zh
            | cqh-warning | cqh-warning-zh
            | para | table | list7 | cqh-action | unlist | numlist | cblst 
            | input | cqh-content | cqh-judge  | cqh-condition | cqh-result | cqh-action | sign"></xsl:apply-templates>
    </xsl:template>
    <xsl:template match="list7">
        <xsl:element name="div">
            <xsl:element name="p">
                <xsl:attribute name="class">sub_title</xsl:attribute>
                <xsl:apply-templates select="effect | cqh-action | cqh-judge | cqh-condition | cqh-result | sign | l7item"></xsl:apply-templates>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="l7item">
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
                    <xsl:attribute name="src">img/judge_start.jpg</xsl:attribute>
                </xsl:element>
            </xsl:when>
            <xsl:when test="string(@val) = 'end'">
                <xsl:element name="img">
                    <xsl:attribute name="src">img/judge_end.jpg</xsl:attribute>
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
            
            <xsl:when test="./con">
                <p><xsl:value-of select="."/><br/></p>
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
                    <label id="workStatus" name="workStatus" class="signInput"></label>&#160;
                    <xsl:text>工作者：</xsl:text>
                    <label id="worker" name="worker" class="signInput"></label>&#160;
                    <xsl:text>工作时间：</xsl:text>
                    <label id="workDate" name="workDate" class="signInput"></label><br/>
                    <!-- 判断是否有检验要求 -->
                    <xsl:if test="string(./mech/@checklevel)!=''">
                        <xsl:value-of select="./mech/@checklevel"/>：
                        <label id="checkType" name="checkType" class="signInput"></label>&#160;
                        <xsl:text>检验者：</xsl:text>
                        <label id="checker" name="checker" class="signInupt"></label>&#160;
                        <xsl:text>检验时间：</xsl:text>
                        <label id="checkDate" name="checkDate" class="signInput"></label><br/>
                    </xsl:if>
                </xsl:element>
            </div>
            <div class="signDetail">
                <xsl:apply-templates select="mech | insp | list1 | list2 | list3 | list4 | list5| list6 | list7 
                    | l1item | l2item | l3item | l4item | l5item | l6item | l7item| note | note-zh | warning | warning-zh | caution | caution-zh
                    | cqh-note | cqh-note-zh | cqh-warning| cqh-warning-zh | cqh-caution | cqh-caution-zh
                    | sign | cqh-judge | cqh-condition | cqh-result | refblock | toolnbr | refmedia 
                    | cb | con | csn | equ | grphcref
                    | ein | einmfr | ncon | pan | refext | refint
                    | sub | super | ted | toc | txtgrphc
                    | std | zone| expd | stdname | tor 
                    | table | para | unlist | numlist
                    | grsymbol | tadetail | cqh-content|subtask"></xsl:apply-templates>
            </div>
        </div>
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
        <xsl:apply-templates select="mechname | mechdate"></xsl:apply-templates>
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
    </xsl:template>
    
    <!-- table模板 -->
    <xsl:template match="table">
        <xsl:apply-templates select="title | title-zh | ftnote | graphic"></xsl:apply-templates>
        <table>
            <xsl:if test="not(local-name(parent::node()) = 'instructions')">
                <xsl:attribute name="class">table</xsl:attribute>
                <xsl:attribute name="style">text-align:left;</xsl:attribute>
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
        <xsl:value-of select="."/>
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
    
    <!-- ************************************************************************************TASK******************************************************************************************************************-->
    <xsl:template match="task">
        <xsl:apply-templates select="atacode | effect | chgdesc | title | title-zh | note | note-zh | assodata | regulatory | tfmatr | topic | graphic
            | refblock | grphcref | refext | refint | warning | warning-zh | caution | caution-zh | cqh-warning | cqh-warning-zh | cqh-caution | cqh-caution-zh
            | deleted | chgdesc"></xsl:apply-templates>
    </xsl:template>
    
    <!-- tfmatr模板 -->
    <xsl:template match="tfmatr">
        <xsl:apply-templates select="tools | consumables | expendables | parts | zones | references | pretopic"></xsl:apply-templates>
    </xsl:template>
    
    <!-- tools模板 -->
    <xsl:template match="tools">
        <xsl:apply-templates select="tool"></xsl:apply-templates>
    </xsl:template>
    
    <!-- tool模板 -->
    <xsl:template match="tool">
        <xsl:apply-templates select="pn | description | qty | effect | type | remark"></xsl:apply-templates>
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
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- remark模板 -->
    <xsl:template match="remark">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- consumables模板 -->
    <xsl:template match="consumables">
        <xsl:apply-templates select="consumable"></xsl:apply-templates>
    </xsl:template>
    
    <!-- consumable模板 -->
    <xsl:template match="consumable">
        <xsl:apply-templates select="pn | description | qty | effect | type | remark"></xsl:apply-templates>
    </xsl:template>
    
    <!-- expendables模板 -->
    <xsl:template match="expendables">
        <xsl:apply-templates select="expendable"></xsl:apply-templates>
    </xsl:template>
    
    <!-- expendable模板 -->
    <xsl:template match="expendable">
        <xsl:apply-templates select="figitem | ipccsn | description | qty | pn | effect | type | remark"></xsl:apply-templates>
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
    
    <!-- zones模板 -->
    <xsl:template match="zones">
        <xsl:apply-templates select="zonelst"></xsl:apply-templates>
    </xsl:template>
    
    <!-- zonelst模板 -->
    <xsl:template match="zonelst">
        <xsl:apply-templates select="zone | description | effect | finno | type"></xsl:apply-templates>
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
        <xsl:apply-templates select="ref"></xsl:apply-templates>
    </xsl:template>
    
    <!-- ref模板 -->
    <xsl:template match="ref">
        <xsl:apply-templates select="refnbr | reftitle | effect | type | remark"></xsl:apply-templates>
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
    
</xsl:stylesheet>
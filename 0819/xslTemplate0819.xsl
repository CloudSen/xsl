<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    /**
     * 
     * <解析工卡封面> <解析Task> <解析Topic> <解析Subtask>
     * @author [011096] yangyunsen@czy.inner.com
     * @see [jobcard.dtd]
     * @date 2017/8/3 17:30
     * @version 4
     * @Description 修复序号问题
     * @Attention:  工卡封面、风险、等表格宽度是#ac控制
     */
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:lxslt="http://xml.apache.org/xslt"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions">
    <xsl:import href="xslBasical.xsl"></xsl:import>
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
                    width: 100%;
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
                    width: 100%px;  
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
                        width: 558px;
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
	            	<xsl:apply-templates select="jobcard"></xsl:apply-templates>
	            </div>
            </body>
        </html>
    </xsl:template>
    
    <!-- jobcard顶级标签 -->
    <xsl:template match="jobcard">
        <xsl:apply-templates select="jobmetadata | instructions"></xsl:apply-templates>
    </xsl:template>
    
    <!-- instructions标签 -->
    <xsl:template match="instructions">
        <xsl:apply-templates select="table"></xsl:apply-templates>
    </xsl:template>
    
    <!-- *********************************************************metadata**********************************************-->
    <xsl:template match="jobmetadata">
        <xsl:if test="count(child::*) > 1">
            <table id="ac" class="table2"  cellspacing="0" cellpadding="0">
                <tr>
                    <th class="tableHeader" colspan="8">
                        适用性及控制信息Applicability&amp;Control Information
                    </th>
                </tr>
                <xsl:apply-templates select="miscontent"></xsl:apply-templates>
            </table>
            <table id="ac2" class="table2" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="noBorder">编写者<br/>Author</td>
                    <td class="noBorder">日期<br/>Date</td>
                    <td class="noBorder">审核者<br/>Reviewer</td>
                    <td class="noBorder">日期<br/>Date</td>
                    <td class="noBorder">批准者<br/>Approval</td>
                    <td class="noBorder">日期<br/>Date</td>
                </tr>
                <tr>
                    <td>
                        <xsl:element name="img">
                            <xsl:attribute name="src">
                                <xsl:value-of select="miscontent/role/originator/userimage/@imagepath"/>
                            </xsl:attribute>
                        </xsl:element>
                    </td>
                    <td><xsl:value-of select="miscontent/role/originator/date"/></td>
                    <td>
                        <xsl:element name="img">
                            <xsl:attribute name="src">
                                <xsl:value-of select="miscontent/role/auditor/userimage/@imagepath"/>
                            </xsl:attribute>
                        </xsl:element>
                    </td>
                    <td><xsl:value-of select="miscontent/role/auditor/date"/></td>
                    <td>
                        <xsl:element name="img">
                            <xsl:attribute name="src">
                                <xsl:value-of select="miscontent/role/approval/userimage/@imagepath"/>
                            </xsl:attribute>
                        </xsl:element>
                    </td>
                    <td><xsl:value-of select="miscontent/role/approval/date"/></td>
                </tr>
            </table>
            <table id="acc" class="table2" cellspacing="0" cellpadding="0">
                <tr>
                    <th class="noBorder tableHeader" colspan="8">工作完成 Accomplished</th>
                </tr>
                <tr>
                    <td>航站<br/>Base</td>
                    <td><xsl:value-of select="miscontent/accomplished/base"/></td>
                    <td>故障发现<br/>Finding</td>
                    <td><xsl:value-of select="miscontent/accomplished/finding"/></td>
                    <td>退单号<br/>Deferred Task</td>
                    <td><input class="input" type="text" name="deferredTask"/></td>
                    <td>实际人工时<br/>ManXHour</td>
                    <td>
                        <select class="input" name="man" style="width:20px">
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            <option>5</option>
                            <option>6</option>
                            <option>7</option>
                            <option>8</option>
                            <option>9</option>
                            <option>10</option>
                            <option>11</option>
                            <option>12</option>
                            <option>13</option>
                            <option>14</option>
                            <option>15</option>
                            <option>16</option>
                            <option>17</option>
                            <option>18</option>
                            <option>19</option>
                            <option>20</option>
                        </select>
                        <xsl:value-of select="normalize-space('X')"></xsl:value-of>
                        <input class="input" type="text" name="hour" style="width: 20px;"/>
                    </td>
                </tr>
                <tr>
                    <td>工作者<br/>Operator</td>
                    <td><xsl:value-of select="miscontent/accomplished/worker/workername"/></td>
                    <td>日期<br/>Date</td>
                    <td><xsl:value-of select="miscontent/accomplished/worker/workerdate"/></td>
                    <td>完工确认者<br/>Confirmer</td>
                    <td><xsl:value-of select="miscontent/accomplished/confirmer/workername"/></td>
                    <td>日期<br/>Date</td>
                    <td><xsl:value-of select="miscontent/accomplished/confirmer/workerdate"/></td>
                </tr>
            </table>
        </xsl:if>
        <table id="risk" class="table2">
            <tr>
                <th class="tableHeader noBorder" colspan="8">风险 Risk Tips</th>
            </tr>
        </table>
        <xsl:apply-templates select="risk"></xsl:apply-templates>
    </xsl:template>
</xsl:stylesheet>
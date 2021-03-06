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
                <td colspan="2">
                    <xsl:value-of select="sthours"></xsl:value-of>
                </td>
                <td>
                    <xsl:value-of select="normalize-space('授权')"></xsl:value-of><br/>
                    <xsl:value-of select="normalize-space('Author')"></xsl:value-of>
                </td>
                <td colspan="2">
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
    
</xsl:stylesheet>
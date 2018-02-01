<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ct="urn:fdc:difi.no:2017:vefa:espd:CriteriaTaxonomy-1"
                exclude-result-prefixes="ct">

    <xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes" />
    <xsl:strip-space elements="*"/>

    <xsl:template match="/ct:CriteriaTaxonomy">
        <html>
            <head>

                <meta charset="utf-8"/>
                <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>

                <title>Criteria Taxonomy</title>

                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous"/>
            </head>
            <body>
                <div class="container">
                    <h1>Critieria Taxonomy</h1>

                    <p class="lead">This documents outlines the ESPD criteria taxonomy version '<xsl:value-of select="ct:Version"/>' part of PEPPOL BIS ESPD 1.0.</p>

                    <table class="table table-condensed table-striped">
                        <thead>
                            <tr>
                                <th style="width: 80pt;">Tree</th>
                                <th style="width: 60pt;">UUID</th>
                                <th>Description</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:apply-templates select="ct:Criterion"/>
                        </tbody>
                    </table>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="ct:Criterion">
        <tr>
            <th colspan="4"><xsl:value-of select="ct:Type/text()" /></th>
        </tr>
        <tr>
            <td>C</td>
            <td><code title="{@id}"><xsl:value-of select="concat(substring(@id, 1, 6), '..')" /></code></td>
            <xsl:if test="string-length(ct:Description/ct:Source/text()) &gt; 120"><td><xsl:value-of select="substring(ct:Description/ct:Source/text(), 1, 120)"/> <small>[..]</small></td></xsl:if>
            <xsl:if test="string-length(ct:Description/ct:Source/text()) &lt;= 120"><td><xsl:value-of select="ct:Description/ct:Source/text()"/></td></xsl:if>
        </tr>
        <xsl:apply-templates select="ct:Comment"/>

        <xsl:apply-templates select="ct:RequirementGroupId">
            <xsl:with-param name="parent" select="'C'"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="ct:RequirementGroup">
        <xsl:param name="parent"/>
        <xsl:variable name="location" select="concat($parent, '.G')"/>
        <tr>
            <td><xsl:value-of select="$location" /></td>
            <td><code title="{@id}"><xsl:value-of select="concat(substring(@id, 1, 6), '..')" /></code></td>
            <xsl:if test="ct:ProsessingInstruction"><td><span class="label label-info" title="Processing instruction"><xsl:value-of select="ct:ProsessingInstruction/text()"/></span></td></xsl:if>
            <xsl:if test="not(ct:ProsessingInstruction)"><td></td></xsl:if>
        </tr>
        <xsl:apply-templates select="ct:Comment"/>
        <xsl:apply-templates select="ct:RequirementId">
            <xsl:with-param name="parent" select="$location"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="ct:RequirementGroupId">
            <xsl:with-param name="parent" select="$location"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="ct:Requirement">
        <xsl:param name="parent"/>
        <xsl:variable name="location" select="concat($parent, '.R')"/>
        <tr>
            <td><xsl:value-of select="$location" /></td>
            <td><code title="{@id}"><xsl:value-of select="concat(substring(@id, 1, 6), '..')" /></code></td>
            <td><xsl:value-of select="ct:Description/ct:Source/text()"/></td>
        </tr>
        <xsl:apply-templates select="ct:Comment"/>
    </xsl:template>

    <xsl:template match="ct:Comment">
        <tr>
            <td colspan="2"></td>
            <td><small><xsl:value-of select="text()"/></small></td>
        </tr>
    </xsl:template>


    <xsl:template match="ct:RequirementGroupId">
        <xsl:param name="parent"/>
        <xsl:variable name="id" select="text()"/>
        <xsl:apply-templates select="//ct:RequirementGroup[@id = $id]">
            <xsl:with-param name="parent" select="$parent"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="ct:RequirementId">
        <xsl:param name="parent"/>
        <xsl:variable name="id" select="text()"/>
        <xsl:apply-templates select="//ct:Requirement[@id = $id]">
            <xsl:with-param name="parent" select="$parent"/>
        </xsl:apply-templates>
    </xsl:template>

</xsl:stylesheet>

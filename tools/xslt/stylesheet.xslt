<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                xmlns:ccv-cbc="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1"
                xmlns:cev-cbc="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1"
                xmlns:cev="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1"
                xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
                xmlns:ccv="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"
                xmlns:espd-req="urn:grow:names:specification:ubl:schema:xsd:ESPDRequest-1"
                xmlns:espd="urn:grow:names:specification:ubl:schema:xsd:ESPDResponse-1"
                xmlns="urn:fdc:difi.no:2017:vefa:espd:CriteriaTaxonomy-1"
                exclude-result-prefixes="xsl cac cbc ccv-cbc cev-cbc cev ext ccv espd-req">

    <xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes" />
    <xsl:strip-space elements="*"/>

    <xsl:template match="espd-req:ESPDRequest | espd:ESPDResponse">
        <html lang="en">
            <head>

                <meta charset="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css" integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous"/>

                <title>ESPD</title>

            </head>
            <body>

                <div class="container">

                    <h1>ESPD</h1>

                    <xsl:apply-templates select="ccv:Criterion"/>

                </div>

            </body>
        </html>
    </xsl:template>

    <xsl:template match="ccv:Criterion">
        <h3><xsl:value-of select="cbc:Name/text()"/></h3>

        <p><xsl:value-of select="cbc:Description/text()"/></p>

        <xsl:apply-templates select="ccv:LegislationReference"/>

        <xsl:apply-templates select="ccv:RequirementGroup"/>
    </xsl:template>

    <xsl:template match="ccv:LegislationReference">
        <div style="background-color: #eee;">
            <h3><xsl:value-of select="ccv-cbc:Title/text()"/></h3>

            <p><xsl:value-of select="cbc:Description/text()"/></p>

            <p><a href="{cbc:URI/text()}"><xsl:value-of select="ccv-cbc:JurisdictionLevelCode/text()"/> <xsl:value-of select="ccv-cbc:Article/text()"/></a></p>
        </div>
    </xsl:template>

    <xsl:template match="ccv:RequirementGroup">
        <div style="margin-left: 10pt;">
            <xsl:apply-templates select="ccv:Requirement"/>
            <xsl:apply-templates select="ccv:RequirementGroup"/>
        </div>
    </xsl:template>

    <xsl:template match="ccv:Requirement">
        <div>
            <p><xsl:value-of select="cbc:Description/text()"/></p>
            <xsl:apply-templates select="ccv:Response"/>
        </div>
    </xsl:template>

    <xsl:template match="ccv:Response">

    </xsl:template>

</xsl:stylesheet>
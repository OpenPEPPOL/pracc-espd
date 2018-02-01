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
                xmlns="urn:fdc:difi.no:2017:vefa:espd:CriteriaTaxonomy-1"
                exclude-result-prefixes="xsl cac cbc ccv-cbc cev-cbc cev ext ccv espd-req">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/espd-req:ESPDRequest">
        <CriteriaTaxonomy>
            <xsl:apply-templates select="//ccv:Criterion"/>

            <xsl:variable name="requirementGroups" select="//ccv:RequirementGroup"/>
            <xsl:variable name="rgids" select="distinct-values($requirementGroups/cbc:ID/text())"/>
            <xsl:for-each select="$rgids">
                <xsl:variable name="id" select="."/>
                <xsl:apply-templates select="$requirementGroups[cbc:ID[text() = $id]][1]"/>
            </xsl:for-each>
            <!-- <xsl:apply-templates select="//ccv:RequirementGroup"/> -->

            <xsl:variable name="requirements" select="//ccv:Requirement"/>
            <xsl:variable name="rids" select="distinct-values($requirements/cbc:ID/text())"/>
            <xsl:for-each select="$rids">
                <xsl:variable name="id" select="."/>
                <xsl:apply-templates select="$requirements[cbc:ID[text() = $id]][1]"/>
            </xsl:for-each>
            <!-- <xsl:apply-templates select="//ccv:Requirement[cbc:ID[some $id in $ids satisfies text() = $id]]"/> -->
        </CriteriaTaxonomy>
    </xsl:template>

    <xsl:template match="ccv:Criterion">
        <Criterion id="{cbc:ID/text()}" required="false">
            <Type><xsl:value-of select="cbc:TypeCode/text()"/></Type>
            <Name code="...">
                <Source><xsl:value-of select="cbc:Name/text()"/></Source>
                <Translation lang="nb"><xsl:comment select="' ... '"/></Translation>
            </Name>
            <Description code="...">
                <Source><xsl:value-of select="cbc:Description/text()"/></Source>
                <Translation lang="nb"><xsl:comment select="' ... '"/></Translation>
            </Description>

            <xsl:apply-templates select="ccv:LegislationReference"/>

            <xsl:for-each select="ccv:RequirementGroup">
                <RequirementGroupId><xsl:value-of select="cbc:ID/text()"/></RequirementGroupId>
            </xsl:for-each>
        </Criterion>
    </xsl:template>

    <xsl:template match="ccv:LegislationReference">
        <LegislationTitle code="...">
            <Source><xsl:value-of select="ccv-cbc:Title/text()"/></Source>
            <Translation lang="nb"><xsl:comment select="' ... '"/></Translation>
        </LegislationTitle>
        <LegislationDescription code="...">
            <Source><xsl:value-of select="cbc:Description/text()"/></Source>
            <Translation lang="nb"><xsl:comment select="' ... '"/></Translation>
        </LegislationDescription>
        <JurisdictionLevel><xsl:value-of select="ccv-cbc:JurisdictionLevelCode/text()"/></JurisdictionLevel>
        <Article><xsl:value-of select="ccv-cbc:Article/text()"/></Article>
        <URI><xsl:value-of select="cbc:URI/text()"/></URI>
    </xsl:template>

    <xsl:template match="ccv:RequirementGroup">
        <RequirementGroup id="{cbc:ID/text()}">
            <xsl:if test="@pi">
                <ProsessingInstruction><xsl:value-of select="@pi" /></ProsessingInstruction>
            </xsl:if>
            <xsl:for-each select="ccv:Requirement">
                <RequirementId><xsl:value-of select="cbc:ID/text()"/></RequirementId>
            </xsl:for-each>
            <xsl:for-each select="ccv:RequirementGroup">
                <RequirementGroupId><xsl:value-of select="cbc:ID/text()"/></RequirementGroupId>
            </xsl:for-each>
        </RequirementGroup>
    </xsl:template>

    <xsl:template match="ccv:Requirement">
        <Requirement id="{cbc:ID/text()}">
            <Description code="...">
                <Source><xsl:value-of select="cbc:Description"/></Source>
                <Translation lang="nb"><xsl:comment select="' ... '"/></Translation>
            </Description>
            <Response><xsl:value-of select="@responseDataType"/></Response>
        </Requirement>
    </xsl:template>

</xsl:stylesheet>

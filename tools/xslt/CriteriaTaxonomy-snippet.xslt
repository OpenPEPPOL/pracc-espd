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
                xmlns:ct="urn:fdc:difi.no:2017:vefa:espd:CriteriaTaxonomy-1"
                exclude-result-prefixes="ct">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/ct:CriteriaTaxonomy">
        <Snippets>
            <xsl:apply-templates select="ct:Criterion"/>
            <xsl:apply-templates select="ct:RequirementGroup"/>
            <xsl:apply-templates select="ct:Requirement"/>
        </Snippets>
    </xsl:template>

    <xsl:template match="ct:Criterion">
        <xsl:comment> tag::criterion-<xsl:value-of select="@id"/>[] </xsl:comment>
        <ccv:Criterion>
            <cbc:ID schemeID="CriteriaID" schemeAgencyID="EU-COM-GROW" schemeVersionID="1.0"><xsl:value-of select="@id"/></cbc:ID>
            <cbc:TypeCode listID="CriteriaTypeCode" listAgencyID="EU-COM-GROW" listVersionID="1.0.2"><xsl:value-of select="ct:Type/text()"/></cbc:TypeCode>
            <cbc:Name><xsl:value-of select="ct:Name/ct:Source/text()"/></cbc:Name>
            <cbc:Description><xsl:value-of select="ct:Description/ct:Source/text()"/></cbc:Description>
            <xsl:if test="ct:LegislationTitle">
                <ccv:LegislationReference>
                    <ccv-cbc:Title><xsl:value-of select="ct:LegislationTitle/ct:Source/text()"/></ccv-cbc:Title>
                    <cbc:Description><xsl:value-of select="ct:LegislationDescription/ct:Source/text()"/></cbc:Description>
                    <ccv-cbc:JurisdictionLevelCode listID="CriterionJurisdictionLevel" listAgencyID="EU-COM-GROW" listVersionID="1.0.2"><xsl:value-of select="ct:JurisdictionLevel/text()"/></ccv-cbc:JurisdictionLevelCode>
                    <ccv-cbc:Article><xsl:value-of select="ct:Article/text()"/></ccv-cbc:Article>
                    <cbc:URI><xsl:value-of select="ct:URI/text()"/></cbc:URI>
                </ccv:LegislationReference>
            </xsl:if>
            <xsl:apply-templates select="ct:RequirementGroupId"/>
        </ccv:Criterion>
        <xsl:comment> end::criterion-<xsl:value-of select="@id"/>[] </xsl:comment>
    </xsl:template>

    <xsl:template match="ct:RequirementGroup">
        <xsl:comment> tag::requirement-group-<xsl:value-of select="@id"/>[] </xsl:comment>
        <ccv:RequirementGroup>
            <xsl:if test="ct:ProsessingInstruction">
                <xsl:attribute name="pi" select="ct:ProsessingInstruction/text()"/>
            </xsl:if>
            <cbc:ID schemeAgencyID="EU-COM-GROW" schemeVersionID="1.0"><xsl:value-of select="@id"/></cbc:ID>
            <xsl:apply-templates select="ct:RequirementId"/>
            <xsl:apply-templates select="ct:RequirementGroupId"/>
        </ccv:RequirementGroup>
        <xsl:comment> end::requirement-group-<xsl:value-of select="@id"/>[] </xsl:comment>
    </xsl:template>

    <xsl:template match="ct:Requirement">
        <xsl:comment> tag::requirement-<xsl:value-of select="@id"/>[] </xsl:comment>
        <ccv:Requirement responseDataType="{ct:Response/text()}">
            <cbc:ID schemeID="CriterionRelatedIDs" schemeAgencyID="EU-COM-GROW" schemeVersionID="1.0"><xsl:value-of select="@id"/></cbc:ID>
            <cbc:Description><xsl:value-of select="ct:Description/ct:Source/text()"/></cbc:Description>
        </ccv:Requirement>
        <xsl:comment> end::requirement-<xsl:value-of select="@id"/>[] </xsl:comment>
    </xsl:template>

    <xsl:template match="ct:RequirementGroupId">
        <xsl:comment> RequirementGroup with identifier '<xsl:value-of select="text()" />'. </xsl:comment>
    </xsl:template>

    <xsl:template match="ct:RequirementId">
        <xsl:comment> Requirement with identifier '<xsl:value-of select="text()" />'. </xsl:comment>
    </xsl:template>

</xsl:stylesheet>

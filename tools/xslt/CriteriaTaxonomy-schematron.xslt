<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:ct="urn:fdc:difi.no:2017:vefa:espd:CriteriaTaxonomy-1"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns="http://purl.oclc.org/dsdl/schematron"
                xmlns:u="utils"
                exclude-result-prefixes="xsl xs ct u">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:param name="pattern_only" select="'false'"/>
    <xsl:param name="prefix" select="'PEPPOLBIS-ESPD-CT'"/>

    <xsl:function name="u:pid" as="xs:string">
        <xsl:param name="id"/>
        <xsl:value-of select="if (string-length(string($id)) &lt; 2) then concat('0', string($id)) else string($id)"/>
    </xsl:function>

    <xsl:function name="u:escape" as="xs:string">
        <xsl:param name="text"/>
        <xsl:value-of select="replace(normalize-space($text), '''', '''''')"/>
    </xsl:function>

    <xsl:template match="/ct:CriteriaTaxonomy">
        <xsl:choose>
            <xsl:when test="$pattern_only = 'true'">
                <xsl:call-template name="pattern"/>
            </xsl:when>
            <xsl:otherwise>
                <schema schemaVersion="iso" queryBinding="xslt2">

                    <title>Information model rules for EHF ESPD</title>

                    <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
                    <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
                    <ns prefix="ccv-cbc" uri="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1"/>
                    <ns prefix="cev-cbc" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1"/>
                    <ns prefix="cev" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1"/>
                    <ns prefix="espd" uri="urn:grow:names:specification:ubl:schema:xsd:ESPDResponse-1"/>
                    <ns prefix="espd-req" uri="urn:grow:names:specification:ubl:schema:xsd:ESPDRequest-1"/>
                    <ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
                    <ns prefix="espd-cbc" uri="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonBasicComponents-1"/>
                    <ns prefix="ccv" uri="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"/>
                    <ns prefix="espd-cac" uri="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonAggregateComponents-1"/>>

                    <xsl:call-template name="pattern"/>
                </schema>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="pattern">
        <pattern>
            <rule context="espd-req:ESPDRequest | espd:ESPDResponse">
                <xsl:for-each select="ct:Criterion[@required = 'true']">
                    <assert id="{concat($prefix, '-C00', u:pid(position() + 1))}"
                            test="{concat('ccv:Criterion[cbc:ID[text() = ''', @id , ''']]')}"
                            flag="fatal">Criterion '<xsl:value-of select="@id" />' MUST be provided.</assert>
                </xsl:for-each>
            </rule>

            <xsl:for-each select="ct:Criterion">
                <xsl:call-template name="Criterion"/>
            </xsl:for-each>

            <!-- Rule to limit criterions provided. -->
            <!-- <rule context="ccv:Criterion">
                <assert id="{concat($prefix, '-C0001')}"
                        test="false()"
                        flag="fatal">Invalid criterion.</assert>
            </rule> -->

            <xsl:for-each select="ct:RequirementGroup">
                <xsl:call-template name="RequirementGroup"/>
            </xsl:for-each>

            <rule context="ccv:RequirementGroup">
                <assert id="{concat($prefix, '-RG0001')}"
                        test="false()"
                        flag="fatal">Invalid requirement group.</assert>
            </rule>

            <xsl:for-each select="ct:Requirement">
                <xsl:call-template name="Requirement"/>
            </xsl:for-each>

            <rule context="ccv:Requirement">
                <assert id="{concat($prefix, '-R0001')}"
                        test="false()"
                        flag="fatal">Invalid requirement.</assert>
            </rule>
        </pattern>
    </xsl:template>

    <xsl:template name="Criterion">
        <xsl:variable name="position" select="u:pid(position())"/>

        <rule context="{concat('ccv:Criterion[cbc:ID[text() = ''', @id , ''']]')}">
            <!-- cbc:TypeCode -->
            <assert id="{concat($prefix, '-C', $position, '01')}"
                    test="{concat('normalize-space(cbc:TypeCode) = ''', u:escape(ct:Type/text()) ,'''')}"
                    flag="fatal">Element 'TypeCode' MUST have value "<xsl:value-of select="ct:Type/text()" />".</assert>

            <!-- cbc:Name -->
            <assert id="{concat($prefix, '-C', $position, '02')}"
                    test="{concat('normalize-space(cbc:Name) = ''', u:escape(ct:Name/ct:Source/text()) ,'''')}"
                    flag="fatal">Element 'Name' MUST have value "<xsl:value-of select="ct:Name/ct:Source/text()" />".</assert>

            <!-- cbc:Description -->
            <assert id="{concat($prefix, '-C', $position, '03')}"
                    test="{concat('normalize-space(cbc:Description) = ''', u:escape(ct:Description/ct:Source/text()) ,'''')}"
                    flag="fatal">Element 'Description' MUST have value "<xsl:value-of select="ct:Description/ct:Source/text()" />".</assert>

            <!-- ccv:LegislationReference -->
            <xsl:if test="not(ct:LegislationTitle)">
                <assert id="{concat($prefix, '-C', $position, '04')}"
                        test="not(ccv:LegislationReference)"
                        flag="fatal">Element 'LegislationReference' MUST NOT be provided.</assert>
            </xsl:if>
            <xsl:if test="ct:LegislationTitle">
                <assert id="{concat($prefix, '-C', $position, '04')}"
                        test="ccv:LegislationReference"
                        flag="fatal">Element 'LegislationReference' MUST be provided.</assert>
            </xsl:if>

            <xsl:for-each select="ct:RequirementGroupId">
                <assert id="{concat($prefix, '-C', $position, '2', position())}"
                        test="{concat('ccv:RequirementGroup[', position() ,'] and normalize-space(ccv:RequirementGroup[', position() , '][current()]/cbc:ID/text()) = ''', normalize-space(text()),'''')}"
                        flag="fatal">Criterion '<xsl:value-of select="parent::node()/@id" />' MUST have RequirementGroup '<xsl:value-of select="normalize-space(text())" />' as child number <xsl:value-of select="position()"/>.</assert>
            </xsl:for-each>
        </rule>

        <xsl:if test="ct:LegislationTitle">
            <rule context="{concat('ccv:Criterion[cbc:ID[text() = ''', @id , ''']]/ccv:LegislationReference')}">
                <!-- ccv-cbc:Title -->
                <assert id="{concat($prefix, '-C', $position, '11')}"
                        test="{concat('normalize-space(ccv-cbc:Title) = ''', u:escape(ct:LegislationTitle/ct:Source/text()) ,'''')}"
                        flag="fatal">Element 'Title' MUST have value "<xsl:value-of select="ct:LegislationTitle/ct:Source/text()" />".</assert>

                <!-- cbc:Description -->
                <assert id="{concat($prefix, '-C', $position, '12')}"
                        test="{concat('normalize-space(cbc:Description) = ''', u:escape(ct:LegislationDescription/ct:Source/text()) ,'''')}"
                        flag="fatal">Element 'Description' MUST have value "<xsl:value-of select="ct:LegislationDescription/ct:Source/text()" />".</assert>

                <!-- ccv-cbc:JurisdictionLevelCode -->
                <assert id="{concat($prefix, '-C', $position, '13')}"
                        test="{concat('normalize-space(ccv-cbc:JurisdictionLevelCode) = ''', ct:JurisdictionLevel/text() ,'''')}"
                        flag="fatal">Element 'JurisdictionLevelCode' MUST have value "<xsl:value-of select="ct:JurisdictionLevel/text()" />".</assert>

                <!-- ccv-cbc:Article -->
                <assert id="{concat($prefix, '-C', $position, '14')}"
                        test="{concat('normalize-space(ccv-cbc:Article) = ''', ct:Article/text() ,'''')}"
                        flag="fatal">Element 'Article' MUST have value "<xsl:value-of select="ct:Article/text()" />".</assert>

                <!-- cbc:URI -->
                <assert id="{concat($prefix, '-C', $position, '15')}"
                        test="{concat('normalize-space(cbc:URI) = ''', ct:URI/text() ,'''')}"
                        flag="fatal">Element 'URI' MUST have value "<xsl:value-of select="ct:URI/text()" />".</assert>
            </rule>
        </xsl:if>
    </xsl:template>

    <xsl:template name="RequirementGroup">
        <xsl:variable name="position" select="u:pid(position())"/>

        <rule context="{concat('ccv:RequirementGroup[cbc:ID[text() = ''', @id , ''']]')}">
            <!-- @pi -->
            <xsl:if test="ct:ProsessingInstruction">
                <assert id="{concat($prefix, '-RG', $position, '01')}"
                        test="{concat('@pi = ''', ct:ProsessingInstruction/text(), '''')}"
                        flag="fatal">Attribute 'pi' MUST have value "<xsl:value-of select="ct:ProsessingInstruction/text()" />".</assert>
            </xsl:if>
            <xsl:if test="not(ct:ProsessingInstruction)">
                <assert id="{concat($prefix, '-RG', $position, '01')}"
                        test="not(@pi)"
                        flag="fatal">Attribute 'pi' MUST NOT be provided.</assert>
            </xsl:if>

            <assert id="{concat($prefix, '-RG', $position, '02')}"
                    test="{concat('count(ccv:Requirement) = ', count(ct:RequirementId))}"
                    flag="fatal">Requirement group MUST contain <xsl:value-of select="count(ct:RequirementId)" /> requirement<xsl:if test="count(ct:RequirementId) != 1">s</xsl:if>.</assert>

            <assert id="{concat($prefix, '-RG', $position, '03')}"
                    test="{concat('count(ccv:RequirementGroup) = ', count(ct:RequirementGroupId))}"
                    flag="fatal">Requirement group MUST contain <xsl:value-of select="count(ct:RequirementGroupId)" /> requirement group<xsl:if test="count(ct:RequirementGroupId) != 1">s</xsl:if>.</assert>

            <xsl:for-each select="ct:RequirementId">
                <assert id="{concat($prefix, '-RG', $position, '1', position())}"
                        test="{concat('ccv:Requirement[', position() ,'] and normalize-space(ccv:Requirement[', position() , '][current()]/cbc:ID/text()) = ''', normalize-space(text()),'''')}"
                        flag="fatal">RequirementGroup '<xsl:value-of select="parent::node()/@id" />' MUST have Requirement '<xsl:value-of select="normalize-space(text())" />' as child number <xsl:value-of select="position()"/>.</assert>
            </xsl:for-each>

            <xsl:for-each select="ct:RequirementGroupId">
                <assert id="{concat($prefix, '-RG', $position, '2', position())}"
                        test="{concat('ccv:RequirementGroup[', position() ,'] and normalize-space(ccv:RequirementGroup[', position() , '][current()]/cbc:ID/text()) = ''', normalize-space(text()),'''')}"
                        flag="fatal">RequirementGroup '<xsl:value-of select="parent::node()/@id" />' MUST have RequirementGroup '<xsl:value-of select="normalize-space(text())" />' as child number <xsl:value-of select="position()"/>.</assert>
            </xsl:for-each>

        </rule>
    </xsl:template>

    <xsl:template name="Requirement">
        <xsl:variable name="position" select="u:pid(position())"/>

        <rule context="{concat('ccv:Requirement[cbc:ID[text() = ''', @id , ''']]')}">
            <!-- @responseDataType -->
            <assert id="{concat($prefix, '-R', $position, '01')}"
                    test="{concat('@responseDataType = ''', ct:Response/text(), '''')}"
                    flag="fatal">Response data type MUST be "<xsl:value-of select="ct:Response/text()" />".</assert>

            <!-- cbc:Description -->
            <assert id="{concat($prefix, '-R', $position, '02')}"
                    test="{concat('normalize-space(cbc:Description) = ''', u:escape(ct:Description/ct:Source/text()), '''')}"
                    flag="fatal">Description MUST be "<xsl:value-of select="ct:Description/ct:Source/text()" />".</assert>
        </rule>
    </xsl:template>

</xsl:stylesheet>

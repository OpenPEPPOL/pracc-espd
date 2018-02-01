<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:sch="http://purl.oclc.org/dsdl/schematron"
                xmlns="urn:fdc:difi.no:2017:vefa:structure:Rule-1"
                exclude-result-prefixes="xsl sch">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/sch:pattern">
        <RuleList>
            <Identifier>criteria-taxonomy</Identifier>
            <Name>Criteria Taxonomy</Name>
            <Description>Automatically generated rules to validate the Criteria Taxonomy to be used in ESPD documents.</Description>

            <xsl:apply-templates select="sch:rule/sch:assert"/>
        </RuleList>
    </xsl:template>

    <xsl:template match="sch:assert">
        <Rule>
            <Identifier><xsl:value-of select="@id" /></Identifier>
            <xsl:if test="matches(parent::node()/@context, 'ccv:Criterion\[cbc:ID\[text\(\) = ''(.+)''\]\]')">
                <Property key="doc">target/generated/doc/criterion-<xsl:value-of select="replace(parent::node()/@context, 'ccv:Criterion\[cbc:ID\[text\(\) = ''(.+)''\]\].*', '$1')"/>.adoc</Property>
            </xsl:if>
            <xsl:if test="matches(parent::node()/@context, 'ccv:RequirementGroup\[cbc:ID\[text\(\) = ''(.+)''\]\]')">
                <Property key="doc">target/generated/doc/requirement-group-<xsl:value-of select="replace(parent::node()/@context, 'ccv:RequirementGroup\[cbc:ID\[text\(\) = ''(.+)''\]\]', '$1')"/>.adoc</Property>
            </xsl:if>
            <xsl:if test="matches(parent::node()/@context, 'ccv:Requirement\[cbc:ID\[text\(\) = ''(.+)''\]\]')">
                <Property key="doc">target/generated/doc/requirement-<xsl:value-of select="replace(parent::node()/@context, 'ccv:Requirement\[cbc:ID\[text\(\) = ''(.+)''\]\]', '$1')"/>.adoc</Property>
            </xsl:if>
            <Context><xsl:value-of select="parent::node()/@context" /></Context>
            <Test><xsl:value-of select="@test" /></Test>
            <Flag><xsl:value-of select="@flag" /></Flag>
            <Message><xsl:value-of select="text()"/></Message>
        </Rule>
    </xsl:template>

</xsl:stylesheet>

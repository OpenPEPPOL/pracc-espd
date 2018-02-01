<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" schemaVersion="iso" queryBinding="xslt2"
        xmlns:u="utils" xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <title>EHF ESPD 1.0 Request</title>

    <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
    <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
    <ns prefix="ccv-cbc" uri="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1"/>
    <ns prefix="cev-cac" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1"/>
    <ns prefix="cev-cbc" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1"/>
    <ns prefix="cev" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1"/>
    <ns prefix="espd" uri="urn:grow:names:specification:ubl:schema:xsd:ESPDResponse-1"/>
    <ns prefix="espd-req" uri="urn:grow:names:specification:ubl:schema:xsd:ESPDRequest-1"/>
    <ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
    <ns prefix="espd-cbc" uri="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonBasicComponents-1"/>
    <ns prefix="ccv" uri="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"/>
    <ns prefix="espd-cac" uri="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonAggregateComponents-1"/>
    <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
    <ns prefix="u" uri="utils"/>

    <!-- Functions -->

    <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:mod11" as="xs:boolean">
        <param name="val"/>
        <variable name="length" select="string-length($val) - 1"/>
        <variable name="digits" select="reverse(for $i in string-to-codepoints(substring($val, 0, $length + 1)) return $i - 48)"/>
        <variable name="weightedSum" select="sum(for $i in (0 to $length - 1) return $digits[$i + 1] * (($i mod 6) + 2))"/>
        <value-of select="number($val) &gt; 0 and (11 - ($weightedSum mod 11)) mod 11 = number(substring($val, $length + 1, 1))"/>
    </function>

    <include href="parts/empty-elements.sch"/>
    <include href="parts/common.sch"/>
    <include href="../../target/generated/request-basic.sch"/>
    <include href="../../target/generated/CriteriaTaxonomy.sch"/>

</schema>
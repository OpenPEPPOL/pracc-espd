<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:u="utils">

    <let name="special_rg" value="tokenize('c0cd9c1c-e90a-4ff9-bce3-ac0fe31abf16 096686e1-82ca-4de0-8710-d74d90da0f0c 96defecc-7d32-4957-82e9-aad5f3c5b736 96f00020-0a25-402e-b850-2378e83b5695', '\s')"/>

    <!-- Requirement -->

    <rule context="ccv:RequirementGroup[/espd:ESPDResponse][@pi='GROUP_FULFILLED.ON_TRUE'][normalize-space(../ccv:Requirement[1]/ccv:Response/ccv-cbc:Indicator) = 'false']//ccv:RequirementGroup[@pi]//ccv:Requirement">
        <assert id="PEPPOLBIS-ESPD-R112"
                test="not(ccv:Response)"
                flag="fatal">Response MUST NOT be provided when response is not expected.</assert>
    </rule>

    <rule context="ccv:RequirementGroup[/espd:ESPDResponse][@pi='GROUP_FULFILLED.ON_TRUE'][normalize-space(../ccv:Requirement[1]/ccv:Response/ccv-cbc:Indicator) = 'false']//ccv:Requirement">
        <assert id="PEPPOLBIS-ESPD-R110"
                test="not(ccv:Response)"
                flag="fatal">Response MUST NOT be provided when response is not expected.</assert>
    </rule>

    <rule context="ccv:RequirementGroup[/espd:ESPDResponse][@pi='GROUP_FULFILLED.ON_FALSE'][normalize-space(../ccv:Requirement[1]/ccv:Response/ccv-cbc:Indicator) = 'true']//ccv:Requirement">
        <assert id="PEPPOLBIS-ESPD-R111"
                test="not(ccv:Response)"
                flag="fatal">Response MUST NOT be provided when response is not expected.</assert>
    </rule>

    <rule context="ccv:RequirementGroup[/espd:ESPDResponse][some $code in $special_rg satisfies normalize-space(cbc:ID) = $code]/ccv:Requirement">
        <assert id="PEPPOLBIS-ESPD-R113"
                test="ccv:Response or count(../ccv:Requirement/ccv:Response) = 0"
                flag="fatal">Response MUST be provided for all requirements in this group.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse]">
        <assert id="PEPPOLBIS-ESPD-R100"
                test="ccv:Response"
                flag="fatal">Response MUST be provided.</assert>
        <assert id="PEPPOLBIS-ESPD-R101"
                test="not(ccv:Response) or count(ccv:Response/*) - count(ccv:Response/cbc:ID) = 1"
                flag="fatal">Response MUST contain only the specified response type.</assert>
    </rule>
    <rule context="ccv:Requirement[/espd-req:ESPDRequest]">
        <assert id="PEPPOLBIS-ESPD-R102"
                test="not(ccv:Response)"
                flag="fatal">Response MUST NOT be provided in ESPD Request.</assert>
    </rule>

    <!-- Response -->

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'AMOUNT']/ccv:Response">
        <assert id="PEPPOLBIS-ESPD-R120"
                test="cbc:Amount"
                flag="fatal">Amount element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'CODE']/ccv:Response">
        <assert id="PEPPOLBIS-ESPD-R121"
                test="ccv-cbc:Code"
                flag="fatal">Code element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'CODE_COUNTRY']/ccv:Response">
        <assert id="PEPPOLBIS-ESPD-R122"
                test="ccv-cbc:Code"
                flag="fatal">Code element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'DATE']/ccv:Response">
        <assert id="PEPPOLBIS-ESPD-R123"
                test="cbc:Date"
                flag="fatal">Date element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'DESCRIPTION']/ccv:Response">
        <assert id="PEPPOLBIS-ESPD-R124"
                test="cbc:Description"
                flag="fatal">Description element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'EVIDENCE_URL']/ccv:Response">
        <assert id="PEPPOLBIS-ESPD-R125"
                test="cev-cac:Evidence"
                flag="fatal">Evidence element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'INDICATOR']/ccv:Response">
        <assert id="PEPPOLBIS-ESPD-R126"
                test="ccv-cbc:Indicator"
                flag="fatal">Indicator element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'PERCENTAGE']/ccv:Response">
        <assert id="PEPPOLBIS-ESPD-R127"
                test="cbc:Percent"
                flag="fatal">Percent element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'PERIOD']/ccv:Response">
        <assert id="PEPPOLBIS-ESPD-R128"
                test="cac:Period"
                flag="fatal">Period element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'QUANTITY_INTEGER']/ccv:Response">
        <assert id="PEPPOLBIS-ESPD-R129"
                test="cbc:Quantity[not(@unitCode)]"
                flag="fatal">Quantity element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'QUANTITY_YEAR']/ccv:Response">
        <assert id="PEPPOLBIS-ESPD-R130"
                test="cbc:Quantity[@unitCode = 'YEAR']"
                flag="fatal">Quantity element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'QUANTITY']/ccv:Response">
        <assert id="PEPPOLBIS-ESPD-R131"
                test="cbc:Quantity[@unitCode and @unitCode != 'YEAR']"
                flag="fatal">Quantity element MUST be provided as response when specified.</assert>
    </rule>

    <!-- Additional Document Reference -->

    <rule context="cac:AdditionalDocumentReference[/espd:ESPDResponse][normalize-space(cbc:DocumentTypeCode) = 'TED_CN']">
        <assert id="PEPPOLBIS-ESPD-R211"
                test="not(cbc:IssueDate) and not(cbc:IssueTime)"
                flag="fatal">TED reference MUST NOT contain issue date and issue time.</assert>
        <assert id="PEPPOLBIS-ESPD-R212"
                test="cbc:ID"
                flag="fatal">TED reference MUST contain an identifier.</assert>
        <assert id="PEPPOLBIS-ESPD-R213"
                test="matches(normalize-space(cbc:ID/text()), '^[0-9]{4}/S [0-9]{3}\-[0-9]{6}$')"
                flag="fatal">TED reference MUST match '[][][][]/S [][][]-[][][][][][]' (e.g. 2015/S 252-461137).</assert>
        <assert id="PEPPOLBIS-ESPD-R214"
                test="normalize-space(cbc:ID/text()) != '0000/S 000-000000'"
                flag="fatal">TED reference MUST not be a temporary value.</assert>
    </rule>

    <rule context="cac:AdditionalDocumentReference[/espd:ESPDResponse][normalize-space(cbc:DocumentTypeCode) = 'ESPD_REQUEST']">
        <assert id="PEPPOLBIS-ESPD-R221"
                test="not(cac:Attachment/cbc:URI)"
                flag="fatal">NGOJ reference MUST NOT contain issue date, issue time and attachment.</assert>
        <assert id="PEPPOLBIS-ESPD-R222"
                test="cbc:IssueDate"
                flag="fatal">ESPD Request reference MUST contain an issue date.</assert>
    </rule>

    <rule context="cac:AdditionalDocumentReference[normalize-space(cbc:DocumentTypeCode) = 'NGOJ']">
        <!-- No special rules at the moment... -->
    </rule>

    <rule context="cac:AdditionalDocumentReference">
        <!-- Not allowed type -->
        <assert id="PEPPOLBIS-ESPD-R200"
                test="not(/espd-req:ESPDRequest)"
                flag="fatal">ESPD Request MUST contain only document reference 'NGOJ'.</assert>
        <assert id="PEPPOLBIS-ESPD-R201"
                test="not(/espd:ESPDResponse)"
                flag="fatal">ESPD Responst MUST contain only document references 'TED_CN', 'ESPD_REQUEST' and 'NGOJ'.</assert>
    </rule>

    <!-- Formatting -->

    <rule context="cbc:IssueDate | cbc:BirthDate | cbc:Date">
        <assert id="PEPPOLBIS-ESPD-R020"
                test="(normalize-space(text()) castable as xs:date) and string-length(normalize-space(text())) = 10"
                flag="fatal">A date must be formatted YYYY-MM-DD.</assert>
    </rule>

    <rule context="cbc:IssueTime">
        <assert id="PEPPOLBIS-ESPD-R021"
                test="(normalize-space(text()) castable as xs:time) and string-length(normalize-space(text())) = 8"
                flag="fatal">A time must be formatted hh:mm:ss.</assert>
    </rule>

    <rule context="espd-cac:EconomicOperatorParty/cac:Party/cac:PartyIdentification/cbc:ID[@schemeID = 'NO:ORGNR'] | cbc:EndpointID[@schemeID = 'NO:ORGNR']">
        <assert id="PEPPOLBIS-ESPD-R022"
                test="matches(normalize-space(text()), '^[0-9]{9}$') and u:mod11(normalize-space(text()))"
                flag="fatal">MUST be a valid Norwegian organization number. Only numerical value allowed</assert>
    </rule>

</pattern>
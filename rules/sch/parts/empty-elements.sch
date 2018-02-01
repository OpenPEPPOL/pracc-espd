<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">

    <rule context="ccv:Response">
        <!-- For convenience... -->
    </rule>
    <rule context="cbc:* | ccv-cbc:* | cev-cbc:* | espd-cbc:*">
        <assert id="PEPPOLBIS-ESPD-R001"
                test=". != ''"
                flag="fatal">Document MUST not contain empty elements.</assert>
    </rule>
    <rule context="cac:* | cev:* | ccv:* | espd-cac:*">
        <assert id="PEPPOLBIS-ESPD-R002"
                test="count(*) != 0"
                flag="fatal">Document MUST not contain empty elements.</assert>
    </rule>

</pattern>

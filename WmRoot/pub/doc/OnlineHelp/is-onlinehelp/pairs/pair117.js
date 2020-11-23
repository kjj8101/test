var pairs =
{
"add":{"mapping":1}
,"mapping":{"screen":1,"add":1,"issuer":1,"click":1,"changes":1}
,"screen":{"screen":1,"heading":1,"add":1,"click":1,"issuer":1}
,"heading":{"security":1}
,"security":{"jwt":1,"menu":1}
,"jwt":{"issuer":1,"security":1,"screen":1}
,"issuer":{"certificate":1,"name":1,"select":1}
,"certificate":{"mappings":1,"open":1,"mapping":1,"alias":1,"associated":1}
,"mappings":{"add":1,"jwt":1,"return":1}
,"open":{"add":1}
,"click":{"jwt":1,"issuer":1,"add":1,"return":1}
,"menu":{"navigation":1}
,"navigation":{"panel":1}
,"panel":{"click":1}
,"return":{"issuer":1}
,"name":{"trusted":1,"truststore":1}
,"trusted":{"issuer":1}
,"select":{"required":1}
,"required":{"issuer":1,"truststore":1,"certificate":1}
,"truststore":{"alias":1,"contains":1}
,"alias":{"specifies":1,"truststore":1,"certificate":1,"select":1,"save":1}
,"specifies":{"truststore":1,"certificate":1}
,"contains":{"certificates":1}
,"certificates":{"signing":1}
,"signing":{"authorities":1}
,"authorities":{"associated":1}
,"associated":{"selected":1,"truststore":1}
,"selected":{"issuer":1}
,"save":{"changes":1}
,"changes":{"updates":1,"effect":1}
,"updates":{"integration":1}
,"integration":{"server":1}
,"server":{"issuer":1}
,"effect":{"immediately":1}
,"immediately":{"related":1}
,"related":{"topics":1}
}
;Search.control.loadWordPairs(pairs);

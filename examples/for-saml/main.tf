data "alicloud_caller_identity" "current" {}

locals {
  account_id          = data.alicloud_caller_identity.current.account_id
  resource_name_prefix = "tfmod-ram-role-for-saml"
  saml_metadata_xml    = base64encode(<<EOF
<?xml version="1.0" encoding="UTF-8"?><md:EntityDescriptor xmlns:md="urn:oasis:names:tc:SAML:2.0:metadata" ID="SIMPCp1J9vJt142Dvg5AT2Efcn9JumMe7fau" entityID="https://574b3zcn.aliyunidaas.com/api/v2/app_m6rpawvpeqcjluw7dvyhp37gzu/saml2/meta" validUntil="2125-02-05T05:00:10.578Z">
<md:IDPSSODescriptor protocolSupportEnumeration="urn:oasis:names:tc:SAML:2.0:protocol">
<md:KeyDescriptor use="signing">
<ds:KeyInfo xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
<ds:X509Data>
<ds:X509Certificate>MIIEAjCCAuqgAwIBAgISEH+GOmaGPW7IZC3hh16g1krWMA0GCSqGSIb3DQEBCwUAMIGSMScwJQYDVQQDDB5hcHBfbTZycGF3dnBlcWNqbHV3N2R2eWhwMzdnenUxKTAnBgNVBAsMIGlkYWFzX2V6bWFyNnNna2lkeXI3cHd5eHR2dGdzemdlMRwwGgYDVQQKDBNBbGliYWJhIENsb3VkIElEYWFTMREwDwYDVQQIDAhaaGVqaWFuZzELMAkGA1UEBhMCQ04wHhcNMjUwMjA0MTYwMDAwWhcNNDAwMjA0MTYwMDAwWjCBkjEnMCUGA1UEAwweYXBwX202cnBhd3ZwZXFjamx1dzdkdnlocDM3Z3p1MSkwJwYDVQQLDCBpZGFhc19lem1hcjZzZ2tpZHlyN3B3eXh0dnRnc3pnZTEcMBoGA1UECgwTQWxpYmFiYSBDbG91ZCBJRGFhUzERMA8GA1UECAwIWmhlamlhbmcxCzAJBgNVBAYTAkNOMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApYHREzBN9kDQCWG43gB4rvv4wswb0SjAorzWXCfHfTdf9BBbTb4s4wJsTMAawN38d7mMeGfkJ0Od0TA9CSZaGznQ/MrvaMcMELS4yunOqWf1IdYr4reQe32CiaXT5SBykjfl+E56nyN2DGH0jpCXkryv1wMnxomlmhXjD7eSn1D7qvHbz335M6Ik4N1VEYUCAF2LrcZl3PbxFdrpQ2B9uxkrVZDPDCDggWLBx0XWHQeVUKP6YrPoSZ83hsVVf3AC/SpV1f3I13Za9zIROdvQdcJcZwk9om96H22gp0P8187sxpGj4EkHt9WvjEKbcgSQp5NDR4iBjILbnr9B0fE4pQIDAQABo1AwTjAMBgNVHRMEBTADAQH/MB0GA1UdDgQWBBQb3bj2zAMJ2dbWVOfaZRO8f3eU4DAfBgNVHSMEGDAWgBQb3bj2zAMJ2dbWVOfaZRO8f3eU4DANBgkqhkiG9w0BAQsFAAOCAQEARVxXGYov5MeeadhAYIPG5+3Xc7YY7/V8Z+AzjMATDWEt4saetQHwsCY8zVFNtdwgmo3SGYBVPvb32u2N4B02+HqVQSom2g/17+TpqR2l0LBrdLNNUaZd+hW1B3wQK7CTW/QvsdGtJqXaNts2hfWNZKQ+9B9FFxBk2Y5Cx+fI/SCfK0XosJmDJQnqQLk87wieCc4n1OlbwrCWPYeOAfMxYiQtUTvpjgOf3/uFNAbZFyRcQ8IuLdSHl7PPRZeozRYabeil5nMBWl7K7/S9CFFwMO1plILwurb9VTsfqxh57+2VAcAhlavZFTmvpkRyxl0xUfTLViktSChtCUbp2yTMVA==</ds:X509Certificate>
</ds:X509Data>
</ds:KeyInfo>
</md:KeyDescriptor>
<md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified</md:NameIDFormat>
<md:NameIDFormat>urn:oasis:names:tc:SAML:2.0:nameid-format:persistent</md:NameIDFormat>
<md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</md:NameIDFormat>
<md:SingleSignOnService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST" Location="https://574b3zcn.aliyunidaas.com/login/app/app_m6rpawvpeqcjluw7dvyhp37gzu/saml2/sso"/>
<md:SingleSignOnService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect" Location="https://574b3zcn.aliyunidaas.com/login/app/app_m6rpawvpeqcjluw7dvyhp37gzu/saml2/sso"/>
</md:IDPSSODescriptor>
</md:EntityDescriptor>
EOF
    )
}

resource "alicloud_ram_saml_provider" "provider1" {
  saml_provider_name            = "${local.resource_name_prefix}-provider1"
  encodedsaml_metadata_document = local.saml_metadata_xml
  description                   = "saml provider #1 created by RAM terraform module example."
}

resource "alicloud_ram_saml_provider" "provider2" {
  saml_provider_name            = "${local.resource_name_prefix}-provider2"
  encodedsaml_metadata_document = local.saml_metadata_xml
  description                   = "saml provider #2 created by RAM terraform module example."
}

resource "alicloud_ram_saml_provider" "provider3" {
  saml_provider_name            = "${local.resource_name_prefix}-provider3"
  encodedsaml_metadata_document = local.saml_metadata_xml
  description                   = "saml provider #3 created by RAM terraform module example."
}

####################################################
# basic usage
####################################################
module "example" {
  source = "../../modules/ram-role-for-saml"
  role_name = "${local.resource_name_prefix}-example"

  provider_id = alicloud_ram_saml_provider.provider1.arn
  provider_ids = [
    alicloud_ram_saml_provider.provider2.arn,
    alicloud_ram_saml_provider.provider3.arn,
  ]

  managed_system_policy_names = [
    "AliyunRAMReadOnlyAccess",
  ]
}

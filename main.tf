
locals {
  json_data = jsondecode(file("${path.module}/files/data.json"))

  #my_roles = [for custom_metadata in local.json_data.custom_metadata : custom_metadata.appid]

  vault_policy_file = (templatefile("${path.module}/files/policy.tftpl", {
    vault_roles = [local.json_data.custom_metadata.roles]
    }))

}


output "template" {
    value = local.vault_policy_file
}
/*
resource "vault_policy" "policy-per-role" {
  for_each = local.inputhumanmap
  name   = "policy-for-${each.key}"
  policy = <<EOF
 path "secret/{{${each.value.role}}}" {
    capabilities = ["create", "read", "update", "delete", "list" ]
 }
 EOF
}
*/



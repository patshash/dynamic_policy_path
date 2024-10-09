
locals {
  json_data = jsondecode(file("${path.module}/files/data.json"))

  vault_policy_file = (templatefile("${path.module}/files/policy.tftpl", {
    vault_roles = toset(local.json_data.custom_metadata.roles[*])
    }))
}

output "template" {
    value = local.vault_policy_file
}

resource "vault_policy" "policy-per-role" {
  name   = "policy-for-appid"
  policy = local.vault_policy_file
}



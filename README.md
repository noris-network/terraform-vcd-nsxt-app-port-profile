# terraform-vcd-nsxt-app-port-profile

Terraform module which manages NSX-T Application Port Profile ressources on VMWare Cloud Director.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.9 |
| <a name="requirement_vcd"></a> [vcd](#requirement\_vcd) | >= 3.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vcd"></a> [vcd](#provider\_vcd) | 3.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vcd_nsxt_app_port_profile.nsxt_app_port_profile](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/nsxt_app_port_profile) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_ports"></a> [app\_ports](#input\_app\_ports) | At least one block of Application Port definition. | <pre>list(object({<br>    protocol = string<br>    port     = set(string)<br>  }))</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A unique name for Port Profile. | `string` | n/a | yes |
| <a name="input_context_id"></a> [context\_id](#input\_context\_id) | ID of NSX-T Manager, VDC or VDC Group. It accepts VDC, VDC Group or NSX-T Manager ID. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) An optional description of the Application Port Profile. | `string` | `null` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | Application Port Profile scope - PROVIDER, TENANT. Default: TENANT | `string` | `"TENANT"` | no |
| <a name="input_vdc_org_name"></a> [vdc\_org\_name](#input\_vdc\_org\_name) | The name of the organization to use. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Port Profile. |
<!-- END_TF_DOCS -->

## Examples

### Single instance


```
module "app_port_profile" {
  source       = "git::https://github.com/noris-network/terraform-vcd-nsxt-app-port-profile?ref=1.0.0"
  vdc_org_name = "myORG"
  name         = "myPort"
  app_ports    = {
    protocol = "TCP"
    port     = ["31337"]
  }
}
```

### Real world example

```
locals {
  port_profiles = [
    {
      name = "webserver"
      app_ports = [
        {
          protocol = "TCP"
          port     = ["80", "81-82"]
        }.
        {
          protocol = "TCP"
          port     = ["83"]
        },
        { protocol = "ICMP" }
      ]
    },
    {
      name = "db"
      app_ports = [
        {
          protocol = "TCP"
          port     = ["1111"]
        }
      ]
    }
  ]
}

module "app_port_profiles" {
  source       = "git::https://github.com/noris-network/terraform-vcd-nsxt-app-port-profile?ref=1.0.0"
  for_each     = { for profile in locals.port_profiles : profile.name => profile }
  vdc_org_name = var.vdc_org_name
  name         = each.value.name
  app_ports    = each.value.app_ports
}
```

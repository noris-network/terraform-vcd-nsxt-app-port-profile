resource "vcd_nsxt_app_port_profile" "nsxt_app_port_profile" {
  org        = var.vdc_org_name
  context_id = var.context_id
  name       = var.name
  scope      = var.scope

  dynamic "app_port" {
    for_each = var.app_ports
    content {
      protocol = app_port.value.protocol
      port     = app_port.value.port
    }
  }
}

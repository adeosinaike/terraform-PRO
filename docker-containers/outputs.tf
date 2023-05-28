# output "container_name" {
#   value       = docker_container.webapp.name
#   description = "name of the container"
# }

# output "container_ipaddr" {
#   value       = join(":", [docker_container.webapp.network_data[0].ip_address, docker_container.webapp.ports[0].external])
#   description = "ip address of the container"
# }

# # output "container_port" {
# #   value       = docker_container.webapp.ports[0].external
# #   description = "ports of the container"
# }

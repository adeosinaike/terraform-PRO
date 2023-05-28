#Create a Docker Network

resource "docker_network" "private_network" {
  name = "norlerge_network"
  driver = "bridge""
  ipam_config {
      subnet = "192.168.20.0"
  }
}
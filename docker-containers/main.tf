
## Pull a docker  image
resource "docker_image" "webserver" {
  name = "adeosinaike/webapp:latest"
}

# Create a container
resource "docker_container" "webapp" {
  image = docker_image.webserver.image_id
  name  = "webapp"
  ports {
    internal = "3000"
    external = "3000"
  }
}


## Pull a docker  image
resource "docker_image" "webserver" {
  name = "adeosinaike/webapp:latest"
}

# Create a container
resource "docker_container" "webapp" {
  image = docker_image.webserver.image_id
  count = 2
  name  = join ("-", ["webapp", random_string.random[count.index].result])
  ports {
    internal = "3000"
    # external = "3000"
  }
}

resource "random_string" "random" {
  count = 2
  length  = 2
  special = false
  upper   = false
}
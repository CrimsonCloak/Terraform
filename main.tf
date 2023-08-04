terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = var.container_name

 /* ports {
    internal = 80
    external = 8000
  } */
}

resource "docker_image" "grafana"  {
name = "grafana/grafana"
keep_locally = false
}

resource "docker_container" "grafana" {
image = docker_image.grafana.image_id
name = "grafana-test"
ports {
    internal = 3000
    external = 3000
  } 
}



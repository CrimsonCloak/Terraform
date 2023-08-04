terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "prometheus" {
  name         = "prom/prometheus"
  keep_locally = false
}

resource "docker_container" "prometheus" {
  image = docker_image.prometheus.image_id
  name  = "prometheus-test"
  ports {
    internal = 9090
    external = 9090
  } 
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



terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

## Add container for Prometheus

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



## Add container for Grafana

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

## Add container for Stardew Exporter? -HIGHLY EXPERIMENTAL-

resource "docker_image" "stardew"  {
name = "aleksandur24/stardewexporter:1.1"
keep_locally = false
}

resource "docker_container" "stardew" {
image = docker_image.stardew.image_id
name = "stardew-test"
ports {
    internal = 9321
    external = 9321
  } 
}

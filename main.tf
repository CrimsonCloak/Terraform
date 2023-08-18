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

variable pwd {
  default = "/home/tux/Desktop/Terraform_experimenting"
}
 # Make network
resource "docker_network" "private_network" {
  name = "stardew"
  ipam_config {
    gateway = "10.0.0.1"
    subnet = "10.0.0.0/24"
  }
}

resource "docker_image" "prometheus" {
  name         = "prom/prometheus"
  keep_locally = false
}

resource "docker_container" "prometheus" {
  image = docker_image.prometheus.image_id
  name  = "prometheus-test"
  networks_advanced {
    name = "stardew"
  }
  host {
    host = "prometheus"
    ip = "10.0.0.2"
  }
  ports {
    internal = 9090
    external = 9090
  } 
  volumes  {
    host_path = "${var.pwd}/prometheus"
    container_path = "/etc/prometheus"
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
  networks_advanced {
    name = "stardew"
  }
  host {
    host = "grafana"
    ip = "10.0.0.4"
  }
  ports {
    internal = 3000
    external = 3000
  } 
#  volumes {
#    host_path = "${var.pwd}/grafana/grafana_data"
#    container_path = "/var/lib/grafana"
#}
}

## Add container for Stardew Exporter? -HIGHLY EXPERIMENTAL-

resource "docker_image" "stardew"  {
name = "aleksandur24/stardewexporter:1.1"
keep_locally = false
}

resource "docker_container" "stardew" {
image = docker_image.stardew.image_id
name = "stardew-test"
networks_advanced {
    name = "stardew"
  }
host {
    host = "stardew"
    ip = "10.0.0.3"
  }
ports {
    internal = 9321
    external = 9321
  } 
  # Bind mounts
volumes {
    host_path = "${var.pwd}/savefile"
    container_path = "/savefile"
}
}

/*
Prometheus:
./prometheus/:/etc/prometheus/

Stardewexporter:
  - ./savefile:/savefile 
  
Grafana:
      - ./grafana/grafana_data:/var/lib/grafana
      - ./grafana/provisioning/:/etc/grafana/provisioning/


*/

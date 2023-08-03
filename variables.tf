variable "container_name" {
  type    = string
  default = "nginx_test"
}

variable "ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 80
      external = 8080
      protocol = "tcp"
    }
  ]
}

variable "subdomain_name" {
  description = "The sub domain to serve the Lambda through (e.g. api.example.com)"
  type        = string
}

variable "domain_name" {
  description = "Domain suffix"
  type        = string
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID for your domain"
  type        = string
}

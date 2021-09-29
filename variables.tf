variable "vpc_id" {
  description = "The VPC ID to deploy to. Must contain the cluster you're deploying to as well as the SG and other bits."
}

variable "environment_variables" {
  default     = "{}"
  description = "This should be a JSON list provided in the typical fashion in which ECS wants them."
}

variable "app_name" {
  default     = "wikijs"
  description = "Override this if you care about the name of the app in ECS. Affects task and service names."
}

variable "wikijs_image_tag" {
  default     = "latest"
  description = "The tag to install. Defaults to latest, but you should probably tie this down."
}

variable "wikijs_docker_repo_uri" {
  default     = "requarks/wiki"
  description = "Defaults to dockerhub per wiki.js documentation."
}

variable "desired_task_count" {
  default     = "2"
  description = "Defaults to two."
}

variable "cluster_security_group_id" {
  description = "This is the SG you want to use to allow the load balancer access to ECS."
}

variable "lb_public_subnets" {
  description = "The list of public subnets your load balancer serves traffic from."
}

variable "lb_cert_arn" {
  description = "We assume SSL termination at the load balancer, so you must give us a valid Cert ARN."
}

variable "service_role_arn" {
  description = "This is the service role ARN required for the service to run inside ECS. The default one from AWS will suffice."
}

variable "wikijs_app_port" {
  default     = 3000
  description = "The default per wikijs documentation is 3000."
}

variable "deployment_cluster_name" {
  description = "The name of the cluster to deploy to."
}
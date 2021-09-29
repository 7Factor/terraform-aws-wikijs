terraform {
  required_version = ">=0.12.3"
}

data "aws_region" "current" {}

module "wiki_js" {
  source = "github.com/7factor/terraform-ecs-http-task"
  # Where we want to deploy the thing
  vpc_id       = var.vpc_id
  cluster_name = var.deployment_cluster_name

  # Information about what we're deploying
  app_name         = var.app_name
  app_port         = var.wikijs_app_port
  service_role_arn = var.service_role_arn

  # Load balancers and health checking
  health_check_path    = "/"
  health_check_matcher = "200,302"
  health_check_timeout = 15
  lb_cert_arn          = var.lb_cert_arn
  lb_public_subnets    = var.lb_public_subnets
  cluster_lb_sg_id     = var.cluster_lb_sg_id
  desired_task_count   = var.desired_task_count

  # Let's start with a hard coded container definition. A zero as host port means
  # we want an ephemeral range of ports.
  container_definition = <<EOF
[
  {
    "image": "${var.wikijs_docker_repo_uri}:${var.wikijs_image_tag}",
    "name": "${var.app_name}",
    "portMappings": [
      {
        "containerPort": ${var.wikijs_app_port},
        "hostPort": 0
      }
    ],
    "environment": ${var.environment_variables},
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
          "awslogs-group": "ecs-logs",
          "awslogs-region": "${data.aws_region.current.name}",
          "awslogs-stream-prefix": "${var.app_name}",
          "awslogs-create-group": "true"
      }
    }
  }
]
EOF
}
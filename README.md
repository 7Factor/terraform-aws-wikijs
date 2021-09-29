# WikiJS on AWS via Terraform

This module will allow you to publish a [wikijs](https://docs.requarks.io]) on your own ECS infrastructure. 
We support custom environment variables and you should only need to point this to a cluster and everything will
light up.

We will terraform a load balancer, target group, and everything in between based on the documentation provided in
our `ecs-https-task` module located [here](https://github.com/7Factor/terraform-ecs-http-task). We will *not* terraform
an RDS instance, that is left up to the reader. You can easily pass DB information into the container via ECS. See the
wikijs documentation for the appropriate port names and configuration variables.

Most of what you need to know is provided in the `variables.tf`.

For persistent storage we usually combine this module with an outer shell that provisions an RDS PostgreSQL instance 
and we pass the credentials in securely. We do this because it allows us to segregate the RDS instance from the wiki 
so if we need to blow away the instance we can without worrying about having to reprovision a database.

This module should be fairly set-and-forget as we've put a lot of man hours into improving it. Feel free to hit us up 
via email or fork this repo and send PRs if you can think of a way to improve it!

## Example Usage

```hcl-terraform
module "wikijs_deployment" {
  source = "github.com/7Factor/terraform-aws-wikijs.git"

  vpc_id = "my-vpc"
  app_name = "7f-wikijs"

  lb_cert_arn = "arn:aws:acm:us-east-1:acct:certificate/hash"
  lb_public_subnets = ["subnet-1","subnet-2"]
  cluster_security_group_id = "ecs-sg"

  service_role_arn = "arn:aws:iam::acct-id:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  deployment_cluster_name = "cluster"

  environment_variables = { ... }
}
```
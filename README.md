# WikiJS on AWS via Terraform

This module will allow you to publish a (wikijs)[https://docs.requarks.io] on your own ECS infrastructure. 
We support custom environment variables and you should only need to point this to a cluster and everything will
light up.

We will terraform a load balancer, target group, and everything in between based on the documentation provided in
our `ecs-https-task` module located (here)[https://github.com/7Factor/terraform-ecs-http-task].

Most of what you need to know is provided in an example tfvars file, and feel free to peruse the `variables.tf` for 
documentation on the required variables to run the terraform.

For persistent storage we usually combine this module with an outer shell that provisions an RDS PostgreSQL instance 
and we pass the credentials in securely. We do this because it allows us to segregate the RDS instance from the wiki 
so if we need to blow away the instance we can without worrying about having to reprovision a database.

This module should be fairly set-and-forget as we've put a lot of man hours into improving it. Feel free to hit us up 
via email or fork this repo and send PRs if you can think of a way to improve it!

## Example Usage

```hcl-terraform
# write me
```
output "lb_dns" {
  value       = module.wiki_js.lb_hostname
  description = "The DNS value of your LB hosting the concourse cluster. Point your FQDN to it."
}

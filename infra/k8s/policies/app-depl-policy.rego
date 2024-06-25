package main

deny_missing_env_for_db_url[message] {
	input.kind == "Deployment"
	not input.spec.template.spec.containers[0].env[0].name == "PGURL"
	message := "The container in the Deployment must have a 'PGURL' environment variable."
}

deny_no_corresponding_depl_exist[message] {
	some i
	input[i].contents.kind == "Service"
	svc := input[i].contents
	svc_selector := svc.spec.selector
	not match_depl_labels(svc_selector)
	message := sprintf("Service '%v' with selector '%v' does not match any Deployments", [svc.metadata.name, svc_selector.app])
}

match_depl_labels(svc_selector) {
	some j
	input[j].contents.kind == "Deployment"
	depl := input[j].contents
	object.subset(depl.spec.template.metadata.labels, svc_selector)
}

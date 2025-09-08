.PHONY: init plan apply destroy validate

init:
	cd environments/dev && terraform init

plan:
	cd environments/dev && terraform plan -var-file="terraform.tfvars"

apply:
	cd environments/dev && terraform apply -auto-approve -var-file="terraform.tfvars"

destroy:
	cd environments/dev && terraform destroy -auto-approve -var-file="terraform.tfvars"

validate:
	cd environments/dev && terraform validate

fmt:
	terraform fmt -recursive
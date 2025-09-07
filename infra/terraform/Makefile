TF_VERSION := 1.5.0
TF_DIR := environments/dev

.PHONY: init plan apply destroy validate fmt setup-backend

init:
	terraform -chdir=$(TF_DIR) init

plan:
	terraform -chdir=$(TF_DIR) plan

apply:
	terraform -chdir=$(TF_DIR) apply -auto-approve

destroy:
	terraform -chdir=$(TF_DIR) destroy -auto-approve

validate:
	terraform validate $(TF_DIR)

fmt:
	terraform fmt -recursive

setup-backend:
	./scripts/setup-backend.sh

# Para otros entornos
dev-plan:
	./scripts/tf-wrapper.sh dev plan

dev-apply:
	./scripts/tf-wrapper.sh dev apply

staging-plan:
	./scripts/tf-wrapper.sh staging plan

prod-plan:
	./scripts/tf-wrapper.sh prod plan
tf-init:
	docker-compose -f deploy/docker-compose.yml run --rm terraform init

tf-workspace-list:
	docker-compose -f deploy/docker-compose.yml run --rm terraform workspace list

tf-workspace-new:
	docker-compose -f deploy/docker-compose.yml run --rm terraform workspace new $(e)

tf-fmt:
	docker-compose -f deploy/docker-compose.yml run --rm terraform fmt

tf-validate:
	docker-compose -f deploy/docker-compose.yml run --rm terraform validate

tf-plan:
	docker-compose -f deploy/docker-compose.yml run --rm terraform plan

tf-apply:
	docker-compose -f deploy/docker-compose.yml run --rm terraform apply

tf-destroy:
	docker-compose -f deploy/docker-compose.yml run --rm terraform destroy

con-ec2:
	aws ssm start-session --target <your-ec2-instance-id> --profile default --region eu-west-1

# Terraform-102 Sainsburys Data Academy

This is a basic example of using Terraform to create an EC2 instance on AWS.

## Requirements

- docker
- docker-compose

## Installation

- Create an environment file `deploy/.env` and put your fresh `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_SESSION_TOKEN` in it. (you can find these credentials with command  `cat ~/.aws/credentials`)
```sh
aws-azure-login --profile bootcamp-sandbox --mode=gui
```

```sh
AWS_ACCESS_KEY_ID=<your-aws-access-key-id>
AWS_SECRET_ACCESS_KEY=<your-aws-secret-access-key>
AWS_SESSION_TOKEN=<your-aws-session-token>
```

## Create

```python
# after every change make sure the syntax of the Terraform commands are right
make tf-validate

# read the plan to see what are going to be created
make tf-plan

# read the plan again and if this is what you want, confirm it
make tf-apply
```

## Destroy

```python
# destroy your created infra
make tf-destroy
```

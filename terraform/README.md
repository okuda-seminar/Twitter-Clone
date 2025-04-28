# Setup AWS
## Create a new AWS account
Refer to [AWS アカウント作成の流れ](https://aws.amazon.com/jp/register-flow/)
## Create a new IAM user
- Create an IAM User to operate terraform. AdministratorAccess seems to be a good choice at first.
- When you create an IAM User, save the AWS Access Key ID and AWS Secret Access Key.
  - TODO: [Configuring IAM Identity Center authentication with the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html)
- Create an aws profile as shown below.
```
$ aws configure --profile x-clone
```
# Use terraform
## Initialize terraform
```
$ cd environments/prd
$ cp vars.tfvars.sample vars.tfvars
$ terraform init -var-file=vars.tfvars
```
terraform.tfvars is a file that contains variables used in terraform. Please set the appropriate value.
- profile: AWS profile name
- account_id: AWS account ID
## Test terraform
```
$ terraform plan -var-file=vars.tfvars
```
## Apply terraform
```
$ terraform apply -var-file=vars.tfvars
```

# Start Backend Server
1. Connect to the EC2 instance using EC2 Instance Connect. (See [Connect using the Amazon EC2 console](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-connect-methods.html#ec2-instance-connect-connecting-console) for instructions.)
2. Start the backend server:
```sh
docker exec -it x_app go run ./cmd/main.go
```

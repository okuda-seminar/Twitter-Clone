# Setup AWS
## Create a new AWS account
Refer to https://aws.amazon.com/jp/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all
## Create a new IAM user
- Create an IAM User to operate terraform. AdministratorAccess seems to be a good choice at first.
- When you create an IAM User, save the AWS Access Key ID and AWS Secret Access Key.
  - TODO: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html
- Create an aws profile as shown below.
```
$ aws configure --profile x-clone
```
# Use terraform
## Initialize terraform
```
$ cd environments/prd
$ cp terraform.tfvars.sample terraform.tfvars
$ terraform init
```
## Test terraform
```
$ terraform plan
```
## Apply terraform
```
$ terraform apply
```
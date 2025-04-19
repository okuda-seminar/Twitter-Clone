# Terraform generally defines the backend configuration for storing the state file.
# However, since each user works on a different AWS project with a unique bucket name, 
# there is no motivation to store the state remotely, so we will manage it locally.

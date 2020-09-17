# GCP Backend State Module

Terraform must store state about your managed infrastructure and configuration. This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures. It is essential that terraform state is not stored in version control repositories. Terraform state can contain sensitive data, depending on the resources in use and your definition of "sensitive." The state contains resource IDs and all resource attributes. For resources such as databases, this may contain initial passwords.

To resolve this, we store terraform state in a remote backend Google Cloud Storage buckets. These buckets are encrypted and secured through cloud IAM, so they are only accessible by those responsible for maintaining and running a terraform project.

This module is designed to easily create secure backend GCS buckets for other terraform-managed projects.

# Using this module
To avoid a chicken and egg problem, we cannot use computed variables or resources in your terraform backend location. Therefore, you need manually create a GCP project and storage bucket, with appropriate IAM roles. Specifically, your terraform service account needs `Project Owner` or `storage.admin` in order to talk to the backend bucket.

Edit `main.tf` and substitute `[myorganization]` for your GCP project and storage bucket. Once you have configured an empty bucket with appropriate IAM roles, and edited `main.tf`, you can execute `terraform init` to initialize the backend repository.

# Creating new Backend Buckets

Edit `state_buckets.tf` with the project name of the bucket you want to store your state file in and the project owner group that will be granted read/write permission to the bucket. The bucket will be automatically named `tf-state-[project_name]` on creation.

# Configuring the terraform backend provider
Once the backend state bucket has been created, edit `main.tf` in your terraform project to include the following, editing the bucket name and required_version as appropriate:

```terraform {
required_version = "=[version]"
backend "gcs" {
  bucket = "tf-state-[project]"
 }
}
```
If you have an existing tfstate file, you will need to upload it to the bucket before you run terraform plan or terraform apply.

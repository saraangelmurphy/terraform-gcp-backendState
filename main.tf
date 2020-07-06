terraform {
  required_version = ">=0.12.26"
  backend "gcs" {
  bucket = "[myorganization]-tf-state"
  }
}

provider "google" {
  version = "~> 3.11"
  project = "[myorganization]-tf-state"
  #module.gcp-create-project.created_project.project_id
}

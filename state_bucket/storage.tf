resource "google_storage_bucket" "state" {
  name = "tf-state-${var.project_name}"
  location = "us"
}

resource "google_storage_bucket_iam_binding" "state-access" {
  bucket = google_storage_bucket.state.name
  role = "roles/storage.admin"
  members = [
    "group:${var.project_owner}",
  ]
}

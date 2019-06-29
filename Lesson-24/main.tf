#----------------------------------------------------------
# My Terraform
#
# Use Terraform with GCP - Google Cloud Platform
#
# Made by Denis Astahov
#
#-----------------------------------------------------------
//export GOOGLE_CLOUD_KEYFILE_JSON="gcp-creds.json"

provider "google" {
  credentials = file("mygcp-creds.json")
  project     = "my-gcp-project-238521"
  region      = "us-west1"
  zone        = "us-west1-c"
}

resource "google_compute_instance" "my_server" {
  name         = "my-gcp-server"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
  }
}

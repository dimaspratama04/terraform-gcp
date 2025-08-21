terraform {
  required_version = ">= 1.11.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.46.0"
    }
  }
}

provider "google" {
  project = "" # sesuaikan dengan project gcp
  region  = "asia-southeast2"

}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.27.0"
    }
  }
 backend "gcs" {
    bucket = "lagaludo"
    prefix = "prod"
  }
 
}

provider google {
  # Configuration options
  credentials = "poop.json"
  project = var.project
  region = var.region
}


# This is the bucket for your state files
resource "google_storage_bucket" "raw" {
  project = var.project
  name = "${var.data_project}-raw"
  force_destroy = false
  uniform_bucket_level_access = true
  location = var.region
  labels = local.labels
}


locals {
    labels = {
        "data-project" = var.data_project
    }
}

variable "project" {
    type= string
    default = "pooper-scooper"
    description = "ID Google project"
}

variable "region" {
    type= string
    default = "europe-central2"
    description = "Region Google project"
}

variable  "data_project" {
    type = string
    default = "my_cicd_tag"
    description = "Name of data pipeline project to use as resource prefix"
}









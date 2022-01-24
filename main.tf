provider "google" {
    project = "qwiklabs-gcp-04-79688b48a19f"
    credentials = file("k1.json")
    region = "us-central1"
    zone = "us-central1-a"

  
}

resource "google_compute_network" "vpc" {
    name = "terraform-test-network"
    auto_create_subnetworks = "true"
    #ipv4_range = "10.128.0.0/20"
    project = "qwiklabs-gcp-04-79688b48a19f"
   # region = "us-central1"


  
}
resource "google_storage_bucket" "b1" {
    name = "terraform-test-bucket-1"
    location = "us-central1"
    project = "qwiklabs-gcp-04-79688b48a19f"
    storage_class = "STANDARD"
    force_destroy = true
  
}

resource "google_storage_bucket_object" "files" {
    name = "python_files"
    bucket = "${google_storage_bucket.b1.name}"
    #content = "Hello World"
    #content_type = "text/plain"
    #storage_class = "STANDARD"
    #force_destroy = true
    source = "python_files.zip" # refers to a local file in your system
  
  
}

resource "google_app_engine_standard_app_version" "app-1" {

    #name = "py-demo"
    #location = "us-central1"
    #network = "google_compute_netwrok.vpc.name"
    runtime = "python37"
    #version_id = "v1"
    #description = "Python Demo"
    version_id = "a1"
    #region = "us-central1"
    entrypoint {
        shell = "pthon app.py"
    }
    deployment {
        zip {
            source_url = "https://storage.googleapis.com/${google_storage_bucket.b1.name}/${google_storage_bucket_object.files.name}"
            #name = "app.yaml"
            #source_url = "https://storage.googleapis.com/qwiklabs-gcp-04-79688b48a19f/python-files"
            #sha256 = "d41d8cd98f00b204e9800998ecf8427e"
          
        }
       
      
    }

    service = "default"


}


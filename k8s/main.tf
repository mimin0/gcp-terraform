resource "google_compute_instance" "default" {
  count        = 3
  name         = "k8s-node-${count.index}"
  machine_type = "e2-medium"
  zone         = "europe-west3-c"

  tags = ["k8s-cluster", "k8s-node-${count.index}"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  //  // Local SSD disk
  //  scratch_disk {
  //    interface = "SCSI"
  //  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = data.template_file.startup.rendered
}

resource "google_compute_firewall" "http-server" {
  name    = "default-allow-ssh-terraform"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443"]

  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["k8s-cluster"]
}
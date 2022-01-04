resource "google_compute_instance" "worker" {
  for_each = { for i in var.workers : i.name => i }

  name         = "${var.deploy_id}-${each.value.name}"
  machine_type = each.value.machine_type
  zone         = each.value.zone

  tags = ["${var.deploy_id}-node", "${var.deploy_id}-worker"]

  metadata = var.ssh_remote_user == "" ? {} : {
    "ssh-keys" = "${var.ssh_remote_user}:${file(var.ssh_public_key)}"
  }

  boot_disk {
    auto_delete = true

    initialize_params {
      size  = 10
      type  = "pd-ssd"
      image = data.google_compute_image.base_image.self_link
    }
  }

  network_interface {
    subnetwork = each.value.subnetwork_id

    access_config {
      network_tier = "STANDARD"
    }
  }

  service_account {
    email  = google_service_account.instance_sa.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "master" {
  for_each = { for i in var.masters : i.name => i }

  name         = "${var.deploy_id}-${each.value.name}"
  machine_type = each.value.machine_type
  zone         = each.value.zone

  tags = ["${var.deploy_id}-node", "${var.deploy_id}-master"]

  metadata = var.ssh_remote_user == "" ? {} : {
    "ssh-keys" = "${var.ssh_remote_user}:${file(var.ssh_public_key)}"
  }

  boot_disk {
    auto_delete = true

    initialize_params {
      size  = 10
      type  = "pd-ssd"
      image = data.google_compute_image.base_image.self_link
    }
  }

  network_interface {
    subnetwork = each.value.subnetwork_id

    access_config {
      network_tier = "STANDARD"
    }
  }

  service_account {
    email  = google_service_account.instance_sa.email
    scopes = ["cloud-platform"]
  }
}

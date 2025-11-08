# Creates a Windows Server 2022 VM instance in GCP
resource "google_compute_instance" "windows_instance" {
  name                          = "${local.windows_name_prefix}001"                                                         # Name of the Windows VM
  machine_type                  = "e2-standard-2"                                                                           # Machine type (compute resources)
  zone                          = "${var.region}-b"                                                                         # Zone for deployment (e.g., us-central1-b)
  boot_disk {
    initialize_params {
      image                     = "projects/windows-cloud/global/images/windows-server-2022-dc-v20250813"                   # Windows Server 2022 from August 2025 to address bug in October 2025 and newer versions that breaks password setting for Windows
    }
  }
  network_interface {
    subnetwork                  = google_compute_subnetwork.cabbage_subnet.name                                             # Subnetwork for the VM
    access_config {
      // Assigns a public IP
    }
  }
  service_account {
    scopes                      = ["cloud-platform"]                                                                        # Full API access for guest agent
  }
  metadata                      = {
    windows-startup-script-ps1  = "netsh advfirewall set allprofiles state off"                                             # Disables firewall on boot
  }
}

# Outputs the public IP of the Windows VM for RDP access
output "gcp_vm_public_ip" {
  value                         = google_compute_instance.windows_instance.network_interface[0].access_config[0].nat_ip     # Public IP address of the VM
  description                   = "Public IP of the GCP Windows VM"                                                         # Description of the output
}

# Outputs the private IP of the Windows VM for internal networking
output "gcp_vm_private_ip" {
  value                         = google_compute_instance.windows_instance.network_interface[0].network_ip                  # Private IP address of the VM
  description                   = "Private IP of the GCP Windows VM"                                                        # Description of the output
}

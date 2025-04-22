# https://developer.hashicorp.com/packer/docs/templates
# https://developer.hashicorp.com/packer/integrations/hashicorp/vagrant
# https://developer.hashicorp.com/packer/integrations/hashicorp/virtualbox

packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
    virtualbox = {
      source  = "github.com/hashicorp/virtualbox"
      version = "~> 1"
    }
  }
}

variable "iso_url" {
  type    = string
  default = "https://software-static.download.prss.microsoft.com/dbazure/888969d5-f34g-4e03-ac9d-1f9786c66749/26100.1742.240906-0331.ge_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso"
}

variable "iso_checksum" {
  type    = string
  default = "sha256:755A90D43E826A74B9E1932A34788B898E028272439B777E5593DEE8D53622AE"
}

variable "features_iso_url" {
  type    = string
  default = "https://software-static.download.prss.microsoft.com/dbazure/888969d5-f34g-4e03-ac9d-1f9786c66749/26100.1.240331-1435.ge_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso"
}

variable "features_iso_checksum" {
  type    = string
  default = "sha256:fdbd87c2cd69ba84ef2ea69d5b468938355d0d634b7de7a1988480f94713a738"
}

source "virtualbox-iso" "windows" {
  vm_name                = "packer-windows"
  headless               = true
  guest_os_type          = "Windows11_64"
  cpus                   = 2
  memory                 = 4096
  gfx_controller         = "vboxsvga"
  gfx_vram_size          = 128
  firmware               = "efi"
  hard_drive_interface   = "sata"
  disk_size              = 32768
  iso_interface          = "sata"
  iso_url                = "${var.iso_url}"
  iso_checksum           = "${var.iso_checksum}"
  guest_additions_mode   = "attach"
  guest_additions_url    = "${var.features_iso_url}"
  guest_additions_sha256 = "${var.features_iso_checksum}"
  # cd_files               = ["./windows/*"]
  vboxmanage = [
    ["storageattach", "{{.Name}}", "--storagectl", "IDE Controller", "--port", "0", "--device", "0", "--type", "dvddrive", "--medium", "./packer.viso"],
    ["storageattach", "{{.Name}}", "--storagectl", "IDE Controller", "--port", "1", "--device", "0", "--type", "dvddrive", "--medium=emptydrive"],
    ["storageattach", "{{.Name}}", "--storagectl", "IDE Controller", "--port", "1", "--device", "0", "--type", "dvddrive", "--medium=additions"],
  ]
  boot_wait        = "5s"
  boot_command     = ["<spacebar><wait2s><spacebar><wait2s><spacebar>"]
  communicator     = "ssh"
  ssh_username     = "vagrant"
  ssh_password     = "vagrant"
  ssh_timeout      = "1h"
  shutdown_command = "shutdown /s /f"
  vboxmanage_post = [
    ["storageattach", "{{.Name}}", "--storagectl", "IDE Controller", "--port", "0", "--device", "0", "--type", "dvddrive", "--medium=none"],
    ["storageattach", "{{.Name}}", "--storagectl", "IDE Controller", "--port", "1", "--device", "0", "--type", "dvddrive", "--medium=none"],
    ["storagectl", "{{.Name}}", "--name", "IDE Controller", "--remove"],
  ]
}

build {
  sources = [
    "source.virtualbox-iso.windows",
  ]
  provisioner "powershell" {
    scripts = [
      "./vagrant/configure-sshd.ps1"
    ]
  }
  provisioner "powershell" {
    scripts = [
      "./virtualbox/install-guestdrivers.ps1"
    ]
  }
  post-processor "vagrant" {
    vagrantfile_template = "./vagrant/windows.vagrantfile.template.rb"
  }
}

# Packer template for a Windows 11 24H2 Vagrant box for VirtualBox

[![xc compatible](https://xcfile.dev/badge.svg)](https://xcfile.dev)

Builds a [Windows 11 24H2 26100.1742](https://learn.microsoft.com/en-us/windows/release-health/windows11-release-information) Enterprise [Vagrant](https://www.vagrantup.com) box for use with [VirtualBox](https://www.virtualbox.org) on an [x86-64](https://en.wikipedia.org/wiki/X86-64) machine.

Uses:

- HashiCorp [Packer](https://www.packer.io)
- HashiCorp [Vagrant](https://www.vagrantup.com)
- Oracle [VirtualBox](https://www.virtualbox.org)
- Microsoft [Windows 11 Enterprise](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-11-enterprise)
- Microsoft [Windows 11 Language and Optional Features](https://learn.microsoft.com/en-us/azure/virtual-desktop/windows-11-language-packs)
- POSIX [shell and utilities](https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap01.html#tag_18)
- [x86-64](https://en.wikipedia.org/wiki/X86-64) build host

## Tasks

### build

Env: PACKER_LOG=1
```sh
packer init .
packer build --force .
```

### add

```sh
vagrant box add --force ./vagrant/windows.box.metadata.json
```

### run

```sh
vagrant init --force --minimal nicerloop/windows
vagrant up
```

### remove

```sh
vagrant box remove --force nicerloop/windows
```

### clean

```sh
vagrant destroy --force || true
git clean -dXf
```

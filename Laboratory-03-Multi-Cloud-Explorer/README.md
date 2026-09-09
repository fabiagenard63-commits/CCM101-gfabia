## Operating System

| Category           | Details                                                       |
|----------------------|-------------------------------------------------------------------|
| Pretty Name          | Ubuntu 24.04.4 LTS                                                |
| Name                 | Ubuntu                                                            |
| Version ID           | 24.04                                                             |
| Version              | 24.04.4 LTS (Noble Numbat)                                        |
| Version Codename     | noble                                                             |
| ID                   | ubuntu                                                            |
| ID Like              | debian                                                            |
| Home URL             | https://www.ubuntu.com/                                          |
| Support URL          | https://help.ubuntu.com/                                         |
| Bug Report URL       | https://bugs.launchpad.net/ubuntu/                                |
| Privacy Policy URL   | https://www.ubuntu.com/legal/terms-and-policies/privacy-policy   |
| Ubuntu Codename      | noble                                                             |
| Logo                 | ubuntu-logo                                                       |


## CPU Information

| Category                  | Details                                                  |
|-----------------------------|-------------------------------------------------------------|
| Architecture                | x86_64                                                      |
| CPU Mode(s)                 | 32-bit, 64-bit                                              |
| Byte Order                  | Little Endian                                               |
| CPU(s)                       | 1 (Single vCPU)                                             |
| Vendor                      | GenuineIntel                                                |
| Model Name                  | Intel Xeon E312xx (Sandy Bridge, IBRS update)               |
| BIOS Vendor                 | Red Hat                                                     |
| BIOS Model                  | RHEL-9.6.0 PC (Q35 + ICH9, 2009)                            |
| CPU Family / Model          | Family 6, Model 42, Stepping 1                              |
| Thread(s) per Core          | 1                                                            |
| Core(s) per Socket          | 1                                                            |
| Socket(s)                   | 1                                                            |
| BogoMIPS                    | 7008.00                                                      |
| Hypervisor                  | KVM (Full Virtualization)                                   |
| NUMA Node(s)                 | 1                                                             |
| L1d Cache                   | 32 KiB                                                       |
| L1i Cache                   | 32 KiB                                                       |
| L2 Cache                    | 4 MiB                                                        |
| L3 Cache                    | 16 MiB                                                       |
| Security Mitigations        | Applied for Meltdown, Spectre v1/v2, MDS, L1TF               |
| Notable Vulnerability Note  | "Mmio stale data" — Unknown: No mitigations                 |

## Memory Space
|              |total        |used        |free      |shared  |buff/cache  |available|
|--------------|-------------|------------|----------|--------|------------|---------|
|Mem:          | 1.9Gi        |424Mi      | 856Mi    |   1.1Mi|       790Mi|      1.4Gi|
|Swap:         | 1.0Gi       |  0B         |1.0Gi    |        |            |           |

## Disk Usage Summary

| Filesystem   | Size  | Used  | Available | Use% | Mounted On   |
|----------------|--------|--------|-------------|--------|----------------|
| tmpfs          | 191M  | 996K  | 190M        | 1%     | /run           |
| /dev/vda1      | 19G   | 5.4G  | 13G         | 30%    | /              |
| tmpfs          | 952M  | 84K   | 952M        | 1%     | /dev/shm       |
| tmpfs          | 5.0M  | 0     | 5.0M        | 0%     | /run/lock      |
| /dev/vda16     | 881M  | 117M  | 703M        | 15%    | /boot          |
| /dev/vda15     | 105M  | 6.2M  | 99M         | 6%     | /boot/efi      |

### If this Linux server were migrated to the cloud, which AWS, Azure, and GCP services could host it?

**AWS** could host it using an EC2 t3.small or t4g.small instance — these burstable, low-cost instance types are built exactly for light workloads like this, and Ubuntu is natively supported as an official AMI, making migration straightforward.

**Azure** could host it using a B1s or B2s Virtual Machine from the Burstable series, which matches the server's low steady CPU usage with occasional bursts, and Ubuntu 24.04 is available directly from the Azure Marketplace.

**GCP** could host it using an e2-small or e2-medium Compute Engine instance, a cost-optimized shared-core VM well-suited for small workloads, with Ubuntu 24.04 available as a ready-to-use image.


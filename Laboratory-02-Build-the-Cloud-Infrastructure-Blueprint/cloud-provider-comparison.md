
| **Infrastructure Component** | **AWS** | **Microsoft Azure** | **Google Cloud Platform** |
|------------------------------|---------|---------------------|---------------------------|
| Compute                      | EC2(VMs), Lambda(serverless), ECS/EKS(containers) | Virtual Machines, Azure Functions, AKS | Compute Engine, Cloud Run, GKE |
| Storage                      | S3, EBS, FSx | Blob Storage, Managed Disks, Data Lake Storage | Cloud Storage, Persistent Disk |
| Networking                   | VPC, Transit Gateway, CloudFront | VNets, ExpressRoute |  Global VPC |
| Identity and Access Management| IAM — policy-based, attached directly to principals (users/roles); very flexible with support for identity federation and multi-account management via Organizations, though it has a steeper learning curve. | Entra ID (formerly Azure AD) — RBAC with a scope hierarchy; the clear enterprise identity leader, with single sign-on across Office 365, Dynamics 365, and GitHub, plus Conditional Access policies.| Cloud IAM — uses a resource hierarchy with allow/deny policies, and supports Workload Identity Federation for keyless authentication from external identity providers.|

[^1]: Reference;
[(https://techsy.io/en/blog/aws-vs-azure-vs-google-cloud)]





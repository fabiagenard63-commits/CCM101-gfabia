# CloudNova Technologies has received requests from four clients. Analyze each scenario and recommend the most appropriate cloud platform.
**For each scenario:**
- Identify the recommended cloud platform.
- Explain your recommendation in 3–5 sentences.
- Mention at least three services that the client could use. 

## Client A Start-up Company
A startup company wants to launch a new mobile application. Their budget is limited, but they expect rapid
growth within the next few years. 

* **RECOMMENDED PLATFORM:**
  Amazon Web Services ( AWS ).
* **Why?**
AWS have a broad cloud services that can accommodate this kind of platform like the Mobile Application, AWS have a variety of option were to deploy the mobile application, also since the company expecting a rapid growth in the next few years AWS is very suitable for the company as one of the strength of the AWS is it's scalability service it supports rapid growth company, and in terms of budget AWS support a pricing where what you only need is what you only pay so expect a lower pricing since the company is in start-up stage.
* **Three Services That Can possibly use**
  1. **Amazon EC2 (Elastic Compute Cloud):** Provides resizable virtual servers in the cloud.
  2. **Amazon S3 (Simple Storage Service):** Object storage built to store and retrieve any amount of data.
  3. **Amazon Route 53:** Scalable Domain Name System (DNS) web service.

## Client B University
A university already uses:
- Windows Server
- Microsoft 365
- Active Directory

The university wants to migrate some services to the cloud. 

* **RECOMMENDED PLATFORM:**
Microsoft Azure
* **Why?**
Since Azure is built by Microsoft it actually a solid platform to migrate the mentioned services into the cloud, because most of it is compatible for integration and have a low issues when migrating since they are all services/product of Microsoft so expect a seamless integration, and also one of the advantage is that using a some specific services you just need to sync your active directory to migrate all of your data into the cloud.
* **Three possibly services that can be use**
  1. **Microsoft Entra ID (Azure AD)** – to extend/sync your on-prem Active Directory to the cloud for identity and access management.
  2. **Azure Virtual Machines** – to lift-and-shift your existing Windows Server workloads to the cloud.
  3. **Azure Migrate** – Microsoft's dedicated tool for assessing and migrating on-prem servers/workloads into Azure with minimal friction.

## Client C AI Research Company

A research company develops Artificial Intelligence and Machine Learning applications that require highperformance computing. 

* **RECOMMENDED PLATORM:**
Google Cloud Platform (GCP)
* **Why?**
GCP have the deepest technical roots when it comes to AI, because it is the birthplace of tensor flow which is the most used framework for Machine Learning Technology it is mainly design to accelerate Machine learning, TPUs ( Tensor Processing Unit ) is a hardware specifically designed to accelerate AI training and interference faster, so for client whose core need is building a AI and Machine Learning Applications GCP is well suited platform for it.
* **Three possibly services that can be use:**
  1. **Vertex AI** – Google's unified ML platform for building, training, and deploying models end-to-end.
  2. **TensorFlow / TPUs (via Compute Engine)** – custom hardware acceleration for training large models faster and cheaper than standard GPUs.
  3. **BigQuery ML** – lets you build and run ML models directly on large datasets using SQL, which is great for data-heavy AI use cases without needing a separate ML pipeline.

## Client D Global Ecommerce Company
A multinational online shopping company serves customers around the world and requires highly available infrastructure with automatic scaling. 

* **RECOMMENDED PLATFORM:**
Amazon Web Services

* **Why?**
AWS is the ideal choice for a multinational e-commerce company because it has the largest global infrastructure footprint of any cloud provider — more regions and availability zones than Azure or GCP — which means the company can host its infrastructure close to customers worldwide for lower latency. AWS also pioneered auto-scaling and elastic infrastructure, since Amazon itself built AWS to handle the extreme traffic spikes of its own retail business (e.g., Black Friday, Prime Day), so the platform is essentially battle-tested for this exact use case. Its high-availability architecture — with data replicated across multiple availability zones and regions — ensures the site stays online even if one data center fails, which is critical for a global shopping platform where downtime = lost revenue. Additionally, AWS has a mature ecosystem of e-commerce-specific tools built from Amazon's own retail experience.

* **Three possibly services that can be use:**
  1. **Amazon EC2 with Auto Scaling** – automatically adjusts compute capacity up or down based on real-time traffic, handling flash sales or seasonal spikes without manual intervention.
  2. **Amazon CloudFront (CDN)** – delivers content (product images, pages) from edge locations close to customers globally, reducing load times and improving the shopping experience.
  3. **Amazon Route 53** – a highly available DNS and traffic-routing service that can direct users to the nearest/healthiest server, supporting global load balancing and failover.




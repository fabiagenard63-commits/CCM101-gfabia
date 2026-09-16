## Virtual Machines Vs Containers

### * **Comparison Table**

| Categories | Virtual Machines | Containers |
|------------|------------------|------------|
| Architecture| Guest OS each machine have dedicated operating system, require more cpu,storage,memory, and lower start-up take longer to boot up | Shared OS kernel  Smaller in size and require fewer resources compared to VMs, Faster start-up can be start and stop quickly due to shared OS kernel |
| Boot Time | It takes Minutes to boot | It takes only seconds to boot |
| Resource Efficiency | High/Heavy Ram Consumption | Lightweight/low Ram Consumption | 
| Isolation Level | Hardware Level | Process Level |

* **Recommendation summary to the client**
As we can see on the table above there is so many factor to consider transferring to containers, first is the faster start up boot because containers doesn't need high ram consumption unlike to Virtual Machines that needs high/heavy used of Ram, next is containers need only low resources like Ram, Cpu, Storage because it uses a shared OS Kernel which Run on a single process so that it have a more faster Boot up that takes seconds, compared to Virtual Machines that it takes minutes to boot.


* **References:** https://cloud.google.com/discover/containers-vs-vms#containers-versus-vms-virtual-machines

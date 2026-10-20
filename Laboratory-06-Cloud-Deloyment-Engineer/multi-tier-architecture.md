# Two Tier Architecture
Two-tier architecture is the simplest form of client-server application design: a client tier talks directly to a server tier, usually a database server, without an application server in the middle. 
If you are looking for a two tier architecture example that explains why this model still shows up in offices, finance departments, and internal tools, the answer is simple: it is direct, fast to build, and easy to understand when the business problem is narrow.
Two-tier architecture is a client-server model with two layers: a client that handles the user interface and a server that stores and returns data. As of October 2026, it is still common for small database-driven apps because it is simple to develop, easy to debug, and cheaper to deploy than three-tier designs.

**Definition:**
  Two-tier architecture is a software architecture in which the client tier and the server tier communicate directly, usually with the client presenting the interface and the server handling data storage and retrieval.
  It is a two tier client server architecture that removes the middle application layer found in three-tier systems.
  
## The Web/Application Tier Roles
It provides the users side interface and it is the one who send an http request into the server.

## The Database Tier Role
It is the one who usually stored data, and the one who provides or sends back information data asks by the client side.

## Why Separate Them?
Security is one of the main reasons why we need to separate them as the database side is not exposed to the user/client side, also scalability wise, they can be scale separately like scale the client side don't
necessarily change the Database Server side, Also reliability/failure proof, mean if the one side fail the other side doesn't affected, and each have their own backup and recovery strategy.  


### References:
 - https://www.ituonline.com/tech-definitions/what-is-two-tier-architecture/

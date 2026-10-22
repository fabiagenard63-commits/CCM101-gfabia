### Mission Overview
Congratulations! Your flawless work in deploying data storage solutions has earned you a spot on the
Cloud Deployment Team at CloudNova Technologies.
Up until now, you have been deploying single containers (like a standalone web server or a storage
bucket). However, real-world enterprise applications are rarely just one container. They are "multi-tier" systems
that require a frontend web application communicating seamlessly with a backend database. Deploying these
one by one manually is prone to error.
Enter Docker Compose. In this mission, you will transition from manual commands to Infrastructure
as Code (IaC). Using a YAML configuration file, you will define a multi-container private cloud storage application
(Nextcloud and MariaDB) and deploy the entire stack simultaneously with a single command!
Remember: A junior engineer deploys servers by typing commands; a senior engineer deploys
infrastructure by writing code.

### Mission Objectives
At the end of this laboratory activity, you should be able to:
- Explain the concept of a multi-tier application architecture.
- Understand the purpose and structure of a docker-compose.yml file.
- Use a Linux command-line text editor (nano) to create configuration files.
- Deploy a multi-container application (Nextcloud + Database) using Docker Compose.
- Document deployment procedures and Infrastructure as Code (IaC) principles using Markdown.
- Continue expanding your professional GitHub Cloud Computing Portfolio. 

### Commands Used/Executed
1. `mkdir nextcloud-deployment`
2. `cd nextcloud-deployment`
3. `nano docker-compose.yml`
4. `docker-compose up -d`
5. `docker-compose ps`
6. `docker-compose down`
7. **modified yml executed based on module provided**
```yaml
services:
  database:
    image: mariadb:10.6
    restart: unless-stopped
    command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW
    volumes:
      - db_data:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=cloudnova_root
      - MYSQL_PASSWORD=cloudnova_pass
      - MYSQL_DATABASE=nextcloud_db
      - MYSQL_USER=nextcloud_user

  app:
    image: nextcloud
    restart: unless-stopped
    depends_on:
      - database
    ports:
      - 8080:80
    volumes:
      - nextcloud_data:/var/www/html
    environment:
      - MYSQL_PASSWORD=cloudnova_pass
      - MYSQL_DATABASE=nextcloud_db
      - MYSQL_USER=nextcloud_user
      - MYSQL_HOST=database

volumes:
  db_data:
  nextcloud_data:
 ```
### Skills Learned Throughout this Activity
Learned how to run a multiple docker containers using Linux command into the Linux Environment, Identify ports access it and file management for every containers also how to properly backup those containers and its content because build it is not only what we want to build also security and safe data is also very important.

### 1. **Mission Overview**

Congratulations! After successfully guiding our clients through multi-cloud evaluations, you have been 
promoted to the Cloud-Native Engineering Team at CloudNova Technologies. 
Modern cloud computing is no longer just about renting Virtual Machines (VMs) from AWS or Azure. Today's 
enterprise applications are built using lightweight, portable, and lightning-fast technologies called Containers. 
Your new mission is to understand the shift from traditional virtualization to containerization. 
Using the KillerCoda Playground, you will step into the shoes of a Cloud-Native Engineer. You will research the 
differences between VMs and containers, execute your very first Docker commands, and deploy a live, 
containerized web server in seconds.

### 2. **Objectives**

* Differentiate between traditional Virtual Machines (VMs) and Containers. 
* Access a Docker-enabled cloud environment using KillerCoda. 
* Execute fundamental Docker CLI (Command Line Interface) commands. 
* Pull, run, manage, and terminate a containerized application (Nginx). 
* Create professional technical documentation of container operations using Markdown. 
* Continue developing a well-organized GitHub Cloud Computing Portfolio.

## Docker Commands Executed

### 1. Checkpoint 3 commands used

- Check if Docker is installed and its version: `docker --version`
- Check Docker service status (systemd): `sudo systemctl status docker`
- Check if Docker daemon is running: `sudo systemctl is-active docker`
- Check Docker info (detailed system-wide info: containers, images, storage driver, etc.): `docker info`
- List running containers: `docker ps`
- List all containers (including stopped ones): `docker ps -a`

### 2. Checkpoint 4 commands used

- to download the latest official Nginx image from Docker Hub: `docker pull nginx`
- Run the container in detached mode and map port 8080 on your host 80 inside container: `docker run -d --name my-nginx -p 8080:80 nginx`
- Confirm the container is running, list running containers: `docker ps`
- Verify that the web server is actually running by sending an HTTP request locally: `curl http://localhost:8080`

### 3. Checkpoint 5 commands used

- Confirm the container is running, list running containers: `docker ps`
- this sends a SIGTERM (then SIGKILL if needed) to gracefully shut down the container's main process without deleting the container itself: `docker stop my-nginx`
- this permanently deletes the stopped container and its writable layer: `docker rm my-nginx`

## Skills Learned

Some of the skills i learned is that mainly how to run docker even though it is done inside a Virtual Environment it very helpful because here you can practice all you want by this you can enhance your skills like your command skills study every command, so for me the most important skills that i acquired doing this activity is that on how to use the command of docker in every specific task that you will do.

## Challenges that I Encountered

Some of the Challenges that i face is on how to conduct the commands because there is so many ways how you can conduct those commands, and also if you ever used a killer coda playground for your testing or want to try their Environments for different purposes make sure you have a strong and stable internet because that is one of challenge that i encountered especially when I'm downloading the docker then it reconnects the whole process will be ruined and it will restart the environment again, that was only the challenges that i encountered so far.











## My Mission Reflection

When I'm to compare the two which is the Set-up process for Virtual Machine, and Docker I would say docker is very fast to setup compare to VM it takes actually seconds to setup, just do some commands on the terminal then your docker is ready and running while on the other hand the setup for Virtual Machine is very Inefficient you need to download a bunch of packages, ISO for operating guest system manually setup it one by one 
configure it and so on and don't forget that it takes so much RAM, and Memory to run smoothly, so to sum it up docker is more easier to setup and it is more faster than VM.
Host mapping is very important when running a web server inside the container, because container has it own private IP address and sets of ports, it isolated network nobody can communicate inside it so to communicate into the host
which is your Killercoda/Terminal we need to map it out into `-p 8080:80` so that it creates a like tunnel into the container 8080 is the port for host(browser/terminal), and 80 post of the container.
When running docker rm command you are deleting all the writable layer and metadata it was also going to disconnect to the network attached to but it will only delete a stopped container unless it was force using `-f` command, but of course
the image will remain untouched.
Containerization have actually huge impact to DevOps Especially because every Computer/Laptops have a different Environments, Back then Dev's and Ops have encountered problem where the software or code works on the computer of the developer 
but not on operational because it have a different environment it might be version or other problems, that's why containerization solves this problem completely it stores the application and its entirety like its dependencies, etc.. 
into one portable unit which is the image where it runs almost everywhere.
My portfolio actually evolving very fast its structure is growing fast and the files have a very structured layer. 

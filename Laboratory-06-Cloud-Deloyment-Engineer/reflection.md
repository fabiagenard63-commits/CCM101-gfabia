Writing a docker-compose.yml makes a cloud engineer jobs more easier because not only it reduce the manually writing a code commands it also eliminates the repetitive commands in docker-compose.yml you just need to open it using nano command
inside make a container and exit then make it up and thats it you have your docker containers unlike manually create your container using manual commands. And also YAML file is very indentation sensitive you can encounter an error if 
your indentation is wrong like it will throw an error saying that it is a mapping and will not recognize as a string, so make sure your indentation is on point. We used environment variables like MYSQL_PASSWORD because the MariaDB and Nextcloud images are generic and need a way to receive their settings when they start. 
The database container uses these variables to automatically create the root password, the database, and the user, so there is no need to set anything up by hand. 
The Nextcloud container uses the same values, plus MYSQL_HOST=database, to know how to log in to the database. 
This keeps the configuration in one file instead of inside the image, which makes the setup easy to change and repeat. 
For real projects, the passwords should be stored in a separate .env file instead of the YAML. 
Deploying Nextcloud in just a few minutes felt amazing and a little surprising. Something that normally takes hours of installing and configuring a web server and database was done with one file and one command. 
It showed me how powerful Docker Compose is for building repeatable infrastructure, and it made me want to learn more.
Since mission 1 doing those laboratory my understanding on cloud computing is become more broad, although i know this is the only tip of the iceberg of cloud computing at least i have some of the understanding how cloud computing work
and it helps so many people and why it very important nowadays especially for big companies/Industry.

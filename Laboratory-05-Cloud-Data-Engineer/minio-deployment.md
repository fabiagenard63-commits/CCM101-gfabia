## DOCKER COMMAND USED TO RUN minIO
`docker run -d -p 9000:9000 -p 9001:9001 --name minio-server 
-e "MINIO_ROOT_USER=cloudadmin" 
-e "MINIO_ROOT_PASSWORD=CloudNova2026!" 
scnd/minio-mirror:RELEASE.2025-09-07T16-13-09Z server /data --console-address ":9001"
`
* in this command there is some changes on what is on module instead of using **minio/minio** I use **scnd/minio-mirror:RELEASE.2025-09-07T16-13-09Z** a third-party copy of the last official MinIO release. Because minio/minio which is image name. MinIO removed  that image from docker hub in September 2026 that is why i encountered a pull access denied.

### Port Number to access the web console
**Port:** 9001

### Bucket Name Created 
- client-photos

### What is the -e flags for?
- we used the -e flags to set a variable inside of our container to give a value for our username and password.

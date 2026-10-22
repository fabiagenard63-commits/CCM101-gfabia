## 404 error logs Report
2026/10/22 10:01:41 [error] 29#29: *5 open() "/usr/share/nginx/html/hidden-admin-page" failed (2: No such file or directory), client: 172.17.0.1, server: localhost, request: "GET /hidden-admin-page HTTP/1.1", host: "localhost:8080"
172.17.0.1 - - [22/Oct/2026:10:01:41 +0000] "GET /hidden-admin-page HTTP/1.1" 404 153 "-" "curl/8.5.0" "-"

### The importance of Application log
Why is it important that application have logs number one is that it helps finds problem in a more accurate and efficient way because logs tells us the exact problem and error of our application also it also acts as our monitoring 
system because it saves the logs of every requests we do, but in overall application logs is essential for every application to help us solve certain errors.

## Memory Consumed by **clientwebsite** container
* **Memory Usage:** 2.73MiB
* **CPU Percentage:** 0.00%

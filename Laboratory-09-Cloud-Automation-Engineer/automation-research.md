## Overview 

* * **Bash Script** is like a text file that contain terminal commands, it runs orderly so you can basically automate a task instead of manually typing each command, `#!/bin/bash` line ( the shebang ) tells the system which program run the file
* without it, the system may run in a different shell and possibly behave differently.

* **Variables Why do programmers use variables (like $BACKUP_DIR) instead of typing out the exact folder path every time?** variables store value once and can reuse it as (eg. $BACKUP_DIR) this helps because it prevents long typos path
* the script is more easy to read and reuse into other servers and when a folder path changes you edit only one line instead of so many.

* * **Cron Job: What is a cron job in Linux, and why is it essential for cloud operations?** cron job is a task linux runs automatically by schedule like running a logs script into specific time like it runs every 11pm, it is very essential in every cloud infrastructure because
  * it gives us an automated diagnostics that significantly saves time and reduce a possibility of human error. 

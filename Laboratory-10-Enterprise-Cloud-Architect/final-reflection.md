# Final Reflection – Mission 10: The Enterprise Cloud Architect

## My Journey: Mission 1 to Mission 10

Ten missions ago I could barely move around a Linux terminal. Mission 1 gave me the basics and my first GitHub portfolio. In Mission 2 I drew a cloud infrastructure in draw.io and learned that a design comes before a deployment. Mission 3 had me explore AWS, Azure, and Google Cloud, and Mission 4 showed me how containers differ from virtual machines when I ran my first Docker container.

After that, every mission stacked another skill on top. Mission 5 introduced object storage through MinIO. Mission 6 introduced multi-container deployment with Docker Compose. Mission 7 taught me to read a server's health with `free -h`, `df -h`, and `docker stats`. Mission 8 put a UFW firewall around the server, and Mission 9 automated backups with a Bash script and cron.

## The Final Mission

Mission 10 gave me no steps, only a result to reach. I installed Ubuntu Server in a VirtualBox virtual machine, forwarded ports 8080 and 2222 so I could reach it from my laptop, installed Docker and Docker Compose, and wrote a `docker-compose.yml` for WordPress and MariaDB with persistent volumes. I then enabled UFW with a default deny policy, wrote a backup script, and scheduled it with cron for 2:00 AM.

The part that taught me the most was proving it all worked. I rebooted the VM and watched both containers come back by themselves with my page still there. I made cron run every minute to see it fire, then set it back to 2 AM. Finally I deleted the database on purpose and restored it from a backup. A backup I had never restored was only something I hoped would work. The restore drill turned it into something I know works.

## Problems I Ran Into

- **Wrong terminal.** Several times I ran VM commands in a Windows PowerShell prompt, or Windows commands inside the VM, and got "command not found". The fix was checking the prompt first: `russel@cloudnova-server` means the VM, and `PS C:\` means Windows.
- **Hidden settings.** VirtualBox hid the Port Forwarding button until I switched the Settings window to Expert mode.
- **A typo in a command.** I typed the number 1 instead of the letter l in `hostnamectl`. Reading the error message carefully showed me the problem.
- **Git on Windows.** Git wasn't installed on my laptop, so I installed it and cloned my portfolio repository to push the final files.

## Lessons I'm Taking Away

- **Infrastructure written as code can be rebuilt.** One Compose file can recreate the whole stack on a fresh server, which is what a client's IT team needs from a handover.
- **Default deny is a better starting point.** Opening only the ports the application and SSH need is easier to defend than closing holes one at a time. I also learned that Docker bypasses UFW for published ports, so the database must never publish one.
- **Persistent volumes raise the stakes.** Once data outlives the container, a backup that actually runs, and a restore I have practiced, becomes essential.
- **Automation removes the human factor.** A cron job does not forget, take a day off, or skip a step.
- **Documentation is part of the work.** Writing the operational manual forced me to check that I understood each step well enough to explain it.

## What I Would Improve

Given more time, I would copy backups to a different machine or cloud storage, because a backup on the same VM disappears if the VM fails. I would also add HTTPS in front of the site, move the passwords into a proper secrets manager, and set up monitoring with alerts so I'd know about a failed backup before anyone else.

## Final Thoughts

When this course started, the cloud felt like something other people ran somewhere far away. Now I see it as a set of practices I can carry out myself: design it, deploy it as code, secure it, automate it, test the recovery, and document it. The biggest change is confidence. I no longer wait for the next command to be handed to me. I can work out what the system needs and look up the rest.

**Reference:**
University of Eastern Pangasinan – College of Information Technology. (2026). *CCM101 – Cloud Computing, Laboratory Activity 10: Mission 10 – The Enterprise Cloud Architect.*

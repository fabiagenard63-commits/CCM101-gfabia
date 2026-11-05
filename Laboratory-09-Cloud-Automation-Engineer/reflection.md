### REFLECTION

Automation matters when you manage hundreds of cloud servers because doing every task by hand takes too long and people make mistakes. 
A script can do the same job on every server in minutes, in exactly the same way. It can also run on a schedule, like a nightly backup, even when nobody is working. 
But automation also has a risk. If a script has a bad typo, it repeats that mistake everywhere. 
For example, a command that deletes files could erase all 1,000 servers at once, including the backups. 
To stay safe, teams test on one server first, roll changes out slowly, and keep backups somewhere else. The tools we use also matter. 
A Bash script lists the steps to do, one after another. You must check for errors yourself, which is why our backup script said “success” even when it failed. 
A Docker Compose file works differently. Instead of listing steps, it describes what you want, such as which containers should run, and Docker sets it up for you. 
This makes Compose more predictable and easier to repeat. Both are useful together: cron runs the Bash scripts for jobs like backups, and Compose keeps the applications running the same way every time.
When reviewing my entire github repo from Laboratory 1 to 9 i would say my cloud computing journey have come so far even though i have so many to learn still it a very good experience for me to do this tasks and so on, and I
enjoy more about Security Engineer which is Laboratory 8 I think because your setting up your security its blocking all the malicious traffic that is trying to intercept your cloud infrastructure.

# Reflection: Mission 1 to Mission 10

> **Before you submit:** this is a draft skeleton. I don't know the specific content of
> your ten missions, so the prompts in [brackets] are for you to fill in from your own
> experience. Replace them with your real stories. Your instructor is grading your
> journey, not mine.

## 1. Where I started

[Describe your skill level at Mission 1: Linux basics, terminal comfort, networking,
Git. What felt unfamiliar?]

## 2. The arc of the missions

| Phase | Missions | What I learned | How it shows up in this project |
|---|---|---|---|
| Foundations | [e.g. 1-3] | [Linux CLI, users, permissions, package management] | Ubuntu Server install, SSH administration, `chmod +x` on scripts |
| Networking | [e.g. 4-5] | [IP addressing, NAT vs host-only, ports] | Dual-adapter VirtualBox design, static host-only IP |
| Containers / IaC | [e.g. 6-7] | [Docker, volumes, Compose] | `docker-compose.yml`, persistent volumes, internal backend network |
| Security | [e.g. 8] | [Least privilege, firewalls, secrets] | UFW default deny, SSH limited to admin subnet, `.env` kept out of Git |
| Automation / Docs | [e.g. 9-10] | [Bash, cron, runbooks] | `backup_db.sh`, cron at 02:00, this operational manual |

(Adjust the mission numbers to match your course.)

## 3. How the pieces fit together

Infrastructure is layered, and each layer depends on the one beneath it:
the hypervisor provides the machine, the OS provides the services, Docker provides
repeatable application packaging, the firewall controls exposure, and automation plus
documentation keep it alive after the builder leaves. Skipping any layer leaves a
gap: a fast deployment with no backups is a liability; a locked-down server nobody
can operate is unusable.

## 4. Challenges and how I solved them

- **[Challenge, e.g. networking]**: [what broke, how I diagnosed it, what fixed it]
- **[Challenge, e.g. Docker and UFW interaction]**: Docker's published ports can bypass
  UFW. I reduced the risk by publishing only port 80 and keeping the database on an
  internal network with no published ports. [Add what you observed when scanning.]
- **[Challenge, e.g. resource limits]**: With 8 GB of host RAM I sized the VM at 2.5 GB
  and set container memory limits so the whole stack stays stable.

## 5. Design decisions I would defend

- **Single VM, two containers**: right-sized for the hardware and the assignment.
- **Host-only + NAT networking**: the server is reachable only from the admin laptop.
- **Named volumes**: data survives container recreation and VM reboot (I verified this by [describe your reboot test]).
- **Automated, verified backups**: the dump is integrity-checked, retention is bounded, and credentials never appear in cron.

## 6. What I would do next in a real production environment

- HTTPS with a reverse proxy (Traefik or Nginx) and Let's Encrypt certificates
- Off-host backup copies and scheduled restore tests
- Centralized monitoring and alerting (Prometheus + Grafana or similar)
- Fail2ban, key-only SSH, and unattended security updates
- Move secrets to a proper secrets manager
- CI pipeline in GitHub Actions to lint the Compose file and scripts (shellcheck)
- High availability: multiple nodes, a managed database, infrastructure defined in Terraform/Ansible

## 7. Closing thoughts

[In your own words: what does "production ready" mean to you now compared with Mission 1?
What skill are you proudest of? What will you carry into your next project?]

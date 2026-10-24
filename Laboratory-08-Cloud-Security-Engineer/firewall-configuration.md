## Technical Documentation
- command used to allow ssh (port 22) `sudo ufw allow ssh`
- commands used to set the to set the default deny policy `sudo ufw defauly deny incoming` `sudo ufw default allow outgoing`
- commands used allowing the port 8080 `sudo ufw allow 8080/tcp`
- If you ran sudo ufw enable  before sudo ufw allow ssh you will locked out yourself in your own server so make sure that it is allowed before enable.

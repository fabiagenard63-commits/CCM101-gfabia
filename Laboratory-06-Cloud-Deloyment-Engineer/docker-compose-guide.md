## Modified/Corrected Version Based on Modules
`services:
  database:
    image: mariadb:10.6
    restart: unless-stopped
    command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW
    volumes:
      - db_data:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=cloudnova_root
      - MYSQL_PASSWORD=cloudnova_pass
      - MYSQL_DATABASE=nextcloud_db
      - MYSQL_USER=nextcloud_user

  app:
    image: nextcloud
    restart: unless-stopped
    depends_on:
      - database
    ports:
      - 8080:80
    volumes:
      - nextcloud_data:/var/www/html
    environment:
      - MYSQL_PASSWORD=cloudnova_pass
      - MYSQL_DATABASE=nextcloud_db
      - MYSQL_USER=nextcloud_user
      - MYSQL_HOST=database

volumes:
  db_data:
  nextcloud_data:`



### 1. What does the `services:` block do?

It declares **every container that makes up the application**. Each key directly under `services:` is a service name, and the settings nested below it describe how to run that container.

This file defines two services:

- **`database`**: MariaDB 10.6. Its environment variables create the root password, the `nextcloud_db` database, and the `nextcloud_user` account.
- **`app`**: Nextcloud. It publishes port 8080 and starts after the database because of `depends_on`.

Without `services:`, Compose would have nothing to run.

### 2. How does the app container find the database?

Through the **`MYSQL_HOST=database`** environment variable, combined with Compose's built-in networking:

1. `docker-compose up` creates a private network for the project and attaches every service to it.
2. Docker runs an internal DNS server on that network, so each container is reachable by its **service name**.
3. The database service is named `database`, so the hostname `database` resolves to that container's IP.
4. Nextcloud reads `MYSQL_HOST=database` and connects to `database:3306`.

**`MYSQL_HOST` must match the service name exactly.** If you renamed the service to `db`, you would change it to `MYSQL_HOST=db`. No IP address is hard-coded, so this keeps working even when container IPs change.

The credentials (`MYSQL_USER`, `MYSQL_PASSWORD`, `MYSQL_DATABASE`) must also be identical on both services.

### 3. `docker run` vs `docker-compose up -d`

| | `docker run` | `docker-compose up -d` |
|---|---|---|
| Scope | One container per command | The whole multi-container stack |
| Configuration | Long list of command-line flags | Declarative YAML file, kept in version control |
| Networking | Create a network and attach each container manually | Automatic shared network with DNS by service name |
| Volumes | Created and mounted with `-v` each time | Declared once in the file |
| Start order | You start containers in the right order yourself | Handled by `depends_on` |
| Reproducibility | Depends on retyping the exact command | Same file gives the same result every time |
| Teardown | Stop and remove each container individually | `docker-compose down` removes everything together |

The `-d` flag means **detached**: containers run in the background and your terminal is returned to you. Without it, logs stream to the terminal and closing it stops the stack.

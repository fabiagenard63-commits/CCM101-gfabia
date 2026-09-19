## Command Used For Container Lifecycle

### 1. List running containers
**Command:** `docker ps`

**What it did:** Displayed all currently running containers, showing that `my-nginx` was active with status "Up" and port `8080->80` mapped.

### 2. Stop the running container
**Command:** `docker stop my-nginx`

**What it did:** Gracefully stopped the `my-nginx` container by sending a termination signal, halting the Nginx process without deleting the container.

### 3. Verify it is stopped
**Command:** `docker ps -a`

**What it did:** Listed all containers (running and stopped), confirming `my-nginx` now shows status "Exited" instead of "Up".

### 4. Remove the container completely
**Command:** `docker rm my-nginx`

**What it did:** Permanently deleted the stopped `my-nginx` container and its writable layer, freeing it from the container list entirely.

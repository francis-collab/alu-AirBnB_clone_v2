# AirBnB Clone – Deploy Static

## Introduction

Welcome to **AirBnB Clone - Deploy Static**, a deployment project that demonstrates how to prepare, package, and deploy static content to web servers using **Bash**, **Fabric 3**, and **Nginx**.

This deployment operates safely under a load-balanced setup involving two web servers and an HAProxy load balancer. All static content is served via the `/hbnb_static/` path to avoid interfering with the main website running at `https://mutabazi.tech`.

---

## Features

- 🖥️ Prepares remote servers for deployment with correct folder structure and Nginx config
- 📦 Compresses static files in `web_static/` into `.tgz` archives
- 🚀 Deploys archives to both servers using Fabric 3
- 🔁 Uses symbolic links for atomic deployments
- ⚙️ Serves deployed content at `/hbnb_static/` using Nginx `alias` (not `root`)
- 🔐 Avoids overwriting or interfering with existing production apps

---

## Project Structure

```
alu-AirBnB_clone_v2/
├── web_static/                  # Static HTML/CSS content to deploy
├── versions/                    # Archive folder created by do_pack
├── 0-setup_web_static.sh        # Prepares servers for deployment
├── 1-pack_web_static.py         # Creates .tgz archive using Fabric
├── 2-do_deploy_web_static.py    # Uploads + deploys archive to web servers
├── 3-deploy_web_static.py       # Combines packaging and deployment
└── README.md                    # Project documentation
```

---

## Setup & Usage

### 1. Prepare Web Servers

On each server (`web-01`, `web-02`):

```bash
scp 0-setup_web_static.sh ubuntu@<server_ip>:~/
ssh ubuntu@<server_ip>
chmod +x 0-setup_web_static.sh
./0-setup_web_static.sh
```

Test with:

```bash
curl http://localhost/hbnb_static/
```

Expected output:

```html
<html>
  <head></head>
  <body>Holberton School</body>
</html>
```

---

### 2. Package Static Content

```bash
fab -f 1-pack_web_static.py do_pack
```

Creates:

```
versions/web_static_<YYYYMMDDHHMMSS>.tgz
```

---

### 3. Deploy Archive to Servers

```bash
fab -f 2-do_deploy_web_static.py do_deploy:archive_path=versions/web_static_<timestamp>.tgz
```

---

### 4. Full Deploy (Pack + Deploy)

```bash
fab -f 3-deploy_web_static.py deploy
```

---

## Technologies

- Python 3.4.3
- Fabric 3 (1.14.post1)
- Bash scripting
- Nginx on Ubuntu 14.04
- HAProxy load balancer

---

## Safe Deployment Strategy

- All content is served at `/hbnb_static/` using `alias` to avoid touching `/`
- Symbolic links (`/data/web_static/current`) allow quick rollbacks or version switching
- Original app at `https://mutabazi.tech` stays intact

---

## API & Tools Setup

Install Fabric 3:

```bash
sudo apt-get install libffi-dev libssl-dev build-essential python3.4-dev libpython3-dev
pip3 install pyparsing appdirs setuptools==40.1.0 cryptography==2.8 bcrypt==3.1.7 PyNaCl==1.3.0 Fabric3==1.14.post1
```

---

## Example Output

```bash
curl http://web-01.mutabazi.tech/hbnb_static/
```

Returns:

```html
<html>
  <head></head>
  <body>Holberton School</body>
</html>
```

---

## Author

**Francis Mutabazi**  
GitHub: [francis-collab](https://github.com/francis-collab)

---


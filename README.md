# 🚀 FastAPI Docker CI/CD Project

This is a simple yet powerful example of deploying a **FastAPI** application using **Docker**, **GitHub Actions**, and **AWS EC2**. The project demonstrates a basic CI/CD pipeline setup, where:

- Code pushed to `dev` triggers automated tests, linting, and builds a Docker image.
- A manually triggered production pipeline connects to an **AWS EC2 instance** via SSH and runs the application using the built Docker image from the **GitHub Container Registry**.

---

## 🧭 Project Overview

### ✅ Tech Stack
- **FastAPI** – Python web framework for building APIs.
- **Docker** – Containerization of the application.
- **GitHub Actions** – CI/CD automation.
- **AWS EC2** – Hosting environment for production.
- **GitHub Container Registry (GHCR)** – For storing built Docker images.

### 📌 Branching Strategy
- `dev`: Main development branch, auto triggers dev pipeline.
- `prod`: Stable production-ready branch.
- `code_review`: Intermediate branch for PR reviews and testing (optional).

---

## 🌟 Project Goals

The goal is to demonstrate a **CI/CD pipeline for a containerized FastAPI app**, deployed onto an AWS EC2 instance using GitHub Actions.

- Automate testing and linting during development.
- Build and publish a Docker image to GitHub Container Registry.
- Deploy manually to a production EC2 instance via SSH.

---

## 🛠️ Project Structure

```bash
.
├── fastapiproj.py          # Simple FastAPI app
├── fastapiproj_tests.py    # Simple tests
├── Dockerfile              # Builds and runs FastAPI using Uvicorn
├── .github/
│   └── workflows/
│       ├── dev.yml         # CI pipeline for dev branch
│       └── prod.yml        # Manual deployment pipeline for prod
└── README.md
```

---

## 🐳 Docker Overview

The `Dockerfile`:
- Uses a lightweight Python base image.
- Installs FastAPI and Uvicorn.
- Exposes the app on port 8000.

---

## 🔀 GitHub Actions Pipelines

### 🧪 `dev.yml` – Development Workflow

**Trigger**: Push to `dev` branch  
**Steps**:
1. Run `pytest` tests.
2. Run linter (`flake8`)
3. If successful, build Docker image.
4. Push image to **GitHub Container Registry** (`ghcr.io`).

---

### 🚀 `prod.yml` – Production Workflow

**Trigger**: Manually from GitHub Actions UI  
**Steps**:
1. Connect to EC2 instance via SSH.
2. Execute script inside the yml file.
3. Script pulls the latest image from GHCR and runs it via Docker.

> ⚠️ EC2 instance is **manually created** via AWS Console and is not managed by Terraform or IaC in this project.

---

## 📦 How to Recreate the Project

### 1. 📅 Clone the Repo

```bash
git clone https://github.com/konstantinosloukaidis/my-fast-api-devops.git
cd my-fast-api-devops
```

---

### 2. 🐍 Set Up Locally (Optional)

```bash
python3 -m venv venv
source venv/bin/activate
pip install fastapi uvicorn
uvicorn fastapiproj:app --reload
```

Navigate to: `http://127.0.0.1:8000` and you will get a message: "Hello World"

---

### 3. 🧪 Add Your Tests

Ensure your tests live in a `/` folder and are detected by `pytest`.
Again, this example mainly showscases the CI/CD pipelines, the example is very poor 
and the organization of files could be better

---

### 4. 🔧 GitHub Secrets Setup

In your repo, go to **Settings > Secrets and Variables > Actions** and add:

| Name                | Description                                  |
|---------------------|----------------------------------------------|
| `SSH_PRIVATE_KEY`   | Private key to SSH into EC2 instance         |
| `EC2_HOST`          | Public IP or hostname of your EC2 instance   |
| `EC2_USER`          | Username for EC2 login (e.g., `ec2-user`)    |
| `CR_PAT`            | Key for the container registry connection    |
| `DOCKER_USERNAME`   | The username of the github registry container (all lowercase) |

---

### 5. 🐙 GitHub Actions: Development Workflow

Push to `dev` branch:

```bash
git checkout -b dev
git push origin dev
```

This triggers:
- Testing
- Linting
- Docker image build and push to `ghcr.io`

---

### 6. 🔐 GitHub Container Registry Access (Optional)

Authentication to GHCR is done in this line:

```bash
echo "${{ secrets.CR_PAT }}" | docker login ghcr.io -u ${{ secrets.DOCKER_USERNAME }} --password-stdin

```

---

### 7. 🚀 Deploy to EC2

1. Go to **Actions > prod.yml > Run workflow**
2. Select the branch (usually `prod`)
3. Click **Run Workflow**

This will SSH into your EC2 executing the custom script.

---

### 8. 📡 Access the API on EC2

Assuming EC2 is publicly accessible and port `8000` is open in the security group:

```
http://<EC2_PUBLIC_IP>:8000
```
---

## 🧼 Future Improvements

- Use **Terraform** or **Ansible** for infrastructure provisioning.
- Add **monitoring** and **logging** support.
- Implement **automatic rollback** or health checks in the production pipeline.

---

## 📜 License

MIT License. Feel free to fork and modify for your own use.


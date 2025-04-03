# Inception - 42 School

### 🏆 Score: **125/100** (+25 for bonus)

## 📚 About the Project

**Inception** is an introductory project to system administration and containerization using **Docker**. The goal is to set up a multi-container infrastructure using **Docker Compose**, where different services run in isolated containers while working together seamlessly.

## 🛠️ How It Works

1. **Custom Docker Images**: Each service runs in an isolated container built from scratch using Debian-based Dockerfiles with dynamic configuration via entrypoint scripts.
2. **Service Orchestration**: Docker Compose manages the entire infrastructure, handling networking, environment variables, secrets, and persistent volumes.
3. **Core Infrastructure**: A WordPress website with MariaDB database backend, all served through an Nginx reverse proxy.
4. **Bonus Services**
- **Redis Cache**: Improves WordPress performance by caching frequently accessed data, reducing database load.
- **vsFTP Server**: Provides a secure method for file transfers using the FTP protocol.
- **Portainer**: A web-based interface to manage and monitor Docker containers.
- **Adminer**: A lightweight database administration tool for managing MariaDB.
- **Static Website**: A simple website served through a lightweight BusyBox HTTPD container for static content.



**Note:** The project runs inside a virtual machine. While the examples use `localhost`, in the actual project setup we modify the `/etc/hosts` file to map `login.42.fr` to the local IP address.

## 📚 What I Learned

- **Docker Ecosystem**: Building custom images, optimizing layers, and orchestrating multi-container applications with Docker Compose
- **System Administration**: Configuring services (like Web Servers, Databases and other tools), handling users, permissions networking and data persistence
- **Virtual Machine Management**: Enhancing skills in working with VMs

## 🚀 Usage

### 1️⃣ Clone the Repository

```shellscript
git clone https://github.com/your-username/inception.git
cd inception
```

### 2️⃣ Generate Credentials

```shellscript
./secrets_gen.sh
```

### 3️⃣ Build and Start the Containers

```shellscript
make
```

### 4️⃣ Access the Services

- Open a browser and visit:

```plaintext
https://localhost
```


- Log in to WordPress at:

```plaintext
https://localhost/wp-admin
```


- Access **Portainer** at:

```plaintext
http://localhost:8082
```


- Access **Adminer** at:

```plaintext
http://localhost:8081
```


- Access **Static Website** at:

```plaintext
http://localhost:8080
```




### 🔑 Credentials

The credentials to sign in to all services can be found in the **secrets** folder.

### 5️⃣ Stop and Clean Up All Docker Resources

```shellscript
make clean
```

## 🏁 Conclusion

**Inception** is an introduction to **containerization** and **system administration** using Docker. It helped understanding how to **build and configure custom Docker images**, manage and deploy services efficiently, and ensure security and persistence in a containerized environment.

# Use the latest Ubuntu image as a base
FROM ubuntu:latest

# Update the package list and install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user and grant privileges
RUN useradd -m appuser && usermod -aG sudo appuser

# Switch to the new user
USER appuser

# Expose the port if your application needs it
EXPOSE 80

# Set the working directory
WORKDIR /app

# Optional: Copy files from your local machine to the container
# COPY . /app/

# Run a command when the container starts
CMD ["bash"]
```

### Explanation of the Dockerfile:
1. **`FROM ubuntu:latest`**: Uses the latest Ubuntu image as the base.
2. **`RUN apt-get update && ...`**: Updates the package list and installs necessary packages like `git`, `curl`, and `wget`.
3. **`RUN useradd ...`**: Creates a non-root user (`appuser`) and grants them sudo privileges for better security.
4. **`USER appuser`**: Switches to the newly created user.
5. **`EXPOSE 80`**: Exposes port 80 if your application needs it.
6. **`WORKDIR /app`**: Sets the working directory to `/app`.
7. **`CMD ["bash"]`**: Runs the Bash shell when the container starts.

### How to use this Dockerfile:
1. **Create the Dockerfile**:
   - Open a text editor and save the above content as `Dockerfile` (no extension).

2. **Build the Docker image**:
   ```bash
   docker build -t my-ubuntu-server .
   ```

3. **Run the Docker container**:
   ```bash
   docker run -it -p 80:80 my-ubuntu-server

# Use the latest Ubuntu LTS version
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# Update and install essential packages
RUN apt update && apt upgrade -y && \
    apt install -y --no-install-recommends \
    sudo \
    curl \
    wget \
    git \
    vim \
    nano \
    build-essential \
    python3 \
    python3-pip \
    software-properties-common \
    net-tools \
    iputils-ping \
    unzip \
    zip \
    ca-certificates \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user with a password
ARG USERNAME=mehetab
ARG PASSWORD=123456
RUN useradd -m -s /bin/bash $USERNAME && \
    echo "$USERNAME:$PASSWORD" | chpasswd && \
    usermod -aG sudo $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set the default user
USER $USERNAME
WORKDIR /home/$USERNAME

# Install Docker (optional but useful)
USER root
RUN curl -fsSL https://get.docker.com | sh

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt install -y nodejs

# Expose a port (if needed)
EXPOSE 8080

# Clean up to reduce image size
RUN apt autoremove -y && apt clean -y && rm -rf /var/lib/apt/lists/*

# Default command
CMD ["/bin/bash"]

# Use Node.js dev container base image
FROM mcr.microsoft.com/devcontainers/javascript-node:latest

# Optional: install global npm packages or other CLI tools
RUN npm install -g nodemon serve

# Optional: install Python for scripting or tooling
RUN apt-get update && apt-get install -y python3 python3-pip

# Optional: install system dependencies (e.g., Git tools)
RUN apt-get install -y git curl unzip
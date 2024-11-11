# Use the official Ubuntu base image
FROM ubuntu:latest

# Set environment variables to prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install dependencies
RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    gnupg2 \
    curl \
    ca-certificates \
    lsb-release && \
    # Add Posit R repository key
    curl -fsSL https://download2.rstudio.org/r/ubuntu/gpg | tee /etc/apt/trusted.gpg.d/posit.asc && \
    # Add the Posit R repository for Ubuntu
    curl -fsSL https://download2.rstudio.org/r/ubuntu/$(lsb_release -c | awk '{print $2}')/posit.list | tee /etc/apt/sources.list.d/posit.list && \
    # Install R from the Posit repository
    apt-get update && \
    apt-get install -y r-base && \
    # Clean up unnecessary files
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Default command to run R
CMD ["R"]

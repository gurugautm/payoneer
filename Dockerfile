# Use the official stable Debian base image
FROM debian:bookworm-slim

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies, Python, and Pip
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Set up a working directory
WORKDIR /app

# Create a virtual environment to avoid PEP 668 externally managed errors
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip and install ecdsa safely
RUN pip install --no-cache-dir ecdsa

# Copy your application code
COPY . .

# Command to execute your code
CMD ["python3", "main.py"]

# Claude Code CLI Playground
# Minimal Debian-based image using the official native installer

FROM debian:bookworm-slim

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites for the native installer
RUN apt-get update && apt-get install -y \
    curl \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user with a real home directory BEFORE running the installer
RUN useradd -m -s /bin/bash claude

# Install Claude Code as the claude user
RUN curl -fsSL https://claude.ai/install.sh | su claude -c "bash" \
    && echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/claude/.bashrc \
    && echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/claude/.profile \
    # Manually symlink the binary since the installer's bin-linking step fails in Docker
    && mkdir -p /home/claude/.local/bin \
    && ln -sf /home/claude/.local/share/claude/versions/2.1.111 /home/claude/.local/bin/claude \
    && chown -R claude:claude /home/claude/.local

# Copy and permission the entrypoint WHILE STILL ROOT
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Switch to non-root user AFTER file permissions are set
ENV PATH="/home/claude/.local/bin:${PATH}"
USER claude

# Set working directory for your projects/playground
WORKDIR /workspace

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]

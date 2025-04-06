FROM python:3.11-slim

WORKDIR /docs

# Install dependencies
RUN pip install --no-cache-dir \
    mkdocs-material \
    mkdocs-mermaid2-plugin \
    pygments \
    pymdown-extensions

# Expose MkDocs development server port
EXPOSE 8000

# Set default command
CMD ["mkdocs", "serve", "-a", "0.0.0.0:8000"]

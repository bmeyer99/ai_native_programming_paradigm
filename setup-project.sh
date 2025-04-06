#!/bin/bash

echo "Setting up AI-Native Programming Paradigm project structure..."

# Create root directory
PROJECT_DIR="ai-native-paradigm"
mkdir -p $PROJECT_DIR
cd $PROJECT_DIR

# Create Docker and configuration files
echo "Creating Docker and configuration files..."

# Docker Compose file
cat > docker-compose.yml << 'EOF'
version: '3'

services:
  mkdocs:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "8000:8000"
    volumes:
      - .:/docs
    command: mkdocs serve -a 0.0.0.0:8000
    restart: unless-stopped
EOF

# Dockerfile
cat > Dockerfile << 'EOF'
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
EOF

# MkDocs configuration
cat > mkdocs.yml << 'EOF'
site_name: AI-Native Programming Paradigm
site_description: Documentation for the AI-Native Programming Paradigm project
repo_url: https://github.com/your-org/ai-native-paradigm
edit_uri: edit/main/docs/

theme:
  name: material
  features:
    - navigation.tabs
    - navigation.sections
    - navigation.top
    - search.highlight
    - content.tabs.link
  palette:
    - scheme: default
      primary: indigo
      accent: indigo
      toggle:
        icon: material/weather-night
        name: Switch to dark mode
    - scheme: slate
      primary: indigo
      accent: indigo
      toggle:
        icon: material/weather-sunny
        name: Switch to light mode

markdown_extensions:
  - admonition
  - pymdownx.details
  - pymdownx.superfences
  - pymdownx.tabbed:
      alternate_style: true
  - pymdownx.keys
  - pymdownx.highlight
  - pymdownx.inlinehilite
  - attr_list
  - md_in_html
  - toc:
      permalink: true
      toc_depth: 3

plugins:
  - search
  - mermaid2

nav:
  - Home: index.md
  - Getting Started:
    - Overview: getting-started/overview.md
    - Installation: getting-started/installation.md
    - Contributing: getting-started/contributing.md
  - Roadmap:
    - Overview: roadmap/overview.md
    - Current State: roadmap/current-state.md
    - Target State: roadmap/target-state.md
    - Phase 1: Foundation: roadmap/phase1-foundation.md
    - Phase 2: Core Technology: roadmap/phase2-core.md
    - Phase 3: Development Tooling: roadmap/phase3-tooling.md
    - Phase 4: Integration: roadmap/phase4-integration.md
    - Phase 5: Scaling: roadmap/phase5-scaling.md
    - Phase 6: Ecosystem: roadmap/phase6-ecosystem.md
  # Additional navigation items will be added as documentation grows
EOF

# README file
cat > README.md << 'EOF'
# AI-Native Programming Paradigm Documentation

## Quick Setup

This repository uses Docker to simplify the documentation setup process. To get started:

1. Clone this repository
2. Run the documentation server with Docker Compose

```bash
docker compose up -d
```

3. Access the documentation at http://localhost:8000

That's it! The documentation will be automatically rebuilt whenever you make changes to the markdown files.

## File Structure

```
.
├── docker-compose.yml    # Docker Compose configuration
├── Dockerfile            # Docker container definition
├── mkdocs.yml            # MkDocs configuration
├── docs/                 # Documentation files (Markdown)
│   ├── index.md          # Home page
│   ├── getting-started/  # Getting started guides
│   ├── roadmap/          # Project roadmap
│   ├── technical/        # Technical specifications
│   └── ...               # Additional sections
└── README.md             # This file
```

## Working with the Documentation

### Adding New Pages

1. Create a new markdown file in the appropriate directory under `docs/`
2. Add the page to the navigation menu in `mkdocs.yml`

### Editing Existing Pages

Simply edit the markdown files in the `docs/` directory. The changes will be reflected in the documentation site immediately.

### Stopping the Documentation Server

To stop the documentation server:

```bash
docker compose down
```

## Building for Production

To build a static version of the documentation:

```bash
docker compose run --rm mkdocs mkdocs build
```

The built documentation will be available in the `site/` directory.

## GitHub Pages Deployment

To deploy to GitHub Pages:

```bash
docker compose run --rm mkdocs mkdocs gh-deploy
```

This will build the documentation and push it to the `gh-pages` branch of your repository.

## License

[Specify your license here]
EOF

# .gitignore file
cat > .gitignore << 'EOF'
# MkDocs build directory
site/

# Python cache files
__pycache__/
*.py[cod]
*$py.class

# Distribution / packaging
.Python
env/
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
*.egg-info/
.installed.cfg
*.egg

# Virtual environments
venv/
ENV/
env/

# IDE files
.idea/
.vscode/
*.swp
*.swo

# OS specific files
.DS_Store
Thumbs.db
EOF

# Create docs directory structure
echo "Creating documentation folder structure..."

# Main docs directories
mkdir -p docs/{getting-started,roadmap,technical/{code-representation,ai-engine,human-interface,execution},tooling,challenges,implementation,vision}

# Create index.md
cat > docs/index.md << 'EOF'
# AI-Native Programming Paradigm

Welcome to the documentation for the AI-Native Programming Paradigm project.

## Project Overview

The AI-Native Programming Paradigm project aims to revolutionize software development by enabling AI to directly produce highly optimized machine code while providing on-demand human-readable representations when needed.

## Documentation Structure

This documentation is organized into the following sections:

- **[Getting Started](getting-started/overview.md)**: Introduction to the project and how to contribute
- **[Roadmap](roadmap/overview.md)**: Development plan and milestones
- **[Technical Specifications](technical/code-representation/overview.md)**: Detailed technical documentation
- **[Development Tooling](tooling/version-control.md)**: Tools for the new paradigm
- **[Challenges](challenges/technical.md)**: Analysis of key challenges
- **[Implementation Strategy](implementation/domain-expansion.md)**: Approach to implementation
- **[Long-term Vision](vision/intent-driven.md)**: Future direction of the project

## Quick Links

- [Project Roadmap](roadmap/overview.md)
- [Current State Analysis](roadmap/current-state.md)
- [Getting Involved](getting-started/contributing.md)
EOF

# Create basic files for each section
echo "Creating initial documentation files..."

# Getting Started section
cat > docs/getting-started/overview.md << 'EOF'
# Project Overview

## What is the AI-Native Programming Paradigm?

The AI-Native Programming Paradigm is a revolutionary approach to software development that eliminates the inefficiency of generating human-readable code as an intermediary step. Instead, this paradigm enables AI to directly produce highly optimized machine code while providing on-demand human-readable representations when needed.

## Core Concepts

### Direct Machine Code Generation

Traditional programming requires AI to generate human-readable code that must then be compiled or interpreted at runtime, creating unnecessary performance overhead. In this new paradigm, AI directly generates optimized machine code or efficient intermediate representations.

### On-Demand Human Interface

While the canonical form of the code remains in its optimized state for maximum runtime efficiency, the system provides human-readable views on demand when developers need to understand, modify, or debug the code.

### Intent-Driven Development

Developers communicate their intent through natural language or high-level specifications, focusing on what they want to achieve rather than how to implement it. The AI handles the translation from intent to optimized implementation.

## Benefits

- **Enhanced Performance**: Eliminates compilation/interpretation overhead at runtime
- **Resource Efficiency**: Reduces AI computational resources spent on formatting human-readable code
- **Advanced Optimization**: Enables optimizations not possible when constrained by human-readable syntax
- **Accelerated Development**: Streamlines the path from concept to execution
- **Focused Creativity**: Allows developers to focus on intent and design rather than implementation details

## Getting Started

To learn more about the project and how to contribute, see the [Contributing Guide](contributing.md).
EOF

touch docs/getting-started/installation.md
touch docs/getting-started/contributing.md

# Roadmap section
cat > docs/roadmap/overview.md << 'EOF'
# Project Roadmap

This roadmap outlines the development plan for the AI-Native Programming Paradigm project. It is divided into six major phases, each with specific objectives and milestones.

## Roadmap Overview

1. **Foundation and Research**: Establishing the theoretical framework and proof-of-concept
2. **Core Technology Development**: Building fundamental components
3. **Development Tooling**: Creating necessary tools for practical development
4. **Integration and Interoperability**: Ensuring compatibility with existing systems
5. **Scaling and Optimization**: Preparing for production use
6. **Ecosystem Growth**: Building community and standards

## Current Status

The project is currently in the initial phase. See [Current State Analysis](current-state.md) for details on the current status of the project.

## Detailed Phase Information

- [Phase 1: Foundation and Research](phase1-foundation.md)
- [Phase 2: Core Technology Development](phase2-core.md)
- [Phase 3: Development Tooling](phase3-tooling.md)
- [Phase 4: Integration and Interoperability](phase4-integration.md)
- [Phase 5: Scaling and Optimization](phase5-scaling.md)
- [Phase 6: Ecosystem Growth](phase6-ecosystem.md)
EOF

touch docs/roadmap/current-state.md
touch docs/roadmap/target-state.md
touch docs/roadmap/phase1-foundation.md
touch docs/roadmap/phase2-core.md
touch docs/roadmap/phase3-tooling.md
touch docs/roadmap/phase4-integration.md
touch docs/roadmap/phase5-scaling.md
touch docs/roadmap/phase6-ecosystem.md

# Technical sections
mkdir -p docs/technical/code-representation
touch docs/technical/code-representation/overview.md
touch docs/technical/code-representation/format.md
touch docs/technical/code-representation/metadata.md

mkdir -p docs/technical/ai-engine
touch docs/technical/ai-engine/architecture.md
touch docs/technical/ai-engine/interfaces.md
touch docs/technical/ai-engine/security.md

mkdir -p docs/technical/human-interface
touch docs/technical/human-interface/visualization.md
touch docs/technical/human-interface/editing.md
touch docs/technical/human-interface/explanation.md

mkdir -p docs/technical/execution
touch docs/technical/execution/runtime.md
touch docs/technical/execution/integration.md

# Tooling section
touch docs/tooling/version-control.md
touch docs/tooling/debugging.md
touch docs/tooling/testing.md
touch docs/tooling/documentation.md

# Challenges section
touch docs/challenges/technical.md
touch docs/challenges/human-factors.md
touch docs/challenges/integration.md
touch docs/challenges/solutions.md

# Implementation section
touch docs/implementation/domain-expansion.md
touch docs/implementation/transition.md
touch docs/implementation/feedback.md

# Vision section
touch docs/vision/intent-driven.md
touch docs/vision/collaborative.md
touch docs/vision/optimization.md
touch docs/vision/democratization.md

# Make script executable
chmod +x setup-project.sh

echo "Adding GitHub workflow for automatic deployment..."
mkdir -p .github/workflows
cat > .github/workflows/documentation.yml << 'EOF'
name: documentation

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-python@v2
        with:
          python-version: 3.x
      - run: pip install mkdocs-material mkdocs-mermaid2-plugin pymdown-extensions
      - run: mkdocs gh-deploy --force
EOF

echo "Project structure setup complete!"
echo "To start the documentation server, run:"
echo "cd $PROJECT_DIR && docker compose up -d"
echo "Then visit http://localhost:8000 in your browser."

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

## Contributing

Please see the [Contributing Guide](docs/getting-started/contributing.md) for information on how to contribute to this project.

## License

[Specify your license here]
# Omnisum

A versatile text summarization tool built with TypeScript.

🚀 **This repo uses Dev Containers and Gitpod Automations. Open in Gitpod or VS Code with Dev Containers to get started.**

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/ehudso7/omnisum)

## Features

- Simple and efficient text summarization
- Configurable summary length
- Multiple output formats (plain text, markdown, HTML)
- TypeScript support with full type definitions

## Installation

```bash
npm install
```

## Usage

```typescript
import { summarize } from './src/index';

const text = "Your long text here...";
const summary = summarize(text, { maxLength: 100 });
console.log(summary);
```

## Development

### Quick Start with Gitpod
Click the button above to open this project in a pre-configured cloud development environment.

### Local Development with Dev Containers
1. Install [Docker](https://www.docker.com/get-started) and [VS Code](https://code.visualstudio.com/)
2. Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
3. Clone this repo and open in VS Code
4. When prompted, click "Reopen in Container"

### Manual Setup

```bash
# Install dependencies (we use pnpm)
pnpm install

# Run the API server
pnpm run dev:server

# Run in development mode
pnpm run dev

# Build the project
pnpm run build

# Run tests
pnpm test

# Type checking
pnpm run typecheck

# Linting
pnpm run lint
```

### API Endpoints

- `GET /health` - Health check endpoint
- `POST /api/summarize` - Summarize text
  ```json
  {
    "text": "Your long text here...",
    "maxLength": 100,
    "format": "plain"
  }
  ```

## License

MIT
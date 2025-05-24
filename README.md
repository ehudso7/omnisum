# Omnisum

A versatile text summarization tool built with TypeScript.

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

```bash
# Install dependencies
npm install

# Run in development mode
npm run dev

# Build the project
npm run build

# Run tests
npm test

# Type checking
npm run typecheck

# Linting
npm run lint
```

## License

MIT
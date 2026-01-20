# Motion Control Playground
TODO(Amin) Add more.

## Prerequisites

You need the following tools installed:

1.  **just** (Command runner)
    *   Installation: `snap install --edge --classic just` (Linux) or check [installation guide](https://github.com/casey/just#packages).

2.  **uv** (Python package manager)
    ```bash
    curl -LsSf https://astral.sh/uv/install.sh | sh
    ```

3.  **Node.js & npm** (Javascript runtime for `jco`)
    *   Install via your system package manager or from [nodejs.org](https://nodejs.org/).

## Quick Start

This project uses a `justfile` to automate the build process.

1.  **Setup Environment**
    Installs Python dependencies and reminds you to install `jco`.
    ```bash
    just setup
    npm install -g @bytecodealliance/jco
    ```

2.  **Build & Transpile**
    Compiles Python to WASM and then transpiles it to browser-ready JavaScript.
    ```bash
    just
    ```
    *(This runs `just build` and `just transpile` sequentially)*

3.  **Run Simulation**
    Starts a local web server (needed for WASM loading).
    ```bash
    just serve
    ```
    Open your browser to [http://localhost:8000](http://localhost:8000).

## Manual Build Steps (Reference)

If you prefer running commands manually without `just`:

### 1. Build the Wasm Component

Compile the Python code into a WebAssembly Component (`physics.wasm`).

```bash
cd python
uv run componentize-py -d . -w engine componentize app -o ../webui/physics.wasm --stub-wasi
cd ..
```

### 2. Transpile to JavaScript

Convert the Wasm Component into standard JavaScript ES modules that can run in the browser.

```bash
jco transpile webui/physics.wasm -o webui/dist --no-wasi-shim --overwrite
```

### 3. Serve

```bash
python3 -m http.server -d webui
```

## Project Structure

*   `justfile`: Task runner configuration.
*   `/python`: Contains the Python source code and WIT interface definitions.
    *   `app.py`: The physics engine implementation.
    *   `physics.wit`: The WebAssembly interface definition.
*   `/webui`: The frontend dashboard.
    *   `index.html`: The visualization and control references.
    *   `dist/`: Output directory for the transpiled Wasm/JS files.

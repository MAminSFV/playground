# Justfile for Physics Engine WASM Project

# Default recipe
default: build transpile

# Install python dependencies and check for jco
setup:
    uv sync
    cd python && uv run componentize-py -d . -w engine bindings generated
    npm install

# Compile Python code to WebAssembly Component
build:
    @mkdir -p webui/build
    cd python && uv run componentize-py -d . -w engine componentize app -o ../webui/build/physics.wasm --stub-wasi
    @echo "Build complete: webui/build/physics.wasm"

# Transpile Wasm Component to Browser-ready JS
transpile:
    npx jco transpile webui/build/physics.wasm -o webui/dist --no-wasi-shim
    @echo "Transpilation complete: webui/dist/"

# Run the local development server
serve:
    python3 -m http.server -d webui

# Clean up generated files
clean:
    rm -rf webui/build
    rm -rf webui/dist

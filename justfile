# Default recipe
default: clean setup build transpile serve

# Install python dependencies and check for jco
setup:
    uv sync
    npm install

# Compile Python code to WebAssembly Component
build:
    uv run bash sim/scripts/build.sh

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
    rm -rf sim/generated

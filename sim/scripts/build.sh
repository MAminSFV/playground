#!/bin/bash
set -e

# Get the directory of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Get the sim directory (parent of scripts)
SIM_DIR="$(dirname "$SCRIPT_DIR")"
# Get the project root (parent of sim)
PROJECT_ROOT="$(dirname "$SIM_DIR")"

echo "Building WASM component in: $SIM_DIR"

# Change to the sim directory
cd "$SIM_DIR"

# 1. Generate Bindings (for auto-complete and intermediate steps)
echo "Generating bindings..."
componentize-py -d . -w engine bindings generated

# 2. Build Component
echo "Compiling to WASM..."
# Ensure output dir exists
mkdir -p "$PROJECT_ROOT/webui/build"

# Run componentize from sim dir, outputting to webui/build
componentize-py -d . -w engine componentize app -o "$PROJECT_ROOT/webui/build/physics.wasm" --stub-wasi

echo "Build complete: webui/build/physics.wasm"

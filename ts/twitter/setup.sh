#!/bin/bash

# Check if yarn is installed
if ! command -v yarn &> /dev/null; then
    echo "Error: yarn is not installed"
    echo "Please install yarn before running this script"
    echo "Visit https://yarnpkg.com/getting-started/install for installation instructions"
    exit 1
fi

# Install dependencies
echo "Installing dependencies..."

if yarn install; then
    echo "Dependencies installed successfully"
    echo "You can now start the development server with: yarn dev"
else
    echo "Error: Failed to install dependencies"
    echo "Please check the error messages above and try again"
    exit 1
fi

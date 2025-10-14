#!/bin/bash

# Quick update script for Reporting Dash
# Usage: ./update.sh "Your commit message here"

if [ -z "$1" ]; then
    echo "Error: Please provide a commit message"
    echo "Usage: ./update.sh \"Your commit message\""
    exit 1
fi

# Navigate to the repo directory
cd "$(dirname "$0")"

# Check for changes
if [[ -z $(git status -s) ]]; then
    echo "No changes to commit"
    exit 0
fi

# Show what will be committed
echo "Changes to be committed:"
git status -s
echo ""

# Add all changes
git add .

# Create commit with message
git commit -m "$1

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# Push to GitHub
git push origin main

echo ""
echo "✓ Successfully pushed to GitHub!"
echo "View at: https://github.com/farchionej/Reporting-Dash"

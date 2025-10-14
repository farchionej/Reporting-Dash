# Update Guide

This guide explains how to make updates to Reporting Dash and push them to GitHub.

## Quick Method (Recommended)

Use the provided update script for fast commits:

```bash
cd /Users/jarodfarchione/reporting-dash
./update.sh "Description of your changes"
```

Example:
```bash
./update.sh "Fix bug in email generator"
./update.sh "Add new restaurant contact: Acme Bistro"
./update.sh "Update dashboard styling"
```

## Manual Method

If you prefer more control:

```bash
cd /Users/jarodfarchione/reporting-dash

# Check what changed
git status

# Add specific files
git add index.html
# Or add everything
git add .

# Commit with message
git commit -m "Your commit message"

# Push to GitHub
git push origin main
```

## Working Directory

All files are located in:
```
/Users/jarodfarchione/reporting-dash/
├── index.html          # Main dashboard file
├── README.md           # Project documentation
├── CHANGELOG.md        # Version history
├── .gitignore          # Git ignore rules
└── update.sh           # Quick update script
```

## Best Practices

1. **Test changes locally first**: Open `index.html` in a browser before committing
2. **Write clear commit messages**: Describe what changed and why
3. **Update CHANGELOG.md**: For significant changes, add an entry
4. **Keep commits atomic**: One logical change per commit

## Common Updates

### Updating the Dashboard Code
```bash
# Edit the file
open /Users/jarodfarchione/reporting-dash/index.html

# Test in browser
open /Users/jarodfarchione/reporting-dash/index.html

# Commit and push
./update.sh "Update: improved chart rendering"
```

### Adding a New Restaurant Contact
```bash
# Edit index.html, find the restaurantContacts object
# Add your new entry

./update.sh "Add contact mapping for [Restaurant Name]"
```

### Fixing Bugs
```bash
./update.sh "Fix: resolve email generation error for null values"
```

## Viewing Changes

Check your commits on GitHub:
https://github.com/farchionej/Reporting-Dash/commits/main

## Reverting Changes

If you need to undo a change:

```bash
# See commit history
git log --oneline

# Revert to a specific commit
git revert <commit-hash>
git push origin main
```

## Need Help?

If you encounter issues:
1. Check `git status` to see the current state
2. Use `git log` to see recent commits
3. The repository is at: https://github.com/farchionej/Reporting-Dash

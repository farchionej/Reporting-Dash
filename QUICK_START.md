# Quick Start Guide

## Repository Information
- **GitHub URL**: https://github.com/farchionej/Reporting-Dash
- **Local Path**: `/Users/jarodfarchione/reporting-dash/`
- **Main File**: `index.html`

## Running the Dashboard

```bash
# Open in browser
open /Users/jarodfarchione/reporting-dash/index.html
```

Or simply double-click `index.html` in Finder.

## Making Updates

### Option 1: Quick Update (Recommended)
```bash
cd /Users/jarodfarchione/reporting-dash
./update.sh "Your change description"
```

### Option 2: Manual Process
```bash
cd /Users/jarodfarchione/reporting-dash
git add .
git commit -m "Your message"
git push origin main
```

## Key Files

| File | Purpose |
|------|---------|
| `index.html` | Main dashboard application |
| `README.md` | Project documentation |
| `UPDATE_GUIDE.md` | Detailed update instructions |
| `CHANGELOG.md` | Version history |
| `update.sh` | Quick commit & push script |

## Common Tasks

### Edit Dashboard
1. Open `index.html` in your editor
2. Make changes
3. Test in browser: `open index.html`
4. Commit: `./update.sh "Describe your changes"`

### View on GitHub
```bash
open https://github.com/farchionej/Reporting-Dash
```

### Check Status
```bash
git status           # See what changed
git log --oneline    # See recent commits
```

### Revert to Previous Version
```bash
git log --oneline    # Find commit hash
git checkout <hash> index.html
./update.sh "Revert to previous version"
```

## Need Help?

See `UPDATE_GUIDE.md` for comprehensive documentation.

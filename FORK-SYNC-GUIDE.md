# Fork Syncing Strategy

This repository is a fork of `copy/v86`. To maintain the ability to sync with upstream while having our own customizations, we use a **dual-branch strategy**:

## Branch Structure

- **`master`** - Syncs with upstream `copy/v86` (original repo)
- **`main`** - Our production branch with custom changes + GitHub Pages deployment
- **`wip`** - Work-in-progress experimental features

## Why This Setup?

1. The original repository (`copy/v86`) uses `master` as default
2. GitHub's "Sync fork" feature requires matching branch names
3. We want to use `main` for modern Git conventions and deploy from it
4. Solution: Keep both branches, sync `master` from upstream, merge into `main`

## Workflow for Syncing Upstream Changes

### Method 1: Using GitHub Web UI (Easiest)

1. Go to: https://github.com/Prozectz/v86
2. Switch to `master` branch (dropdown at top left)
3. Click **"Sync fork"** button
4. Click **"Update branch"**
5. Then locally:

```powershell
# Switch to master and pull latest
git checkout master
git pull origin master

# Switch to main and merge master
git checkout main
git merge master

# Push to main
git push origin main
```

### Method 2: Using Command Line (Full Control)

```powershell
# Fetch latest from upstream (copy/v86)
git fetch upstream

# Switch to master and update from upstream
git checkout master
git merge upstream/master
git push origin master

# Switch to main and merge master changes
git checkout main
git merge master

# Resolve any conflicts if needed
# Then push
git push origin main
```

## Deployment Trigger

The GitHub Pages deployment workflow (`.github/workflows/deploy-pages.yml`) is configured to:
- **Trigger on:** pushes to `main` branch
- **Build:** The full optimized version
- **Deploy:** To GitHub Pages automatically

So the flow is:
1. Upstream changes → `master` branch
2. Merge `master` → `main` branch
3. Push `main` → triggers automatic deployment

## Regular Maintenance

### Weekly/Monthly: Check for Upstream Updates

```powershell
# Check if upstream has new changes
git fetch upstream
git log master..upstream/master --oneline

# If there are updates, sync them
git checkout master
git merge upstream/master
git push origin master

# Merge to main
git checkout main
git merge master
git push origin main
```

## Important Notes

1. **Never delete `master` branch** - needed for syncing with upstream
2. **Make custom changes on `main`** - not on `master`
3. **Keep `master` clean** - it should match upstream as closely as possible
4. **Resolve conflicts carefully** - when merging `master` → `main`, your custom changes (deployment workflow) might conflict

## Current Custom Changes on `main`

Files added/modified on `main` that are NOT in `master`:
- `.github/workflows/deploy-pages.yml` - GitHub Pages deployment
- `.github/workflows/ci.yml` - Updated to use `main` branch references
- `DEPLOY.md` - Deployment documentation
- `FORK-SYNC-GUIDE.md` - This file

When syncing from upstream, these files should be preserved on `main`.

## Quick Reference Commands

```powershell
# See what's different between branches
git log master..main --oneline

# Check upstream for updates
git fetch upstream && git log master..upstream/master --oneline

# Full sync workflow
git checkout master && git pull upstream master && git push origin master
git checkout main && git merge master && git push origin main
```

## Automation Option

You could create a GitHub Action to automatically sync `master` from upstream and create a PR to merge into `main`. This would make the process even smoother, but requires careful configuration to avoid breaking changes.

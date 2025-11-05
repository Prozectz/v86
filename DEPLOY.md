# GitHub Pages Deployment Setup

This repository is configured to automatically build and deploy to GitHub Pages using GitHub Actions.

## How It Works

Every time you push to the `main` branch, the workflow:

1. Sets up Node.js, Rust, and clang in the GitHub Actions runner
2. Builds the optimized production version (`make all`)
3. Packages the static site files
4. Deploys to GitHub Pages automatically

**You don't need Rust or clang installed locally!** Everything runs in the cloud.

## One-Time Setup Steps

### 1. Enable GitHub Pages

1. Go to your repository on GitHub: `https://github.com/Prozectz/v86`
2. Click **Settings** (top right)
3. Click **Pages** (left sidebar, under "Code and automation")
4. Under **Source**, select:
   - Source: **GitHub Actions**
5. Click **Save**

That's it! The next push to `main` will automatically deploy.

### 2. Push This Workflow File

```powershell
# Make sure you're on main branch
git checkout main

# Add the new workflow file
git add .github/workflows/deploy-pages.yml
git add DEPLOY.md

# Commit
git commit -m "Add automated GitHub Pages deployment workflow"

# Push to GitHub
git push -u origin main
```

### 3. Watch the Deployment

1. Go to the **Actions** tab in your GitHub repository
2. You'll see "Build and Deploy to GitHub Pages" workflow running
3. Wait ~5-10 minutes for the build to complete
4. Once green ✅, your site will be live at:
   - `https://prozectz.github.io/v86/`

## Manual Deployment

You can also trigger deployment manually:

1. Go to **Actions** tab
2. Select "Build and Deploy to GitHub Pages"
3. Click **Run workflow**
4. Select `main` branch
5. Click **Run workflow**

## What Gets Deployed

The workflow deploys:

- `index.html` - Main emulator page
- `debug.html` - Debug version
- `build/` - All compiled JavaScript and WebAssembly files
- `bios/` - BIOS files
- `examples/` - Example pages including terminal examples
- `v86.css`, `manifest.json`, `Readme.md`, `LICENSE`

**Note:** Disk images (`images/` folder) are not deployed due to their large size. You can:

- Host them separately (e.g., on another CDN)
- Upload smaller images to GitHub Pages manually
- Use the existing images at `https://i.copy.sh/` (default in examples)

## Terminal Examples

Once deployed, you can access terminal examples at:

- `https://prozectz.github.io/v86/examples/serial.html` - Serial terminal
- `https://prozectz.github.io/v86/examples/tcp_terminal.html` - TCP terminal
- `https://prozectz.github.io/v86/` - Main UI with terminal

## Local Development (No Rust Needed)

If you want to test locally without building:

1. Download a pre-built release from the Actions artifacts
2. Extract and serve with: `python -m http.server 8000`
3. Open: `http://localhost:8000/`

For local building (requires Rust + clang):

```powershell
make all
make run
```

## Troubleshooting

### Workflow fails with "Permission denied"

- Go to Settings → Actions → General
- Under "Workflow permissions", select "Read and write permissions"
- Click Save

### Deployment succeeds but site shows 404

- Make sure GitHub Pages source is set to "GitHub Actions" (not branch)
- Wait a few minutes for DNS propagation
- Check Actions tab for any error messages

### Build takes too long or fails

- Check Actions logs for specific errors
- Most common: Node.js or Rust setup issues (workflow handles this)
- Timeout is set to 30 minutes, which should be plenty

## Updating the Site

Just push to master:

```powershell
# Make your changes
git add .
git commit -m "Your changes"
git push origin main
```

The site will automatically rebuild and redeploy! 🚀

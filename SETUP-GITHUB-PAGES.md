# 🚀 Final Setup Steps for GitHub Pages

Your code has been pushed! Now complete these steps on GitHub to activate deployment:

## Step 1: Change Default Branch to `main`

1. Go to: https://github.com/Prozectz/v86
2. Click **Settings** (top right)
3. Click **Branches** (left sidebar)
4. Under "Default branch", click the ⟲ switch icon
5. Select `main` from the dropdown
6. Click **Update**
7. Click **I understand, update the default branch**

## Step 2: Delete Old `master` Branch (Optional)

After changing the default branch:
1. Still in Settings → Branches
2. Scroll to "Branch protection rules" (or go to main repo page)
3. Go back to main repo page
4. Click the branches dropdown (shows "2 branches")
5. Find `master` branch
6. Click the 🗑️ (trash) icon next to it
7. Confirm deletion

Or via command line:
```powershell
git push origin --delete master
```

## Step 3: Enable GitHub Pages

1. In Settings (still), click **Pages** (left sidebar, under "Code and automation")
2. Under **Build and deployment**:
   - **Source**: Select **GitHub Actions** (not "Deploy from a branch")
3. Click **Save** if needed

## Step 4: Trigger First Deployment

The workflow will run automatically when you push, but you can trigger it manually:

1. Go to **Actions** tab: https://github.com/Prozectz/v86/actions
2. Click **"Build and Deploy to GitHub Pages"** in the left sidebar
3. Click **Run workflow** (right side)
4. Select `main` branch
5. Click **Run workflow** button

## Step 5: Wait and Verify

1. Watch the workflow run (takes ~5-10 minutes)
2. Once it shows green ✅, your site is live!
3. Visit: **https://prozectz.github.io/v86/**

### Terminal Examples:
- Main UI: https://prozectz.github.io/v86/
- Serial Terminal: https://prozectz.github.io/v86/examples/serial.html
- TCP Terminal: https://prozectz.github.io/v86/examples/tcp_terminal.html

## Troubleshooting

### If workflow fails:
- Check Actions → failed workflow → click on the red ❌ → read error logs
- Most common issue: Permissions
  - Go to Settings → Actions → General
  - Under "Workflow permissions", select **"Read and write permissions"**
  - Check **"Allow GitHub Actions to create and approve pull requests"**
  - Click **Save**

### If site shows 404:
- Make sure you selected "GitHub Actions" as source (not branch)
- Wait 2-3 minutes after workflow completes
- Hard refresh (Ctrl+Shift+R)

### If you want to customize:
- Edit files locally
- `git add .`
- `git commit -m "Your changes"`
- `git push origin main`
- Site rebuilds automatically!

## What Happens Automatically

Every push to `main` branch will:
1. ✅ Install Rust, Node.js, clang in GitHub's runner
2. ✅ Build the optimized production version (`make all`)
3. ✅ Package all static files
4. ✅ Deploy to GitHub Pages
5. ✅ Update your site (usually within 5-10 minutes)

**No local Rust/clang installation needed!** 🎉

---

For detailed info, see [DEPLOY.md](DEPLOY.md)

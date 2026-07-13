# Deploy Shanthi Akula demo site to a NEW public GitHub repo + GitHub Pages.
# Prereq: run `gh auth login` once first (interactive).
# Usage: powershell -ExecutionPolicy Bypass -File scripts\deploy_github_pages.ps1

$ErrorActionPreference = "Stop"
$repo = "shanthi-akula-website"
Set-Location "C:\shanthi-akula-website"

# 0. Confirm auth
gh auth status | Out-Null

# 1. Who am I
$user = (gh api user --jq ".login").Trim()
Write-Host "GitHub user: $user"
$pagesUrl = "https://$user.github.io/$repo/"

# 2. Create the new PUBLIC repo from current folder and push main
gh repo create $repo --public --source=. --remote=origin --push

# 3. Publish the site: push demo/ as the root of a gh-pages branch
git subtree push --prefix demo origin gh-pages

# 4. Enable GitHub Pages on gh-pages branch (root)
try {
  gh api -X POST "repos/$user/$repo/pages" -f "source[branch]=gh-pages" -f "source[path]=/" | Out-Null
  Write-Host "Pages enabled."
} catch {
  Write-Host "Pages may already be enabled, or enable manually: Settings > Pages > Branch: gh-pages / root"
}

Write-Host ""
Write-Host "==================================================="
Write-Host " LIVE PREVIEW URL (allow 1-2 min to build):"
Write-Host " $pagesUrl"
Write-Host "==================================================="

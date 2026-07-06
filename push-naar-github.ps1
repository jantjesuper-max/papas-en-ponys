# Pusht dit project naar GitHub met het token uit github-token.txt
# Gebruik:  .\push-naar-github.ps1 -Repo "gebruikersnaam/reponaam"
# Na de eerste keer onthoudt het script de repo en volstaat:  .\push-naar-github.ps1
param(
    [string]$Repo
)

$tokenFile = Join-Path $PSScriptRoot "github-token.txt"
$token = (Get-Content $tokenFile -TotalCount 1).Trim()

if (-not $token -or $token -eq "PLAK_HIER_JE_GITHUB_TOKEN") {
    Write-Host "Zet eerst je GitHub-token in github-token.txt" -ForegroundColor Red
    exit 1
}

# Repo bepalen: parameter, of eerder ingestelde remote
if ($Repo) {
    git remote remove origin 2>$null
    git remote add origin "https://github.com/$Repo.git"
} else {
    $originUrl = git remote get-url origin 2>$null
    if (-not $originUrl) {
        Write-Host "Geef de eerste keer de repo op:  .\push-naar-github.ps1 -Repo 'gebruikersnaam/reponaam'" -ForegroundColor Red
        exit 1
    }
    $Repo = $originUrl -replace '^https://github\.com/', '' -replace '\.git$', ''
}

$branch = git branch --show-current
if (-not $branch) { $branch = "main" }

# Push met token in de URL (wordt nergens opgeslagen)
git push "https://$token@github.com/$Repo.git" "${branch}:${branch}"
if ($LASTEXITCODE -eq 0) {
    git branch --set-upstream-to="origin/$branch" $branch 2>$null
    Write-Host "Gepusht naar https://github.com/$Repo ($branch)" -ForegroundColor Green
}

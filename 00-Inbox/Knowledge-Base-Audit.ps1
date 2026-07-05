<#
.SYNOPSIS
    Knowledge Base Audit - Scan vault for issues and generate report.
.DESCRIPTION
    Checks for duplicate content, classification conflicts, unusual filenames,
    empty directories, junk files, and orphaned notes.
#>

param(
    [string]$VaultPath = "F:\Codex_Ai_Knowledges_Vault"
)

$report = @()
$report += "# Knowledge Base Audit Report"
$report += "**Generated**: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
$report += ""

# 1. Check empty directories
$report += "## 1. Empty Directories"
$emptyDirs = Get-ChildItem -Path $VaultPath -Directory -Recurse | Where-Object {
    (Get-ChildItem -Path $_.FullName -Force | Measure-Object).Count -eq 0
}
if ($emptyDirs) {
    $emptyDirs | ForEach-Object { $report += "- $($_.FullName.Replace($VaultPath, ''))" }
} else {
    $report += "None found."
}
$report += ""

# 2. Check for duplicate filenames
$report += "## 2. Duplicate Filenames"
$allFiles = Get-ChildItem -Path $VaultPath -File -Recurse -Filter "*.md" | Where-Object {
    $_.DirectoryName -notmatch '\.obsidian'
}
$dupes = $allFiles | Group-Object Name | Where-Object { $_.Count -gt 1 }
if ($dupes) {
    $dupes | ForEach-Object {
        $report += "### $($_.Name)"
        $_.Group | ForEach-Object { $report += "- $($_.FullName.Replace($VaultPath, ''))" }
    }
} else {
    $report += "None found."
}
$report += ""

# 3. Check unusual filenames
$report += "## 3. Unusual Filenames"
$unusual = $allFiles | Where-Object { $_.Name -match '[^\x20-\x7E]' -or $_.Name.Length -gt 200 }
if ($unusual) {
    $unusual | ForEach-Object { $report += "- $($_.Name)" }
} else {
    $report += "None found."
}
$report += ""

# 4. Junk files
$report += "## 4. Potential Junk Files"
$junk = Get-ChildItem -Path $VaultPath -File -Recurse | Where-Object {
    $_.Extension -match '\.(tmp|bak|log|orig)$' -or
    $_.Name -match '^~\$' -or
    ($_.Name -match '\.DS_Store$')
}
if ($junk) {
    $junk | ForEach-Object { $report += "- $($_.FullName.Replace($VaultPath, ''))" }
} else {
    $report += "None found."
}
$report += ""

# 5. Orphaned notes (no internal links to them)
$report += "## 5. Orphaned Notes (no backlinks)"
$orphans = @()

foreach ($f in $allFiles) {
    $relPath = $f.FullName.Replace($VaultPath, '').TrimStart('\')
    $baseName = $f.BaseName
    $isLinked = $false
    foreach ($other in $allFiles) {
        if ($other.FullName -ne $f.FullName) {
            $content = Get-Content -Path $other.FullName -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
            if ($content -match "\[\[$([regex]::Escape($baseName))\]\]") {
                $isLinked = $true
                break
            }
        }
    }
    if (-not $isLinked) { $orphans += $relPath }
}

# Filter out known non-linked files (templates, system files)
$systemPrefixes = @('90-Templates', '89-Prompts', '00-Inbox', '97-AI-Memory', '98-AI-Context')
$orphans = $orphans | Where-Object {
    $prefix = $_.Split('\')[0]
    $prefix -notin $systemPrefixes
}

if ($orphans) {
    $orphans | ForEach-Object { $report += "- $_" }
} else {
    $report += "None found."
}

# 6. Stats
$report += ""
$report += "## 6. Vault Statistics"
$report += "- Total .md files: $($allFiles.Count)"
$report += "- Total directories: $((Get-ChildItem -Path $VaultPath -Directory -Recurse | Measure-Object).Count)"
$report += "- Empty directories: $(if ($emptyDirs) { $emptyDirs.Count } else { 0 })"
$report += ""

$reportContent = ($report -join "`n")
$reportPath = Join-Path $VaultPath "Knowledge-Base-Audit-Report.md"
Set-Content -Path $reportPath -Value $reportContent -Encoding UTF8 -NoNewline
Write-Output "Audit report saved to $reportPath"
Write-Output $reportContent

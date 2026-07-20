<#
.SYNOPSIS
    Research Cleaner - Auto-clean and classify downloaded research Markdown files.
.DESCRIPTION
    Scans 01-Inbox/Downloaded, cleans formatting, extracts metadata,
    and moves files to 01-Inbox/Cleaned with improved naming and structure.
#>

param(
    [string]$SourceDir = "F:\Codex_Ai_Knowledges_Vault\01-Inbox\Downloaded",
    [string]$TargetDir = "F:\Codex_Ai_Knowledges_Vault\01-Inbox\Cleaned"
)

$files = Get-ChildItem -Path $SourceDir -Filter "*.md"
$processed = 0

foreach ($file in $files) {
    Write-Host "Processing: $($file.Name)"
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8

    # Extract title from first # heading
    $title = ""
    if ($content -match '^#\s+(.+)$') { $title = $Matches[1].Trim() }

    # Extract source URL
    $source = ""
    if ($content -match 'Source:\s*(https?://[^\s]+)') { $source = $Matches[1] }
    if (-not $source -and $content -match '\[Source\]\((https?://[^\s\)]+)\)') { $source = $Matches[1] }

    # Extract date
    $date = $file.LastWriteTime.ToString("yyyy-MM-dd")

    # Clean: normalize line endings, remove excessive blank lines
    $content = $content -replace '\r\n', "`n"
    $content = $content -replace '\n{3,}', "`n`n"

    # Determine category based on keyword analysis
    $category = "Uncategorized"
    $tags = @()
    switch -Regex ($content.ToLower()) {
        "ai|llm|gpt|claude|codex|agent|prompt|mcp" { $category = "AI"; $tags += "topic/ai-agent" }
        "crypto|bitcoin|eth|defi|nft|blockchain|web3" { $category = "Crypto"; $tags += "topic/crypto" }
        "a股|上证|深证|沪深|a-stock" { $category = "A-Stocks"; $tags += "topic/a-stocks" }
        "美股|nasdaq|sp500|dow|us-stock|sec" { $category = "US-Stocks"; $tags += "topic/us-stocks" }
        "python|javascript|rust|golang|programming|代码" { $category = "Programming"; $tags += "topic/programming" }
        "量化|backtest|strategy|quant|trading" { $category = "Quant-Trading"; $tags += "topic/quant" }
        "obsidian|知识库|vault|note" { $tags += "topic/obsidian" }
        "github|git|版本控制" { $tags += "topic/github" }
        "workflow|自动化|automation" { $tags += "topic/workflow" }
    }

    # Add topic hub tags
    if ($category -eq "AI") { $tags += "topic/codex"; $tags += "topic/claude-code" }

    $tagsYaml = ($tags | ForEach-Object { "  - $_" }) -join "`n"

    # Build frontmatter
    $newName = "$date"
    if ($title) { $newName += "_$title" -replace '[\\/:*?"<>|]', '-' }
    $newName = ($newName.Substring(0, [Math]::Min(120, $newName.Length))) + ".md"

    $frontmatter = @"
---
title: "$title"
source: "$source"
date: $date
category: "$category"
tags:
$tagsYaml
cleaned: true
---
"@

    $finalContent = $frontmatter + "`n`n" + $content

    $targetPath = Join-Path $TargetDir $newName
    $counter = 1
    while (Test-Path $targetPath) {
        $newName = "$date`_$title`_$counter.md"
        $targetPath = Join-Path $TargetDir $newName
        $counter++
    }

    Set-Content -Path $targetPath -Value $finalContent -Encoding UTF8 -NoNewline
    Write-Host "  -> $newName (Category: $category)"
    $processed++
}

Write-Host "`nDone. Processed $processed files."

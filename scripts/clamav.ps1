# Display message
Write-Host "===== Start download for clamav ====="

# Define the CLAMAV_DIR environment variable
$CLAMAV_DIR = $Env:CLAMAV_DIR

# URLs for ClamAV database files
$urls = @(
    "https://database.clamav.net/main.cvd",
    "https://database.clamav.net/daily.cvd",
    "https://database.clamav.net/bytecode.cvd"
)

# Download each file with the specified user-agent and save to CLAMAV_DIR
foreach ($url in $urls) {
    $filename = Split-Path -Leaf $url
    $outputPath = Join-Path -Path $CLAMAV_DIR -ChildPath $filename

    Invoke-WebRequest -Uri $url -OutFile $outputPath -Headers @{
        "user-agent" = "CVDUPDATE"
    }
}

# Completion message
Write-Host "===== Completed download for clamav ====="
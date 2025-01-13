# Display message
Write-Host "===== Start download for trivy ====="

# Define the path to the JSON file
$orasJsonPath = "scripts/oras-latest.json"

# Download the latest ORAS release information
Invoke-WebRequest -Uri "https://api.github.com/repos/oras-project/oras/releases/latest" -OutFile $orasJsonPath

# Define the pattern to search for
$orasPattern = "https://github.com/oras-project/oras/releases/download.*windows.*tar.gz"

# Read the JSON file and search for the matching URL
$url = Select-String -Path $orasJsonPath -Pattern $orasPattern | ForEach-Object {
    ($_ -match $orasPattern) | Out-Null
    $matches[0]
}

if ($url) {
    # Determine the filename based on the presence of ".asc" in the URL
    $filename = if ($url -notmatch "\.asc$") {
        "oras_windows.tar.gz"
    } else {
        "oras_windows.tar.gz.asc"
    }

    # Download the ORAS file
    Invoke-WebRequest -Uri $url -OutFile "scripts/$filename"

    # Extract the tar.gz file
    tar -xzf "scripts/oras_windows.tar.gz" -C "scripts"

    # Define the TRIVY_DIR environment variable (update this path as needed)
    $TRIVY_DIR = $Env:TRIVY_DIR

    # Pull the trivy database
    & "scripts/oras" pull "ghcr.io/aquasecurity/trivy-db:2" -a -o $TRIVY_DIR
    & "scripts/oras" pull "ghcr.io/aquasecurity/trivy-java-db:1" -a -o $TRIVY_DIR

    Write-Host "===== Completed download for trivy ====="
} else {
    Write-Host "No matching URL found in the JSON file."
}
# Display message
Write-Host "===== Start download for Semgrep ====="

# Define the path to the SEMGREP_DIR environment variable
$SEMGREP_DIR = $Env:SEMGREP_DIR

# Download the Semgrep rules file
Invoke-WebRequest -Uri "https://semgrep.dev/c/p/default" -OutFile "$SEMGREP_DIR\rules.yml"

# Display message
Write-Host "===== Completed download for Semgrep ====="

# Display message
Write-Host "===== Start download for openscap ====="

# Define the OPENSCAP_DIR environment variable
$OPENSCAP_DIR = $Env:OPENSCAP_DIR

# URL for the OpenSCAP file
$url = "https://access.redhat.com/security/data/oval/v2/RHEL8/rhel-8.oval.xml.bz2"

# Define the output file path
$outputFile = Join-Path -Path $OPENSCAP_DIR -ChildPath "rhel-8.oval.xml.bz2"

# Download the file
Invoke-WebRequest -Uri $url -OutFile $outputFile -Headers @{
    "user-agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"
}

# Completion message
Write-Host "===== Complete download for openscap ====="
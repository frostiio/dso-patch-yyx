# Display message
Write-Host "===== Start download for grype ====="

# Define the GRYPE_DIR environment variable
$GRYPE_DIR = $Env:GRYPE_DIR

# Download the listing.json file
Invoke-WebRequest -Uri "https://toolbox-data.anchore.io/grype/databases/listing.json" -OutFile "$GRYPE_DIR\listing.json"

# Modify the JSON content and save to a new file
(Get-Content "$GRYPE_DIR\listing.json") -replace '}, {', "},`n{" -replace '], ', "],`n" | 
    Set-Content -Path "$GRYPE_DIR\listing_modified.json" -Encoding ASCII

# Define the search pattern
$grypePattern = "vulnerability-db_v5_*"

# Read the modified JSON file and search for matching patterns
$lines = Get-Content "$GRYPE_DIR\listing_modified.json" | Select-String -Pattern $grypePattern

foreach ($line in $lines) {
    $fields = $line -split ','

    Write-Host "fiels >>>>\n$fields"
    # Parse URL from the fields
    $url = $fields[2].Trim('"')
    $originalFilename = ($url -split '/')[-1]
    $outputFilename = $originalFilename -replace ':', '_'

    # Download the file
    Write-Host "##################################"
    Write-Host $url
    Write-Host $originalFilename
    Write-Host $outputFilename
    Write-Host $GRYPE_DIR
    Write-Host "##################################"
    Invoke-WebRequest -Uri "$url" -OutFile "$GRYPE_DIR\$outputFilename"

    # Update the JSON structure (example for demonstration, adjust if necessary)
    $jsonEntry = @{
        available = @{
            field1 = $fields[0]
            field2 = $fields[1]
            url = $url
            field4 = $fields[3..($fields.Count - 1)] -join ','
        }
    }

    # Save the updated JSON to the listing.json file
    $jsonEntry | ConvertTo-Json -Depth 3 | Set-Content -Path "$GRYPE_DIR\listing.json"

    break  # Exit the loop after the first match (equivalent to `goto :completed`)
}

# Completion message
Write-Host "===== Complete download for grype ====="
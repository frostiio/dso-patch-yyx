$scriptPath = $PSScriptRoot

if (Test-Path "$scriptPath\db") {
    Remove-Item "$scriptPath\db" -Recurse -Force
}

if (Test-Path "$scriptPath\db.zip") {
    Remove-Item "$scriptPath\db.zip" -Force
}

New-Item -Path "$scriptPath\db" -ItemType Directory

# $tools = @("trivy", "grype", "clamav", "openscap", "semgrep")
$tools = @("grype")

foreach ($tool in $tools) {
    $envVarName = $tool.ToUpper() + "_DIR"
    $envVarValue = "$scriptPath\db\$tool"
    Set-Item -Path "env:$envVarName" -Value $envVarValue
    New-Item -Path $envVarValue -ItemType Directory
    & "$scriptPath\scripts\$tool.ps1"
}

Compress-Archive -Path "$scriptPath\db" -DestinationPath "$scriptPath\db.zip"
# powershell.exe -ExecutionPolicy bypass .\msbuild_making_network_connection.ps1

# Define MSBuild path
$MSBuildPath = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe"

# Create the MSBuild XML content with a network request
$MSBuildXml = @"
<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
    <Target Name="Trigger">
        <Exec Command='powershell.exe -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri `"http://example.com`" -UseBasicParsing"' />
    </Target>
</Project>
"@

# Save the XML content to a temporary file
$TempProjectFile = "C:\temp\temp_project_$((Get-Random).ToString()).proj"
$MSBuildXml | Set-Content -Path $TempProjectFile

# Run MSBuild with the generated project file and capture the output (including errors)
$MSBuildOutput = & $MSBuildPath /nologo /v:detailed /t:Trigger $TempProjectFile

# Output MSBuild execution log to console
Write-Host "MSBuild execution log:"
Write-Host $MSBuildOutput

# Clean up the temporary project file
Remove-Item -Path $TempProjectFile -Force

Add-Type -AssemblyName System.Windows.Forms

# Step 1: Select input text file
$inputDialog = New-Object System.Windows.Forms.OpenFileDialog
$inputDialog.InitialDirectory = (Get-Location).Path
$inputDialog.Filter = "VRML (*.wrl)|*.wrl|All files (*.*)|*.*"
$inputDialog.Title = "Select the input text file"

if ($inputDialog.ShowDialog() -ne "OK") {
    Write-Host "No input file selected. Exiting."
    exit
}
$inputFile = $inputDialog.FileName

# Step 2: Select CSV file for replacement table
$csvDialog = New-Object System.Windows.Forms.OpenFileDialog
$csvDialog.InitialDirectory = (Get-Location).Path
$csvDialog.Filter = "CSV files (*.csv)|*.csv|All files (*.*)|*.*"
$csvDialog.Title = "Select the CSV file with replacement table"

if ($csvDialog.ShowDialog() -ne "OK") {
    Write-Host "No CSV file selected. Exiting."
    exit
}
$csvFile = $csvDialog.FileName

# Step 3: Read replacement table from CSV
# Expecting columns: old,new
$replaceTable = Import-Csv $csvFile

# Step 4: Process input file and apply replacements
$outputFile = $inputFile -replace [regex]::Escape(".wrl"), "_pathSofs.wrl"

Get-Content $inputFile | ForEach-Object {
    $line = $_
    if ($line -like "*Inline*") {
        foreach ($pair in $replaceTable) {
            $line = $line -replace [regex]::Escape($pair.old), $pair.new
        }
    }
    $line
} | Set-Content $outputFile

Write-Host "Replacement complete. Output saved to: $outputFile"
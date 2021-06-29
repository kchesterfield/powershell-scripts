# PARAMETERS

Param($Path = $env:USERPROFILE + "\Documents\" + "InstalledSoftware\")

# PROCESS

$Path = $Path.Trim();

If($Path -notmatch '\\$')
{
    $Path = $Path + "\";
}

$OutputDate = Get-Date -Format "yyyy-MM-dd-HH-mm-ss";

$OutputTxtPath = $Path + $OutputDate + ".txt";
$OutputCsvPath = $Path + $OutputDate + ".csv";

If(!(test-path $Path))
{
      New-Item -ItemType Directory -Force -Path $Path;
}

Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* `
    | Where DisplayName `
    | Sort-Object DisplayName `
    | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate `
    | Format-Table –AutoSize `
    | Out-File -FilePath $OutputTxtPath;

Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* `
    | Sort-Object DisplayName `
    | Export-Csv -path $OutputCsvPath -NoTypeInformation;



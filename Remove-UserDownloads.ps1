# Remove-UserDownloads

# PARAMETERS

Param(
    $Path = [IO.Path]::Combine($env:USERPROFILE, 'Downloads'),
    $Days = 30);

# VALIDATE PARAMETERS

if(!(Test-Path -Path $Path)) {
    Throw "The following path could not be found: $Path ";
}

if(!($Days -is [int])) {
    Throw "The days supplied is not an integer: $Days ";
}

# PROCESS

if($Days -ge 0) {
    $Days = $Days * -1;
}
    
$Time = (Get-Date).AddDays($Days);

Get-ChildItem $Path `
    | Where-Object {$_.LastWriteTime -lt $Time} `
    | Remove-Item -Force -Recurse;

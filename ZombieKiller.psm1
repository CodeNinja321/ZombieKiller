function ZombieKiller {
$containername = $args[0]
$container_id = docker inspect --format="{{.Id}}" $containername
$file_path = 'C:\ProgramData\Docker\containers\' + $container_id + '\config.v2.json'

$file_contents = Get-Content $file_path -raw | ConvertFrom-Json
$file_contents.State | % {if($_.Running -eq 'true'){$_.Running=$false}}
$file_contents | ConvertTo-Json -depth 32| set-content $file_path

$processes = Get-Process "*docker desktop*"
if ($processes.Count -gt 0)
{
    $processes[0].Kill()
    $processes[0].WaitForExit()
}
Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
}


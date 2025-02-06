param(
    [string]$accessToken
)

# install maven
Write-Host "Downloading Maven"
Invoke-WebRequest "https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.zip" -OutFile "$env:temp\temp.zip" -UseBasicParsing
Expand-Archive "$env:temp\temp.zip" "$env:userprofile\AppData\Local\Programs\Apache"
Remove-Item "$env:temp\temp.zip" -Force
[System.Environment]::SetEnvironmentVariable("PATH", $env:PATH + ";" + $env:userprofile + "\AppData\Local\Programs\Apache\Apache-maven-3.9.9\bin", [System.EnvironmentVariableTarget]::Machine)

# set env vars
[System.Environment]::SetEnvironmentVariable('JAVA_HOME', 'C:\Program Files\Microsoft\jdk-21.0.6.7-hotspot', 'Machine')
[System.Environment]::SetEnvironmentVariable('JAVA11HOME', "C:\Program Files\Microsoft\jdk-11.0.26.4-hotspot", 'Machine')
[System.Environment]::SetEnvironmentVariable('JAVA21HOME', "C:\Program Files\Microsoft\jdk-21.0.6.7-hotspot", 'Machine')
[System.Environment]::SetEnvironmentVariable('JAVA8HOME', "C:\Program Files\Microsoft\jdk-8.0.442.6-hotspot", 'Machine')

# start application in separate shell
Set-Location "C:\azure-devcenter-ai\agent-node-app"
npm install
$npm = "C:\Program Files\nodejs\node.exe"
$params = "server.js" # where to start node from
Start-Process -FilePath $npm -ArgumentList $params
# set up dev tunnel
$devtunnelExe= "C:\Users\jackkays\AppData\Local\Microsoft\WinGet\Links\devtunnel.exe"
Start-Process -FilePath $devtunnelExe -ArgumentList "host my-dev-tunnel --access-token $accessToken"
# devtunnel host my-dev-tunnel --access-token $accessToken

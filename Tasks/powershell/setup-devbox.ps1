$Java8InstallLink="https://download.oracle.com/java/8/latest/jdk-8_windows-x64_bin.exe"
$Java8Installer="$env:TEMP\jdk-8_windows-x64_bin.exe"
$Java11InstallLink="https://download.oracle.com/java/11/latest/jdk-11_windows-x64_bin.exe"
$Java11Installer="$env:TEMP\jdk-11_windows-x64_bin.exe"
$Java21InstallLink="https://download.oracle.com/java/21/latest/jdk-21_windows-x64_bin.exe"
$Java21Installer="$env:TEMP\jdk-21_windows-x64_bin.exe"
# install java 8, 11, 17, 21
Write-Host "Creating JAVA root folder"
New-Item -ItemType Directory -Path "C:\Java" | Out-Null
Write-Host "Downloading Java 8"
New-Item -ItemType Directory -Path "C:\Java\8" | Out-Null
Invoke-RestMethod -Uri $Java17InstallLink -OutFile $Java17Installer
Start-Process -FilePath $Java17Installer -ArgumentList "/s" -Wait
Remove-Item -Path $Java17Installer
Write-Host "Downloading Java 11"
New-Item -ItemType Directory -Path "C:\Java\11" | Out-Null
Invoke-RestMethod -Uri $Java17InstallLink -OutFile $Java17Installer
Start-Process -FilePath $Java17Installer -ArgumentList "/s" -Wait
Remove-Item -Path $Java17Installer
Write-Host "Downloading Java 21"
New-Item -ItemType Directory -Path "C:\Java\21" | Out-Null
Invoke-RestMethod -Uri $Java17InstallLink -OutFile $Java17Installer
Start-Process -FilePath $Java17Installer -ArgumentList "/s" -Wait
Remove-Item -Path $Java17Installer
# install maven
Invoke-WebRequest "https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.zip" -OutFile "$env:temp\temp.zip" -UseBasicParsing
Expand-Archive "$env:temp\temp.zip" "$env:userprofile\AppData\Local\Programs\Apache"
Remove-Item "$env:temp\temp.zip" -Force
set PATH="$env:userprofile\AppData\Local\Programs\Apache\Apache-maven-3.9.9\bin";%PATH%
# install node
choco install nodejs-lts --version="22"
# set env vars

# clone repo

# start application in separate shell
$npm = "C:\Program Files\nodejs\node.exe"
$params = "" # where to start node from
Start-Job -FilePath $npm -ArgumentList $params
# set up dev tunnel
winget install Microsoft.devtunnel
devtunnel user login ## how to login?
devtunnel create my-dev-tunnel
devtunnel port create -p 5000 --protocol http
# store url and token in kv 
winget install -e --id Microsoft.AzureCLI
az login ## how to login?
az account set --subscription "3de261df-f2d8-4c00-a0ee-a0be30f1e48e"
$token = devtunnel token my-dev-tunnel --scopes connect
$url = devtunnel port show -p 5000 | ConvertFrom-Json | Select-Object -ExpandProperty url
az keyvault secret set --vault-name "devcenteraipoc-kv" --name "tunnel-url" --value $url
az keyvault secret set --vault-name "devcenteraipoc-kv" --name "tunnel-token" --value $token

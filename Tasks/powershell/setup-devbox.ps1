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
$npm = "C:\Program Files\nodejs\node.exe"
$params = "npm start:server" # where to start node from
Start-Job -FilePath $npm -ArgumentList $params
# set up dev tunnel
# devtunnel user login ## how to login?
# devtunnel create my-dev-tunnel
# devtunnel port create -p 5000 --protocol http
# store url and token in kv 
# az login ## how to login?
# az account set --subscription "3de261df-f2d8-4c00-a0ee-a0be30f1e48e"
# $token = devtunnel token my-dev-tunnel --scopes connect
# $url = devtunnel port show -p 5000 | ConvertFrom-Json | Select-Object -ExpandProperty url
# az keyvault secret set --vault-name "devcenteraipoc-kv" --name "tunnel-url" --value $url
# az keyvault secret set --vault-name "devcenteraipoc-kv" --name "tunnel-token" --value $token

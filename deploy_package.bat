@echo off
echo "arg1 ----------> method name, arg2 ----------> authorization json file, arg3 ------> reponame, arg4 -------> package version"
echo %~1 %~2 %~3 %~4

cd %~3

set AUTH_FILE=%~2
set PACKAGE_VERSION=%~4

call:%~1 %AUTH_FILE% "%PACKAGE_VERSION%"
goto exit

:DeployPackage 
call :AuthorizeSandbox %AUTH_FILE%
call sfdx force:package:install -w 20 -p %PACKAGE_VERSION% -u %SANDBOX_NAME%

:SetSandboxName
call  powershell -Command "$json = Get-Content '%1' | Out-String | ConvertFrom-Json ; $json.result.alias" > ./devName.txt 
set /p SANDBOX_NAME=<devName.txt
call del "./devName.txt"
goto:eof

:AuthorizeSandbox
set "PATH=%PATH%;C:\Program Files\sfdx\bin;"
call :SetSandboxName %1
call sfdx auth:sfdxurl:store -f  %1 -s -a %SANDBOX_NAME%
goto:eof

:exit
exit /b
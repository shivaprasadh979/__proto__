@echo off
echo "arg1 --> method name, arg2 ----> authfile, arg3 ----> Repo Name, arg4 ----> Custom Files/Folders , arg5 -----> Custom Test Classes"
echo %~1 %~2 %~3 %~4 %~5


cd %~3 

SET AUTH_FILE=%~2
SET CUSTOM_FOLDER=%~4
SET CUSTOM_TEST_CLASSES=%~5
SET "PATH=%PATH%;C:\Program Files\sfdx\bin;"

call:%~1 %AUTH_FILE% "%CUSTOM_FOLDER%" "%CUSTOM_TEST_CLASSES%"
goto exit

:DeployAll
call :AuthorizeSandbox %AUTH_FILE%
call :SetTestClasses
call :DeployData "force-app" "%TEST_CLASSES%"
goto:eof

:DeployCustomData
call :AuthorizeSandbox %AUTH_FILE%
call :DeployData "%CUSTOM_FOLDER%" "%CUSTOM_TEST_CLASSES%"
goto:eof

:DeployData
echo sfdx force:source:deploy -p %1 -l RunSpecifiedTests --runtests %2 -u %SANDBOX_NAME%
call sfdx force:source:deploy -p %1 -l RunSpecifiedTests --runtests %2 -u %SANDBOX_NAME%
goto:eof

:AuthorizeSandbox
call :SetSandboxName %1
call sfdx auth:sfdxurl:store -f  %1 -s -a %SANDBOX_NAME%
goto:eof

:SetSandboxName
call  powershell -Command "$json = Get-Content '%1' | Out-String | ConvertFrom-Json ; $json.result.alias" > ./devName.txt 
set /p SANDBOX_NAME=<devName.txt
call del "./devName.txt"
goto:eof

:SetTestClasses
call  powershell -Command "(ls .\force-app\test\classes\*.cls | select -expandproperty basename) -join ',' | Set-Content  -NoNewline './batchCommand.bat'  "
set /p TEST_CLASSES=<batchCommand.bat
call del "./batchCommand.bat"
goto:eof

:exit
exit /b
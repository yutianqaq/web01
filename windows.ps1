@echo off

echo 系统版本：
systeminfo | findstr /B /C:"OS 名称" /C:"OS 版本"
echo.

echo KB补丁：
wmic qfe list brief
echo.

echo 可能包含明文密码的文件：
findstr /si password *.txt *.ini
echo.

echo SSH密钥：
dir "%USERPROFILE%\.ssh"
echo.

echo 低权限用户可写的路径（不包括用户目录）：
icacls C:\ /t | findstr /i "(F)" | findstr /v /i "%USERPROFILE%"
echo.

echo PowerShell历史：
dir "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt"
echo.

echo 网络信息：
ipconfig /all
echo.

echo 安全控制措施：
echo 查询AMSI状态
Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\AMSI"

echo 查询AppLocker配置
Get-AppLockerPolicy -Effective | Format-List *

echo 查询LAPS情况
Get-AdmPwdPasswordSetting -Effective | Format-Table *

echo 查询PPL设置
Get-ProcessMitigation -System | Format-List *

echo 查询UAC设置
Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA"

echo 查询约束语言模式设置
Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Nls\Language" -Name "RestrictSystemChange"

$ExecutionContext.SessionState.LanguageMode
echo.

function Get-SystemInformation {
    Write-Host "系统版本："
    systeminfo | findstr /B /C:"OS 名称" /C:"OS 版本"
    Write-Host

    Write-Host "KB补丁："
    wmic qfe list brief
    Write-Host

    Write-Host "可能包含明文密码的文件："
    findstr /si password *.txt *.ini
    Write-Host

    Write-Host "SSH密钥："
    dir "$env:USERPROFILE\.ssh"
    Write-Host

    Write-Host "低权限用户可写的路径（不包括用户目录）："
    icacls C:\ /t | findstr /i "(F)" | findstr /v /i "$env:USERPROFILE"
    Write-Host

    Write-Host "PowerShell历史："
    dir "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt"
    Write-Host

    Write-Host "网络信息："
    ipconfig /all
    Write-Host

    Write-Host "安全控制措施："
    Write-Host "查询AMSI状态"
    Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\AMSI"

    Write-Host "查询AppLocker配置"
    Get-AppLockerPolicy -Effective | Format-List *

    Write-Host "查询LAPS情况"
    Get-AdmPwdPasswordSetting -Effective | Format-Table *

    Write-Host "查询PPL设置"
    Get-ProcessMitigation -System | Format-List *

    Write-Host "查询UAC设置"
    Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA"

    Write-Host "查询约束语言模式设置"
    Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Nls\Language" -Name "RestrictSystemChange"

    Write-Host $ExecutionContext.SessionState.LanguageMode
    Write-Host
}

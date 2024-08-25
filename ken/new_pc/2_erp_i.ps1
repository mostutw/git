# 設置 PowerShell 輸出和文件編碼為 UTF-8
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 檢查腳本是否以管理員身份運行
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # 重新啟動 PowerShell 並提升權限
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# 解壓縮文件設置
$zipFilePath = ".\MF2000.Zip"
$destinationPath = "D:\"

# 如果目的資料夾已存在，則刪除它
if (Test-Path -Path $destinationPath) {
    Remove-Item -Path $destinationPath -Recurse -Force
}

# 創建新資料夾
New-Item -ItemType Directory -Path $destinationPath

# 解壓縮文件
Expand-Archive -LiteralPath $zipFilePath -DestinationPath $destinationPath

Write-Output "解壓縮已成功完成到 $destinationPath"

# 複製 DLL 文件
Copy-Item -Path .\ERP\pb10dll\* -Destination C:\Windows\System32\ -Force -Recurse
Copy-Item -Path .\ERP\pb10dll\* -Destination C:\Windows\SysWOW64\ -Force -Recurse
Copy-Item -Path .\ERP\pb80dll\* -Destination C:\Windows\System32\ -Force -Recurse
Copy-Item -Path .\ERP\pb80dll\* -Destination C:\Windows\SysWOW64\ -Force -Recurse

Write-Output "DLL 文件已成功複製"

# 複製 Oracle 配置文件
$userName = $env:USERNAME
$sourceFile = ".\ERP\tnsnames.ora"
$destinationPath = "D:\app\$userName\product\11.2.0\client_1\network\admin\"

# 如果目的資料夾不存在，則創建它
if (-not (Test-Path -Path $destinationPath)) {
    New-Item -ItemType Directory -Path $destinationPath -Force
}

# 複製配置文件
Copy-Item -Path $sourceFile -Destination $destinationPath -Force

Write-Output "配置文件 tnsnames.ora 已成功複製到 $destinationPath"

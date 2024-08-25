# 目錄
$destinationPath = "D:\KTMFC"

# 不存在新增 
if (-not (Test-Path -Path $destinationPath)) {
    New-Item -ItemType Directory -Path $destinationPath -Force
}

# 複製
Copy-Item -Path .\MES\MES2_Update.exe -Destination D:\

# 執行 MES2_Update
 .\MES\MES2_Update.exe
# �ؿ�
$destinationPath = "D:\KTMFC"

# ���s�b�s�W 
if (-not (Test-Path -Path $destinationPath)) {
    New-Item -ItemType Directory -Path $destinationPath -Force
}

# �ƻs
Copy-Item -Path .\MES\MES2_Update.exe -Destination D:\

# ���� MES2_Update
 .\MES\MES2_Update.exe
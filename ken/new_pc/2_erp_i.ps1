# �]�m PowerShell ��X�M���s�X�� UTF-8
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# �ˬd�}���O�_�H�޲z�������B��
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # ���s�Ұ� PowerShell �ô����v��
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# �����Y���]�m
$zipFilePath = ".\MF2000.Zip"
$destinationPath = "D:\"

# �p�G�ت���Ƨ��w�s�b�A�h�R����
if (Test-Path -Path $destinationPath) {
    Remove-Item -Path $destinationPath -Recurse -Force
}

# �Ыطs��Ƨ�
New-Item -ItemType Directory -Path $destinationPath

# �����Y���
Expand-Archive -LiteralPath $zipFilePath -DestinationPath $destinationPath

Write-Output "�����Y�w���\������ $destinationPath"

# �ƻs DLL ���
Copy-Item -Path .\ERP\pb10dll\* -Destination C:\Windows\System32\ -Force -Recurse
Copy-Item -Path .\ERP\pb10dll\* -Destination C:\Windows\SysWOW64\ -Force -Recurse
Copy-Item -Path .\ERP\pb80dll\* -Destination C:\Windows\System32\ -Force -Recurse
Copy-Item -Path .\ERP\pb80dll\* -Destination C:\Windows\SysWOW64\ -Force -Recurse

Write-Output "DLL ���w���\�ƻs"

# �ƻs Oracle �t�m���
$userName = $env:USERNAME
$sourceFile = ".\ERP\tnsnames.ora"
$destinationPath = "D:\app\$userName\product\11.2.0\client_1\network\admin\"

# �p�G�ت���Ƨ����s�b�A�h�Ыإ�
if (-not (Test-Path -Path $destinationPath)) {
    New-Item -ItemType Directory -Path $destinationPath -Force
}

# �ƻs�t�m���
Copy-Item -Path $sourceFile -Destination $destinationPath -Force

Write-Output "�t�m��� tnsnames.ora �w���\�ƻs�� $destinationPath"

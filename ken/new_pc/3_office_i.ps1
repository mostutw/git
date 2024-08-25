# 定義 Office 安裝程序和配置文件的路徑
$setupPath = ".\SW_DVD5_Office_2010_W32_ChnTrad_MLF_X16-52131\setup.exe"
$configPath = ".\SW_DVD5_Office_2010_W32_ChnTrad_MLF_X16-52131\config.xml"
$configFile = "config.xml"

# 分別檢查安裝程序和配置文件是否存在
$setupExists = Test-Path -Path $setupPath
$configExists = Test-Path -Path $configPath

# 如果安裝程序和配置文件都存在，則以靜默模式運行安裝程序
if ($setupExists -and $configExists) {
    # 以管理員身份運行靜默安裝程序
    Start-Process -FilePath $setupPath -ArgumentList "/config $configFile" -Verb RunAs
    Write-Output "Office 2010 安裝程序已經以靜默模式並使用配置文件觸發。"
} else {
    if (-not $setupExists) {
        Write-Output "安裝程序文件不存在於指定路徑： $setupPath"
    }
    if (-not $configExists) {
        Write-Output "配置文件不存在於指定路徑： $configPath"
    }
}
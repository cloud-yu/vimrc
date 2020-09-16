# User profile

# Set encoding
# $OutputEncoding : terminal display encoding (终端显示编码)
# [Console]::OutputEncoding : pipline/stream saved encoding （文本管道流编码）
# $OutputEncoding 和 【Console]::OutputEncoding不一致时，使用 >/>>管道输出至文件时，
# 会出现编码错误，如$OutputEncoding默认为utf8，[Console]::OutputEncoding跟随系统，默认gb2312
# 在终端使用 echo "中文测试" > test.txt 命令写文件，文件内容为utf8编码，保存编码为gb2312，
# 默认打开会出现乱码
[System.Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding(65001)
$OutputEncoding = [System.Console]::OutputEncoding

# Create alias
# New-Alias -Name pip -Value pip

# Create function
function GetPipUpdateAll {
    [CmdletBinding()]
    param (

    )
    begin {
        $outdate = pip list -o
        Write-Output $outdate
    }
    process {
        $outdate | Select-Object -Skip 2 | ForEach-Object -Begin {} -Process { $output = $_.split(' ', [System.StringSplitOptions]::RemoveEmptyEntries) }, { Write-Output "update: $($output[0]) $($output[1]) -> $($output[2])" }, { pip install -U $($output[0]) } -End {}
    }
    end {
        Write-Output "update done."
    }
}

# Set default Location and HOME/~ variables

# $HomeDirectory = "E:\Users\yuyun"
# Set HOME variable force
# Set-Variable HOME $HomeDirectory -Force
# Set ~ shortcut
# (Get-PSProvider 'FileSystem').Home = $HOME
Set-Location $HOME

# Personlize console
$Host.UI.RawUI.WindowTitle = "Windows Powershell " + $Host.Version.Major;
Write-Host -ForegroundColor Green ("`n`t`t`t Welcome to Windows Powershell {0}`n`n" -f $host.Version.Major)

# set exec policy
# Set-ExecutionPolicy Unrestricted

# Disable the audio beep when user pressed backspace in the powershell console
Set-PSReadLineOption -BellStyle None
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox
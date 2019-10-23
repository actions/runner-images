(New-Object Net.WebClient).DownloadFile('https://www.microsoft.com/en-us/download/confirmation.aspx?id=4422', 'VC-Compiler-KB2519277.exe')
echo REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\NET Framework Setup\NDP\v4\Client\Version" "4.0.30319" /f 
echo REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\NET Framework Setup\NDP\v4\Full\Version" "4.0.30319" /f 
echo REG ADD "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /V %cd%\VC-Compiler-KB2519277.exe /T REG_SZ /D WIN7RTM /F

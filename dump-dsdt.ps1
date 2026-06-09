Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Acpi {
    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern int GetSystemFirmwareTable(uint Sig, uint ID, byte[] buf, uint sz);
}
"@
$buf = New-Object byte[] 65536
$sz = [Acpi]::GetSystemFirmwareTable(0x49504341, 0x54445344, $buf, 65536)
[IO.File]::WriteAllBytes("C:\Users\Public\DSDT.dat", $buf[0..($sz-1)])
Write-Host "Saved $sz bytes"

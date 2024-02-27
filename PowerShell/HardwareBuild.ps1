# Define VM configuration parameters
$VMConfigurations = @(
    @{
        Name     = "1IDM-JobServer1"
        CPUCount = 4
        MemoryMB = 2048
        OS       = "Windows 2022"
    },
    @{
        Name     = "1IDM-JobServer2"
        CPUCount = 4
        MemoryMB = 2048
        OS       = "Windows 2022"
    },
    @{
        Name     = "1IDM-WebServer1"
        CPUCount = 2
        MemoryMB = 1024
        OS       = "Windows 2022"
    },
    @{
        Name     = "1IDM-WebServer2"
        CPUCount = 2
        MemoryMB = 1024
        OS       = "Windows 2022"
    },
    @{
        Name     = "1IDM-SQLServer1"
        CPUCount = 2
        MemoryMB = 2048
        OS       = "Windows 2022"
    },
    @{
        Name     = "1IDM-SQLServer2"
        CPUCount = 2
        MemoryMB = 2048
        OS       = "Windows 2022"
    },
    @{
        Name     = "DC1"
        CPUCount = 2
        MemoryMB = 2048
        OS       = "Windows 2022"
        Domain   = "1idm.sandpit"
    },
    @{
        Name     = "DC2"
        CPUCount = 2
        MemoryMB = 2048
        OS       = "Windows 2022"
        Domain   = "1idm.sandpit"
    },
    @{
        Name     = "ChildDC1"
        CPUCount = 2
        MemoryMB = 2048
        OS       = "Windows 2022"
        Domain   = "child.1idm.sandpit"
    },
    @{
        Name     = "ChildDC2"
        CPUCount = 2
        MemoryMB = 2048
        OS       = "Windows 2022"
        Domain   = "child.1idm.sandpit"
    },
    @{
        Name     = "ExchangeOnPrem"
        CPUCount = 2
        MemoryMB = 4096
        OS       = "Windows 2022"
    }
)

# Create VMs
foreach ($VMConfig in $VMConfigurations) {
    New-VM -Name $VMConfig.Name -MemoryStartupBytes ($VMConfig.MemoryMB * 1MB) -Generation 2 -SwitchName "YourVirtualSwitchName"
    Set-VMProcessor -VMName $VMConfig.Name -Count $VMConfig.CPUCount
    Set-VM -VMName $VMConfig.Name -AutomaticStartAction StartIfRunning
    Set-VM -VMName $VMConfig.Name -AutomaticStopAction ShutDown
    Set-VM -VMName $VMConfig.Name -AutomaticStartDelay 0
    Set-VM -VMName $VMConfig.Name -AutomaticStartAction AlwaysStart
    Set-VM -VMName $VMConfig.Name -AutomaticStopAction ShutDown
    Set-VM -VMName $VMConfig.Name -AutomaticStartDelay 0
    Set-VM -VMName $VMConfig.Name -ProcessorCount $VMConfig.CPUCount
    Set-VM -VMName $VMConfig.Name -MemoryStartupBytes ($VMConfig.MemoryMB * 1MB)
    Set-VM -VMName $VMConfig.Name -NewVHDPath "C:\Hyper-V\$($VMConfig.Name)\$($VMConfig.Name).vhdx" -NewVHDSizeBytes 50GB
    Set-VM -VMName $VMConfig.Name -BootDevice VHD
    Set-VM -VMName $VMConfig.Name -Path "C:\Hyper-V\$($VMConfig.Name)"
    Set-VM -VMName $VMConfig.Name -AutomaticStartAction StartIfRunning
    Set-VM -VMName $VMConfig.Name -AutomaticStopAction ShutDown
    Set-VM -VMName $VMConfig.Name -AutomaticStartDelay 0
    Set-VM -VMName $VMConfig.Name -ProcessorCount $VMConfig.CPUCount
    Set-VM -VMName $VMConfig.Name -MemoryStartupBytes ($VMConfig.MemoryMB * 1MB)
    Set-VM -VMName $VMConfig.Name -NewVHDPath "C:\Hyper-V\$($VMConfig.Name)\$($VMConfig.Name).vhdx" -NewVHDSizeBytes 50GB
    Set-VM -VMName $VMConfig.Name -BootDevice VHD
    Set-VM -VMName $VMConfig.Name
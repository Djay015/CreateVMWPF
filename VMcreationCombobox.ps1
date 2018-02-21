Add-Type -AssemblyName System.Windows.Forms

#Additional form could be created if there are multiple vcenter instances
$VMCluster = "pdcvcenter.dpsk12.org"
Connect-VIServer -Server $VMCluster
Start-Sleep -Seconds 5

#Choose Datacenter Form
$FormDC = New-Object system.Windows.Forms.Form
$FormDC.Text = "Data Center Selection"
$FormDC.TopMost = $true
$FormDC.Width = 400
$FormDC.Height = 150

$DatacenterCB = New-Object system.windows.Forms.ComboBox
$DatacenterCB.Text = "Select a Datacenter"
$DatacenterCB.Width = 287
$DatacenterCB.Height = 20
$DatacenterCB.location = new-object system.drawing.point(22, 20)
$DatacenterCB.Font = "Microsoft Sans Serif,10"
$FormDC.controls.Add($DatacenterCB)

$Datacenterlist = (Get-Datacenter).Name

foreach ($Datacenter in $Datacenterlist) {
    $DatacenterCB.Items.Add($Datacenter)
}

#button DC
$CreateDC = New-Object system.windows.Forms.Button
$CreateDC.Text = "Select"
$CreateDC.Width = 100
$CreateDC.Height = 40
$CreateDC.location = new-object system.drawing.point(22, 50)
$CreateDC.Font = "Microsoft Sans Serif,10"
$FormDC.controls.Add($CreateDC)
$CreateDC.Add_Click( {$FormDC.Close()})

#Final DC Form related tasks
[void]$FormDC.ShowDialog()
$SelectedDC = $DatacenterCB.SelectedItem
$FormDC.Dispose()

#Main VM creation Form begin

#Main Form
$Form = New-Object system.Windows.Forms.Form
$Form.Text = "VM Creation"
$Form.TopMost = $true
$Form.Width = 450
$Form.Height = 600


#Hostname
$HostnameInputTB = New-Object system.windows.Forms.TextBox
$HostnameInputTB.Width = 287
$HostnameInputTB.Height = 20
$HostnameInputTB.location = new-object system.drawing.point(22, 30)
$HostnameInputTB.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($HostnameInputTB)

$HostnameInput = New-Object system.windows.Forms.Label
$HostnameInput.Text = "Hostname"
$HostnameInput.AutoSize = $true
$HostnameInput.Width = 25
$HostnameInput.Height = 10
$HostnameInput.location = new-object system.drawing.point(22, 10)
$HostnameInput.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($HostnameInput)

$Drivesize1 = New-Object system.windows.Forms.Label
$Drivesize1.Text = "Drive size (GB)"
$Drivesize1.AutoSize = $true
$Drivesize1.Width = 25
$Drivesize1.Height = 10
$Drivesize1.location = new-object system.drawing.point(22, 55)
$Drivesize1.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($Drivesize1)

$DrivesTB1 = New-Object system.windows.Forms.TextBox
$DrivesTB1.Width = 287
$DrivesTB1.Height = 20
$DrivesTB1.location = new-object system.drawing.point(22, 75)
$DrivesTB1.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($DrivesTB1)

$DriveSize2 = New-Object system.windows.Forms.Label
$DriveSize2.Text = "Drive size (GB)"
$DriveSize2.AutoSize = $true
$DriveSize2.Width = 25
$DriveSize2.Height = 10
$DriveSize2.location = new-object system.drawing.point(22, 102)
$DriveSize2.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($DriveSize2)

$DrivesTB2 = New-Object system.windows.Forms.TextBox
$DrivesTB2.Width = 287
$DrivesTB2.Height = 20
$DrivesTB2.location = new-object system.drawing.point(22, 125)
$DrivesTB2.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($DrivesTB2)

$DriveSize3 = New-Object system.windows.Forms.Label
$DriveSize3.Text = "Drive size (GB)"
$DriveSize3.AutoSize = $true
$DriveSize3.Width = 25
$DriveSize3.Height = 10
$DriveSize3.location = new-object system.drawing.point(22, 152)
$DriveSize3.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($DriveSize3)

$DrivesTB3 = New-Object system.windows.Forms.TextBox
$DrivesTB3.Width = 287
$DrivesTB3.Height = 20
$DrivesTB3.location = new-object system.drawing.point(22, 172)
$DrivesTB3.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($DrivesTB3)

$CPUCB = New-Object system.windows.Forms.ComboBox
$CPUCB.Text = "Select # of CPU Cores"
$CPUCB.Width = 287
$CPUCB.Height = 20
$CPUCB.location = new-object system.drawing.point(22, 200)
$CPUCB.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($CPUCB)
    
$CPUList = "1", "2", "3", "4", "5", "6", "7", "8"
    
foreach ($C in $CPUList) {
    $CPUCB.Items.Add($C)
}

$RamCB = New-Object system.windows.Forms.ComboBox
$RamCB.Text = "Select GB of RAM"
$RamCB.Width = 287
$RamCB.Height = 20
$RamCB.location = new-object system.drawing.point(22, 235)
$RamCB.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($RamCB)

$RAMList = "8", "12", "16", "20", "24", "28", "32", "48", "64"

foreach ($R in $RAMList) {
    $RamCB.Items.Add($R)
}

$IPaddress = New-Object system.windows.Forms.Label
$IPaddress.Text = "IP Address"
$IPaddress.AutoSize = $true
$IPaddress.Width = 25
$IPaddress.Height = 10
$IPaddress.location = new-object system.drawing.point(22, 265)
$IPaddress.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($IPaddress)

$IPaddressTB = New-Object system.windows.Forms.TextBox
$IPaddressTB.Width = 287
$IPaddressTB.Height = 20
$IPaddressTB.location = new-object system.drawing.point(22, 285)
$IPaddressTB.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($IPaddressTB)

$VLANCB = New-Object system.windows.Forms.ComboBox
$VLANCB.Text = "Select a Network"
$VLANCB.Width = 287
$VLANCB.Height = 20
$VLANCB.location = new-object system.drawing.point(22, 320)
$VLANCB.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($VLANCB)

$VLANList = (Get-VirtualPortGroup -Datacenter $SelectedDC | Where-Object name -like "Port*" | Sort-Object -Unique).Name

foreach ($VLAN in $VLANList) {
    $VLANCB.Items.Add($VLAN)
}

$TemplateCB = New-Object system.windows.Forms.ComboBox
$TemplateCB.Text = "Select a Template"
$TemplateCB.Width = 287
$TemplateCB.Height = 20
$TemplateCB.location = new-object system.drawing.point(22, 360)
$TemplateCB.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($TemplateCB)

$Templatelist = (Get-Template).Name

foreach ($Template in $Templatelist) {
    $TemplateCB.Items.Add($Template)
}

#Folder in Vcenter
$FolderCB = New-Object system.windows.Forms.ComboBox
$FolderCB.Text = "Select a folder for this VM"
$FolderCB.Width = 287
$FolderCB.Height = 20
$FolderCB.location = new-object system.drawing.point(22, 394)
$FolderCB.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($FolderCB)

$FolderList = (Get-folder -Type VM | Sort-Object Name).Name

foreach ($Folder in $FolderList) {
    $FolderCB.Items.Add($Folder)
}

$OSCustomizationCB = New-Object system.windows.Forms.ComboBox
$OSCustomizationCB.Text = "Select an OS Customization Spec"
$OSCustomizationCB.Width = 287
$OSCustomizationCB.Height = 20
$OSCustomizationCB.location = new-object system.drawing.point(22, 427)
$OSCustomizationCB.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($OSCustomizationCB)

#Gather info for OS Customization CB
$OSCustomize = (Get-OSCustomizationSpec).name

foreach ($OS in $OSCustomize) {
    $OSCustomizationCB.Items.Add($OS)
}

#Buttons
$Create = New-Object system.windows.Forms.Button
$Create.Text = "Create VM"
$Create.Width = 60
$Create.Height = 40
$Create.location = new-object system.drawing.point(127, 475)
$Create.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($Create)
$Create.Add_Click( {$Form.Close()})

#Final Form related tasks
[void]$Form.ShowDialog()
$SelectedTemplate = $TemplateCB.SelectedItem
$SelectedCustomization = $OSCustomizationCB.SelectedItem
$SelectedFolder = $FolderCB.SelectedItem
$SelectedVLAN = $VLANCB.SelectedItem
$SelectedRam = $RamCB.SelectedItem
$SelectedCPU = $CPUCB.SelectedItem
$HostnameInput = $HostnameInputTB.Text
$IPAddressInput = $IPaddressTB.Text
$DriveInput1 = $DrivesTB1.Text
$DriveInput2 = $DrivesTB2.Text
$DriveInput3 = $DrivesTB3.Text
$Form.Dispose()

#Begin Vm Creation tasks

#Alpha code below, use carefully
#Begin use of gathered information

$HostnameString = $HostnameInput.ToString()
$CPUString = $SelectedCPU.ToString()
$RAMString = $SelectedRam.ToString()

# Future use to loop through a list of servers
#Foreach($HostnameInput in $HostnameInputs){
# }#foreach host

New-VM -Name $HostnameString -Template $SelectedTemplate -OSCustomizationSpec $SelectedCustomization -VMHost `
'pdc-ucsvms01.dpsk12.org' -Datastore 'pdc-sdrs' -Location $SelectedFolder | Start-VM   

#Wait for VM creation and customization
Start-Sleep -Seconds 200

New-HardDisk -VM $HostnameString -CapacityGB $DriveInput1
New-HardDisk -VM $HostnameString -CapacityGB $DriveInput2
New-HardDisk -VM $HostnameString -CapacityGB $DriveInput3

#wait for drive creation before proceeding       
Start-Sleep -Seconds 20

#Configure Specific Resources after Vm creation
Set-VM -VM $HostnameString -MemoryGB $RAMString -NumCpu $CPUString -Confirm:$false

#credentials for further tasks
$vmLocalUser = "$HostnameString\administrator"

$vmLocalPWord = ConvertTo-SecureString -String "!LocalPassword" -AsPlainText -Force

$vmLocalCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $vmLocalUser, $vmLocalPWord
 
#Domain Creds

$JoinNewDomain = '$DomainUser = "DSuername"

                  $DomainPWord = ConvertTo-SecureString -String "Password" -AsPlainText -Force;

                  $DomainCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $DomainUser, $DomainPWord;

                  Add-Computer -DomainName dpsk12.org -Credential $DomainCredential -ErrorAction SilentlyContinue;

                  Start-Sleep -Seconds 20;

                  Shutdown /r /t 0'

Invoke-VMScript -VM $HostnameString -ScriptText "Set-DnsClientServerAddress -InterfaceAlias Ethernet0 -ServerAddresses ('10.0.200.53,10.0.200.54')" -GuestCredential $vmLocalCredential -ScriptType Powershell
Invoke-VMScript -VM $HostnameString -ScriptText "New-NetIPaddress -InterfaceAlias Ethernet0 -IPAddress $IPAddressInput -PrefixLength 24 -DefaultGateway 10.0.235.11" -GuestCredential $vmLocalCredential -ScriptType Powershell
Get-VM -Name $HostnameString | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName $SelectedVLAN -Confirm:$false
Invoke-VMScript -ScriptText $JoinNewDomain -VM $HostnameString -GuestCredential $vmLocalCredential

Start-Sleep -Seconds 10

#Needs a windows form created to assign drives to letters and setup
#Configure/Initialize Disks, Requires WMF5, must be logged in as SA


#################
### Constants ###
#################

$BLOATWARE = @{
    "Microsoft.ZuneMusic" = "Uninstalling Groove Music";
    "Microsoft.WindowsMaps" = "Uninstalling Maps";
    "Microsoft.WindowsCamera" = "Uninstalling Camera";
    "Microsoft.MSPaint" = "Uninstalling Paint 3D";
    "Microsoft.XboxApp" = "Uninstalling Xbox";
    "Microsoft.SkypeApp" = "Uninstalling Skype";
    "Microsoft.Messaging" = "Uninstalling Messaging";
    "Microsoft.MicrosoftSolitaireCollection" = "Uninstalling Solitaire";
    "Microsoft.People" = "Uninstalling People";
    "Microsoft.GetHelp" = "Uninstalling Get Help";
    "Microsoft.GetStarted" = "Uninstalling Get Started";
    "Microsoft.Microsoft3DViewer" = "Uninstalling 3D Viewer";
    "Microsoft.WindowsSoundRecorder" = "Uninstalling Sound Recorder";
    "Microsoft.BingWeather" = "Uninstalling Weather";
    "Microsoft.BingSports" = "Uninstalling Sports";
    "Microsoft.BingNews" = "Uninstalling News";
    "Microsoft.OneConnect" = "Uninstalling One Connect";
    "Microsoft.SurfaceHub" = "Uninstalling Surface Hub";
    "Microsoft.MicrosoftOfficeHub" = "Uninstalling Office Hub";
    "Microsoft.WindowsFeedbackHub" = "Uninstalling Feedback Hub";
    "Microsoft.WindowsAlarms" = "Uninstalling Alarms";
    "microsoft.windowscommunicationsapps" = "Uninstalling Mail";
    "Microsoft.Windows.Photos" = "Uninstalling Photos";
    "Microsoft.Office.Desktop" = "Uninstalling Office";
    "Microsoft.Office.OneNote" = "Uninstalling OneNote";  
}

$FRAMEWORKS = @{
    "dotnet4.7.1" = "Installing DotNet Framework 4.7.1";
    "dotnetcore-sdk" = "Installing DotNet Core";
};

$DEVTOOLS = @{
    "nodejs" = "Installing NodeJS";
    "yarn" = "Installing Yarn";
    "git" = "Installing Git"; 
};

$APPLICATIONS = @{
    "7zip.install" = "Installing 7zip";
    "vim" = "Installing Vim";
    "hyper" = "Installing Hyper";
    "vscode" = "Installing VSCode";
    "jetbrains-rider" = "Installing Rider";
    "insomnia-rest-api-client" = "Installing Insomnia";
    "onenote" = "Installing OneNote";
    "1password" = "Installing 1Password";
    "keypirinha" = "Installing Keypirinha";
    "googlechrome" = "Installing Chrome";
};

$FONTS = @{
    "firacode" = "Installing Fira Code font";
    "robotofonts" = "Installing Roboto font";
}

########################
### Helper Functions ###
########################

Function Write-Section {
    Param (
        [String] $message,
        [ScriptBlock] $block
    ) 

    Write-Host $message -ForegroundColor DarkBlue;
    $block.Invoke();
    Write-Host; 
}

Function Write-SectionMessage {
    Param(
        [String] $message
    )

    Write-Host "`t$message" -ForegroundColor Cyan;
}

Function Add-RegistryKey {
    Param(
        [string] $Path,
        [object] $Name
    )

    New-Item -Path $Path -Name $Name -ErrorAction SilentlyContinue | Out-Null;
}

Function Update-RegistryKey {
    Param(
        [string] $Path,
        [string] $Name,
        [object] $Value
    )

    If (Test-Path -LiteralPath $Path) {
        Set-ItemProperty -LiteralPath $Path -Name $Name -Value $Value -ErrorAction SilentlyContinue | Out-Null;
    }
}

Function Remove-RegistryKey {
    Param(
        [string] $Path
    )

    If (Test-Path -LiteralPath $Path) {
        Remove-Item -LiteralPath $Path -Confirm $False -ErrorAction SilentlyContinue;
    }
}

#############################
### Main script execution ###
#############################

Write-Section "Initializing" {
    Set-ExecutionPolicy Bypass -Scope Process -Force;
    New-PSDrive -Name "HKU" -PSProvider "Registry" -Root "HKEY_USERS";
    New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT";
}

Write-Section "Installing package managers" {
    Write-SectionMessage "Installing Chocolatey";
    (New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1') | Invoke-Expression;

    Write-SectionMessage "Installing PackageManagement";
    Install-Module PowerShellGet;
}

Write-Section "Installing frameworks and devtools" {
    $FRAMEWORKS.GetEnumerator() | ForEach-Object {
        Write-SectionMessage "$($_.Value)";
        Invoke-Expression "choco install $($_.Name) -y";
    };

    $DEVTOOLS.Keys | ForEach-Object {
        Write-SectionMessage "$($_.Value)";
        Invoke-Expression "choco install $($_.Name) -y";
    };
}

Write-Section "Installing applications" {
    $APPLICATIONS.Keys | ForEach-Object {
        Write-SectionMessage "$($_.Value)";
        Invoke-Expression "choco install $($_.Name) -y";
    };
}

Write-Section "Installing fonts" {
    $FONTS.Keys | ForEach-Object {
        Write-SectionMessage "$($_.Value)";
        Invoke-Expression "choco install $($_.Name) -y";
    };
}

Write-Section "Updating system settings" {
    Write-SectionMessage "Disabling Cortana";
    Update-RegistryKey -Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0;

    Write-SectionMessage "Disabling Action Center";
    Update-RegistryKey -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Value 1;

    Write-SectionMessage "Disabling cloud downloads";
    Update-RegistryKey -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value 1;

    Write-SectionMessage "Disabling Aero Shake";
    Update-RegistryKey -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "NoWindowMinimizingShortcuts" -Value 1;

    Write-SectionMessage "Disabling images in Logon screen";
    Update-RegistryKey -Path "HKLM:\Software\Policies\Microsoft\Windows\System" -Name "DisableLogonBackgroundImage" -Value 1;

    Write-SectionMessage "Disabling bloatware";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Value 0;
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Value 0;
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Value 0;
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Value 0;
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Value 0;

    Write-SectionMessage "Disabling suggestions panel";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0;
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Value 0;    
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Value 0;
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Value 0;
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Value 0;
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value 0;

    Write-SectionMessage "Disabling My People suggestions panel";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-314563Enabled" -Value 0;

    Write-SectionMessage "Disabling locally relevant content";
    Update-RegistryKey -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Value 1;

    Write-SectionMessage "Disabling user activity tracking";
    Update-RegistryKey -Path "HKLM:\Software\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Value 0;
    Update-RegistryKey -Path "HKLM:\Software\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Value 0;
    Update-RegistryKey -Path "HKLM:\Software\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value 0;
}

Write-Section "Updating desktop view" {
    Write-SectionMessage "Adding Desktop icon";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Value 1;
}

Write-Section "Updating file explorer settings" {
    Write-SectionMessage "Show file extensions in File Explorer";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0;

    Write-SectionMessage "Show drives with empty media in File Explorer";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideDrivesWithNoMedia" -Value 0;

    Write-SectionMessage "Remove checkbox from items in File Explorer";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AutoCheckSelect" -Value 0;

    Write-SectionMessage "Open File Explorer in This PC";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1;

    Write-SectionMessage "Minimize the ribbon menu in File Explorer";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Ribbon" -Name "MinimizedStateTabletModeOff" -Value 1;

    Write-SectionMessage "Hide recently used files in Quick Access";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Value 0;

    Write-SectionMessage "Hide fequently used folders in Quick Access";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Value 0;

    Write-SectionMessage "Removing Desktop folder from File Explorer";
    Update-RegistryKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" -Name "ThisPCPolicy" -Value "Hide";

    Write-SectionMessage "Removing Documents folder from File Explorer";
    Update-RegistryKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" -Name "ThisPCPolicy" -Value "Hide";

    Write-SectionMessage "Removing Downloads folder from File Explorer";
    Update-RegistryKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" -Name "ThisPCPolicy" -Value "Hide";

    Write-SectionMessage "Removing Music folder from File Explorer";
    Update-RegistryKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" -Name "ThisPCPolicy" -Value "Hide";

    Write-SectionMessage "Removing Pictures folder from File Explorer";
    Update-RegistryKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" -Name "ThisPCPolicy" -Value "Hide";

    Write-SectionMessage "Removing Videos folder from File Explorer";
    Update-RegistryKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" -Name "ThisPCPolicy" -Value "Hide";
}

Write-Section "Updating taskbar settings" {
    Write-SectionMessage "Reduce size of Taskbar";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSmallIcons" -Value 1;

    Write-SectionMessage "Remove Taskbar animations";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Value 0;

    Write-SectionMessage "Disable Always show all icons in the notification area";
    Update-RegistryKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoAutoTrayNotify" -Value 0;

    Write-SectionMessage "Remove People band";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value 0;

    Write-SectionMessage "Remove Windows Ink Workspace";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" -Name "PenWorkspaceButtonDesiredVisibility" -Value 0;

    Write-SectionMessage "Remove Touchpad";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Touchpad" -Name "TouchpadDesiredVisibility" -Value 0;

    Write-SectionMessage "Remove Search box";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0;

    Write-SectionMessage "Remove Task view";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\MultiTaskingView\AllUpView" -Name "Enabled" -Value 0;
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 0; 

    Write-SectionMessage "Remove Touch Keyboard";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\TabletTip\1.7" -Name "TipbandDesiredVisibility" -Value 0;

    Write-SectionMessage "Remove Volumne"
    Update-RegistryKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAVolume" -Value 1;
}

Write-Section "Updating touchpad settings" {
    Write-SectionMessage "Disabling tap twice and drag to multi-select";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name "TapAndDrag" -Value 0;
    
    Write-SectionMessage "Disabling right click";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name "RightClickZoneEnabled" -Value 0;

    Write-SectionMessage "Disabling three finders tap";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name "ThreeFingerTapEnabled" -Value 0;

    Write-SectionMessage "Disabling four finders slide";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name "FourFingerSlideEnabled" -Value 0;

    Write-SectionMessage "Disabling four finders tap";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name "FourFingerTapEnabled" -Value 0;
}

Write-Section "Updating start menu" {
    Write-SectionMessage "Disabling Show app list in start menu";
    Update-RegistryKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoStartMenuMorePrograms" -Value 2;

    Write-SectionMessage "Disabling Show recently added apps";    
    Add-RegistryKey -Path "HKLM:\Software\Policies\Microsoft\Windows\Explorer";
    Update-RegistryKey -Path "HKLM:\Software\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Value 1;

    Write-SectionMessage "Disabling Show most used apps";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Value 0;

    Write-SectionMessage "Disabling Show recently opened items in Jump Lists";
    Update-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Value 0;    

    Write-SectionMessage "Disabling Recent docs history";
    Update-RegistryKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoRecentDocsHistory" -Value 1;
}

Write-Section "Updating context menu" {
    Write-SectionMessage "Updating Hyper context menu";
    Update-RegistryKey -Path "HKCR:\Directory\Background\shell\Hyper" -Name "(Default)" -Value "Open with &Hyper";

    Write-SectionMessage "Removing Scan with Windows Defender";
    Remove-RegistryKey -Path "HKCR:\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}";

    Write-SectionMessage "Removing Share";
    Remove-RegistryKey -PAth "HKCR:\*\shellex\ContextMenuHandlers\ModernSharing";

    Write-SectionMessage "Removing Open with Vim";
    Remove-RegistryKey -Path "HKCR:\*\shell\Vim";
    Remove-RegistryKey -Path "HKCR:\*\shellex\ContextMenuHandlers\gvim";

    Write-SectionMessage "Removing Git GUI Here";
    Remove-RegistryKey -Path "HKCR:\Directory\Shell\git_gui";
    Remove-RegistryKey -Path "HKCR:\Directory\Background\shell\git_gui";

    Write-SectionMessage "Removing Git Bash Here";
    Remove-RegistryKey -Path "HKCR:\Directory\Shell\git_shell";
    Remove-RegistryKey -Path "HKCR:\Directory\Background\shell\git_shell";

    Write-SectionMessage "Adding Open with Notepad";
    Push-Location;
    Set-Location -LiteralPath "HKCR:\*\shell";
    Add-RegistryKey -Path . -Name "Notepad";
    Add-RegistryKey -Path ".\Notepad" -Name "command";
    Pop-Location;

    Update-RegistryKey -Path "HKCR:\*\shell\Notepad" -Name "(Default)" -Value "Open with &Notepad";
    Update-RegistryKey -Path "HKCR:\*\shell\Notepad" -Name "Icon" -Value "C:\Windows\Notepad.exe";
    Update-RegistryKey -Path "HKCR:\*\shell\Notepad\command" -Name "(Default)" -Value "C:\Windows\Notepad.exe %1";
}

Write-Section "Updating display settings" {
    Write-SectionMessage "Disabling Adaptive Brightness for Balanced power plan (plugged in)";
    powercfg -setacvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 7516b95f-f776-4464-8c53-06167f40cc99 FBD9AA66-9553-4097-BA44-ED6E9D65EAB8 0 | Out-Null;

    Write-SectionMessage "Disabling Adaptive Brightness for Balanced power plan (on battery)";
    powercfg -setdcvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 7516b95f-f776-4464-8c53-06167f40cc99 FBD9AA66-9553-4097-BA44-ED6E9D65EAB8 0 | Out-Null;

    Write-SectionMessage "Disabling Adaptive Brightness for High Performance power plan (plugged in)";
    powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 FBD9AA66-9553-4097-BA44-ED6E9D65EAB8 0 | Out-Null;

    Write-SectionMessage "Disabling Adaptive Brightness for High Performance power plan (on battery)";
    powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 FBD9AA66-9553-4097-BA44-ED6E9D65EAB8 0 | Out-Null;
}

Write-Section "Uninstalling UWP applications" {
    $BLOATWARE.GetEnumerator() | ForEach-Object {
        Write-SectionMessage "$($_.Value)";
        Invoke-Expression "Get-AppXPackage $($_.Name) | Remove-AppXPackage";
    };
}

Write-Section "Uninstalling Desktop applications" {
    taskkill.exe /F /IM "OneDrive.exe" | Out-Null;
    taskkill.exe /F /IM "explorer.exe" | Out-Null;

    If (Test-Path "$env:systemroot\System32\OneDriveSetup.exe") {
        Invoke-Expression "$env:systemroot\System32\OneDriveSetup.exe /uninstall" | Out-Null;
    }

    If (Test-Path "$env:systemroot\SysWOW64\OneDriveSetup.exe") {
        Invoke-Expression "$env:systemroot\SysWOW64\OneDriveSetup.exe /uninstall" | Out-Null;
    }

    Add-RegistryKey -Path "HKLM:\Software\Wow6432Node\Policies\Microsoft\Windows" -Name "OneDrive";
    Update-RegistryKey -Path "HKLM:\Software\Wow6432Node\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value 1;

    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:localappdata\Microsoft\OneDrive" | Out-Null;
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:programdata\Microsoft OneDrive" | Out-Null;
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "C:\OneDriveTemp" | Out-Null;

    Write-SectionMessage "Removing OneDrive from Explorer sidebar";
    Update-RegistryKey -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Name "System.IsPinnedToNameSpaceTree" -Value 0;

    Remove-RegistryKey -Path "HKU:\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Run" -NAme "OneDriveSetup" | Out-Null;
    Remove-RegistryKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "OneDriveSetup" | Out-Null;

    Remove-Item -Force -ErrorAction SilentlyContinue "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk";

    Get-ScheduledTask -TaskPath '\' -TaskName 'OneDrive*' -ea SilentlyContinue | ForEach-Object { Unregister-ScheduledTask $_ -Confirm $False } | Out-Null;

    Start-Process "explorer.exe" | Out-Null;

    Disable-WindowsOptionalFeature -FeatureName Internet-Explorer-Optional-amd64 –Online;
    Disable-WindowsOptionalFeature –FeatureName WindowsMediaPlayer -Online;
}

Write-Section "Finalizing" {
    Remove-PSDrive -Name "HKU";
    Remove-PSDrive -Name "HKCR";
}
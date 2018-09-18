#################
### Constants ###
#################

$BLOATWARE = @{
    "*Microsoft.3DBuilder*" = "Uninstalling 3D Builder";
    "*Microsoft.DesktopAppInstaller*" = "Uninstalling Desktop App Installer";
    "*Microsoft.ZuneMusic*" = "Uninstalling Groove Music";
    "*Microsoft.WindowsMaps*" = "Uninstalling Maps";
    "*Microsoft.WindowsCamera*" = "Uninstalling Camera";
    "*Microsoft.MSPaint*" = "Uninstalling Paint 3D";
    "*Microsoft.XboxApp*" = "Uninstalling Xbox";
    "*Microsoft.SkypeApp*" = "Uninstalling Skype";
    "*Microsoft.Messaging*" = "Uninstalling Messaging";
    "*Microsoft.People*" = "Uninstalling People";
    "*Microsoft.GetHelp*" = "Uninstalling Get Help";
    "*Microsoft.GetStarted*" = "Uninstalling Get Started";
    "*Microsoft.Microsoft3DViewer*" = "Uninstalling 3D Viewer";
    "*Microsoft.WindowsSoundRecorder*" = "Uninstalling Sound Recorder";
    "*Microsoft.BingSports*" = "Uninstalling Sports";
    "*Microsoft.BingNews*" = "Uninstalling News";
    "*Microsoft.OneConnect*" = "Uninstalling One Connect";
    "*Microsoft.SurfaceHub*" = "Uninstalling Surface Hub";
    "*Microsoft.MicrosoftOfficeHub*" = "Uninstalling Office Hub";
    "*Microsoft.WindowsFeedbackHub*" = "Uninstalling Feedback Hub";
    "*microsoft.windowscommunicationsapps*" = "Uninstalling Mail";
    "*Microsoft.Office.Desktop*" = "Uninstalling Office";  
    "*Microsoft.XboxSpeechToTextOverlay*" = "Uninstalling Xbox Speech to Text Overlay";
    "*Microsoft.XboxGameOverlay*" = "Uninstalling Xbox Game Overlay";
    "*Microsoft.XboxGamingOverlay*" = "Uninstalling Xbox Gaming Overlay";
    "*Microsoft.XboxIdentityProvider*" = "Uninstalling Xbox Identity Provider";
    "*Microsoft.Xbox.TCUI*" = "Uninstalling Xbox TCUI";
    "*Microsoft.Advertising.Xaml*" = "Uninstalling Advertising Xaml";
    "*Microsoft.Wallet*" = "Uninstalling Wallet";
    "*Microsoft.Print3D*" = "Uninstalling Print3D";
    "*Microsoft.WindowsAlarms*" = "Uninstalling Alarms";
    "*Microsoft.MicrosoftStickyNotes*" = "Uninstalling Sticky Notes";
    "*DolbyLaboratories.DolbyAccess*" = "Uninstalling Dolby Access";
    "*Microsoft.MicrosoftSolitaireCollection*" = "Uninstalling Solitaire";
    "*king.com*" = "Uninstalling Candy Crush";
    "*Twitter*" = "Uninstalling Twitter";
    "*Facebook*" = "Uninstalling Facebook";
    "*Pandora*" = "Uninstalling Pandora";
    "*Shazam*" = "Uninstalling Shazam";
    "*iHeartRadio*" = "Uninstalling iHeartRadio";
    "*Netflix*" = "Uninstalling Netflix";
    "*Wunderlist*" = "Uninstalling Wunderlist";
    "*DrawboardPDF*" = "Uninstalling DrawboardPDF";
    "*PhotoStudio*" = "Uninstalling PhotoStudio";
    "*FarmVille*" = "Uninstalling FarmVille";
    "*WinZip*" = "Uninstalling WinZip";
    "*TuneInRadio*" = "Uninstalling TuneInRadio";
    "*Spotify*" = "Uninstalling Spotify";
    "*AutodeskSketchBook*" = "Uninstalling AutodeskSketchBook";
    "*Duolingo*" = "Uninstalling Duolingo";
    "*EclipseManager*" = "Uninstalling EclipseManager";
    "*MarchofEmpires*" = "Uninstalling March of Empires";    
    "*GAMELOFTSA*" = "Uninstalling Games from GAMELOFTSA";
    "*flaregamesGmbH*" = "Uninstalling Games from flaregamesGmbH";
    "*Playtika*" = "Uninstalling Games from Playtika";
    "*KeeperSecurityInc*" = "Uninstalling Apps from KeeperSecurityInc";
    "*ThumbmunkeysLtd*" = "Uninstalling Apps from ThumbmunkeysLtd";
    "*XINGAG*" = "Uninstalling Apps from XINGAG";
    "*ActiproSoftwareLLC*" = "Uninstalling Apps from ActiproSoftwareLLC";
    "*Disney*" = "Uninstalling Apps from Disney";    
    "*828B5831.HiddenCityMysteryofShadows*" = "Uninstalling Hidden City Mistery of Shadows";
}

$FRAMEWORKS = @{
    "dotnet4.7.1" = "Installing DotNet Framework 4.7.1";
    "dotnetcore-sdk" = "Installing DotNet Core";
};

$DEVTOOLS = @{
    "nodejs" = "Installing NodeJS";
    "yarn" = "Installing Yarn";
    "git.install  --params '/NoShellIntegration /SChannel'" = "Installing Git"; 
};

$APPLICATIONS = @{
    "7zip.install" = "Installing 7zip";
    "vim" = "Installing Vim";
    "hyper" = "Installing Hyper";
    "vscode" = "Installing VSCode";
    "dotpeek" = "Installing DotPeek";
    "jetbrains-rider" = "Installing Rider";
    "insomnia-rest-api-client" = "Installing Insomnia";
    "jing" = "Installing Jing";
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

    Write-Host $message -ForegroundColor Yellow;
    $block.Invoke();
    Write-Host; 
}

Function Write-SectionMessage {
    Param(
        [String] $message
    )
    Write-Host
    Write-Host "-> $message" -ForegroundColor Cyan;
}

#############################
### Main script execution ###
#############################

Write-Section "Installing package managers" {
    Write-SectionMessage "Installing Chocolatey";
    (New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1') | Invoke-Expression | Out-Null;

    Write-SectionMessage "Installing PackageManagement";
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force | Out-Null;
    Install-Module PowerShellGet -Confirm:$False -Force | Out-Null;
}

Write-Section "Installing frameworks and devtools" {
    $FRAMEWORKS.GetEnumerator() | ForEach-Object {
        Write-SectionMessage "$($_.Value)";
        choco install $($_.Name) -y -r --no-progress --accept-license --ignore-checksum;
    };

    $DEVTOOLS.GetEnumerator() | ForEach-Object {
        Write-SectionMessage "$($_.Value)";
        choco install $($_.Name) -y -r --no-progress --accept-license --ignore-checksum;
    };
}

Write-Section "Installing applications" {
    $APPLICATIONS.GetEnumerator() | ForEach-Object {
        Write-SectionMessage "$($_.Value)";
        choco install $($_.Name) -y -r --no-progress --accept-license --ignore-checksum;
    };
}

Write-Section "Installing fonts" {
    $FONTS.GetEnumerator() | ForEach-Object {
        Write-SectionMessage "$($_.Value)";
        choco install $($_.Name) -y -r --no-progress --accept-license --ignore-checksum;
    };
}

Write-Section "Updating system settings" {
    Write-SectionMessage "Enabling secure sign in";
    reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DisableCAD" /d 0 /t REG_DWORD /f;
    reg delete "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DisableCAD" /f;
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableCAD" /f;
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableCAD" /f;

    Write-SectionMessage "Disabling Cortana";
    reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Disabling Action Center";
    reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /d 1 /t REG_DWORD /f;

    Write-SectionMessage "Disabling cloud downloads";
    reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /d 1 /t REG_DWORD /f;

    Write-SectionMessage "Disabling windows notifications";
    reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /d 1 /t REG_DWORD /f;

    Write-SectionMessage "Turn off notification on lock screen";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Disabling Aero Shake";
    reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "NoWindowMinimizingShortcuts" /d 1 /t REG_DWORD /f;

    Write-SectionMessage "Disabling images in Logon screen";
    reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "DisableLogonBackgroundImage" /d 1 /t REG_DWORD /f;

    Write-SectionMessage "Disabling bloatware";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /d 0 /t REG_DWORD /f;
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /d 0 /t REG_DWORD /f;
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /d 0 /t REG_DWORD /f;
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /d 0 /t REG_DWORD /f;
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Disabling suggestions panel";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /d 0 /t REG_DWORD /f;
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /d 0 /t REG_DWORD /f;
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /d 0 /t REG_DWORD /f;
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /d 0 /t REG_DWORD /f;
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /d 0 /t REG_DWORD /f;
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Disabling My People suggestions panel";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314563Enabled" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Disabling locally relevant content";
    reg add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /d 1 /t REG_DWORD /f;

    Write-SectionMessage "Disabling user activity tracking";
    reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /d 0 /t REG_DWORD /f;
    reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /d 0 /t REG_DWORD /f;
    reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /d 0 /t REG_DWORD /f;
}

Write-Section "Updating desktop view" {
    Write-SectionMessage "Adding Desktop icon";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /d 1 /t REG_DWORD /f;
}

Write-Section "Updating file explorer settings" {
    Write-SectionMessage "Show file extensions in File Explorer";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Show drives with empty media in File Explorer";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideDrivesWithNoMedia" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Remove checkbox from items in File Explorer";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "AutoCheckSelect" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Open File Explorer in This PC";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /d 1 /t REG_DWORD /f;

    Write-SectionMessage "Minimize the ribbon menu in File Explorer";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Ribbon" /v "MinimizedStateTabletModeOff" /d 1 /t REG_DWORD /f;

    Write-SectionMessage "Hide recently used files in Quick Access";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Hide fequently used folders in Quick Access";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Removing 3D Objects folder from File Explorer";
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f;
    reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f;

    Write-SectionMessage "Removing Desktop folder from File Explorer";
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /d "Hide" /t REG_SZ /f;
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f;
    reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f;

    Write-SectionMessage "Removing Documents folder from File Explorer";
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /d "Hide" /t REG_SZ /f;
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f;
    reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f;
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f;
    reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f;

    Write-SectionMessage "Removing Downloads folder from File Explorer";
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /d "Hide" /t REG_SZ /f;
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f;
    reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f;
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f;
    reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f;

    Write-SectionMessage "Removing Music folder from File Explorer";
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /d "Hide" /t REG_SZ /f;
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f;
    reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f;
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f;
    reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f;

    Write-SectionMessage "Removing Pictures folder from File Explorer";
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /d "Hide" /t REG_SZ /f;
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f;
    reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f;
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f;
    reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f;

    Write-SectionMessage "Removing Videos folder from File Explorer";
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /d "Hide" /t REG_SZ /f;
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f;
    reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f;
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f;
    reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f;

    Write-SectionMessage "Removing Network from File Explorer";
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /f;
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}" /f;

    Write-SectionMessage "Removing OneDrive from File Explorer";
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f;

    # In case you want to hide the quick access folders
    # Write-SectionMessage "Removing Quick Access from File Explorer";
    # reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "HubMode" /d 1 /t REG_DWORD /f;
}

Write-Section "Updating taskbar settings" {
    Write-SectionMessage "Reduce size of Taskbar";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSmallIcons" /d 1 /t REG_DWORD /f;

    Write-SectionMessage "Remove Taskbar animations";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Disable Always show all icons in the notification area";
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoAutoTrayNotify" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Remove People band";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Remove Windows Ink Workspace";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" /v "PenWorkspaceButtonDesiredVisibility" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Remove Touchpad";
    reg add "HKCU\Software\Microsoft\Touchpad" /v "TouchpadDesiredVisibility" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Remove Search box";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Remove Task view";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\MultiTaskingView\AllUpView" /v "Enabled" /d 0 /t REG_DWORD /f;
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Remove Touch Keyboard";
    reg add "HKCU\Software\Microsoft\TabletTip\1.7" /v "TipbandDesiredVisibility" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Remove Volumne";
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAVolume" /d 1 /t REG_DWORD /f;

    Write-SectionMessage "Remove Pin Apps";
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /f;
    Remove-Item -Path "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar *";

    Write-SectionMessage "Remove Bluetooth Icon";
    reg add "HKCU\Control Panel\Bluetooth" /v "Notification Area Icon" /d 0  /t REG_DWORD /f;;
}

Write-Section "Updating touchpad settings" {
    Write-SectionMessage "Disabling tap twice and drag to multi-select";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" /v "TapAndDrag" /d 0 /t REG_DWORD /f;
    
    Write-SectionMessage "Disabling right click";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" /v "RightClickZoneEnabled" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Disabling three fingers tap";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" /v "ThreeFingerTapEnabled" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Disabling four fingers slide";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" /v "FourFingerSlideEnabled" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Disabling four fingers tap";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" /v "FourFingerTapEnabled" /d 0 /t REG_DWORD /f;
}

Write-Section "Updating start menu" {
    Write-SectionMessage "Disabling Show app list in start menu";
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoStartMenuMorePrograms" /d 2 /t REG_DWORD /f;

    Write-SectionMessage "Disabling Show recently added apps";    
    reg add "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "HideRecentlyAddedApps" /d 1 /t REG_DWORD /f;

    Write-SectionMessage "Disabling Show most used apps";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Disabling Show recently opened items in Jump Lists";
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /d 0 /t REG_DWORD /f;

    Write-SectionMessage "Disabling Recent docs history";
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoRecentDocsHistory" /d 1 /t REG_DWORD /f;
}

Write-Section "Updating context menu" {
    Write-SectionMessage "Updating Hyper context menu";
    reg add "HKCR\Directory\Background\shell\Hyper" /ve -d "Open with &Hyper" /t REG_SZ /f;

    Write-SectionMessage "Removing Scan with Windows Defender";
    reg delete "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f;

    Write-SectionMessage "Sent To";
    reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo" /f;

    Write-SectionMessage "Removing Share";
    reg delete "HKCR\*\shellex\ContextMenuHandlers\Sharing" /f;
    reg delete "HKCR\Directory\shellex\ContextMenuHandlers\Sharing" /f;
    reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\Sharing" /f;
    reg delete "HKCR\Drive\shellex\ContextMenuHandlers\Sharing" /f;
    reg delete "HKCR\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing" /f;
    reg delete "HKCR\UserLibraryFolder\shellex\ContextMenuHandlers\Sharing" /f;
    reg delete "HKCR\Directory\shellex\PropertySheetHandlers\Sharing" /f;
    reg delete "HKCR\Drive\shellex\PropertySheetHandlers\Sharing" /f;
    
    Write-SectionMessage "Removing Modern Share";
    reg delete "HKCR\*\shellex\ContextMenuHandlers\ModernSharing" /f;

    Write-SectionMessage "Removing Git GUI Here";
    reg delete "HKCR\Directory\Shell\git_gui" /f;
    reg delete "HKCR\Directory\Background\shell\git_gui" /f;

    Write-SectionMessage "Removing Git Bash Here";
    reg delete "HKCR\Directory\shell\git_shell" /f;    
    reg delete "HKCR\Directory\Background\shell\git_shell" /f;    

    Write-SectionMessage "Removing Open with Vim";
    reg delete "HKCR\*\shell\Vim" /f;
    reg delete "HKCR\*\shell\ContextMenuHandlers\gvim" /f;    

    Write-SectionMessage "Adding Open with Notepad";
    reg add "HKCR\*\shell\Notepad" /ve /d "Open with &Notepad" /t REG_EXPAND_SZ /f 
    reg add "HKCR\*\shell\Notepad" /v "Icon" /d "$env:systemroot\System32\Notepad.exe" /t REG_EXPAND_SZ /f 
    reg add "HKCR\*\shell\Notepad\command" /ve /d "C:\Windows\Notepad.exe %1" /t REG_EXPAND_SZ /f;    
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

    Write-SectionMessage "Change lid closed action to do nothing (plugged in)";
    reg add "HKLM\System\CurrentControlSet\Control\Power\PowerSettings\4f971e89-eebd-4455-a8de-9e59040e7347\5ca83367-6e45-459f-a27b-476b1d01c936" /v "Attributes" /d 0 /t REG_DWORD /f;
}

Write-Section "Uninstalling UWP applications" {
    $BLOATWARE.GetEnumerator() | ForEach-Object {
        Write-SectionMessage "$($_.Value)";
        Get-AppXPackage $($_.Name) -allusers | Remove-AppXPackage -ErrorAction SilentlyContinue;
        Get-AppXProvisionedPackage -Online | Where-Object DisplayName -Like $($_.Name) | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue;
    };
}

Write-Section "Uninstalling Desktop applications" {
    Disable-WindowsOptionalFeature -FeatureName Internet-Explorer-Optional-amd64 -Online -NoRestart;
    Disable-WindowsOptionalFeature -FeatureName WindowsMediaPlayer -Online -NoRestart;

    Remove-Item -Force -ErrorAction SilentlyContinue "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk";

    taskkill.exe /F /IM "OneDrive.exe" | Out-Null;
    taskkill.exe /F /IM "explorer.exe" | Out-Null;

    If (Test-Path "$env:systemroot\System32\OneDriveSetup.exe") {
        Invoke-Expression "$env:systemroot\System32\OneDriveSetup.exe /uninstall" | Out-Null;
    }

    If (Test-Path "$env:systemroot\SysWOW64\OneDriveSetup.exe") {
        Invoke-Expression "$env:systemroot\SysWOW64\OneDriveSetup.exe /uninstall" | Out-Null;
    }

    reg delete "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f | Out-Null;
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f | Out-Null;

    reg delete "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f | Out-Null;
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f | Out-Null;

    reg add "HKLM\Software\Wow6432Node\Policies\Microsoft\Windows" /v "OneDrive";
    reg add "HKLM\Software\Wow6432Node\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /d 1 /t REG_DWORD /f;

    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:localappdata\Microsoft\OneDrive" | Out-Null;
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:programdata\Microsoft OneDrive" | Out-Null;
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "C:\OneDriveTemp" | Out-Null;    

    Get-ScheduledTask -TaskPath '\' -TaskName 'OneDrive*' -ea SilentlyContinue | ForEach-Object { Unregister-ScheduledTask $_ -Confirm:$False } | Out-Null;

    Start-Process "explorer.exe" | Out-Null;

    Write-SectionMessage "Removing OneDrive from Explorer sidebar";
    reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /d 0 /t REG_DWORD /f;
}

Write-Host
Write-Host "Please restart your computer";

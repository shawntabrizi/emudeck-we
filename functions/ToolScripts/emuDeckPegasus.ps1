
#variables
$Pegasus_toolName="Pegasus Frontend"
$Pegasus_path="$env:USERPROFILE\AppData\Local\pegasus-frontend"
$Pegasus_dir_file="Pegasus_path\game_dirs.txt"
$Pegasus_config_file="Pegasus_path\settings.txt"

function Pegasus_cleanup(){
	echo "NYI"
}

#Install
function Pegasus_install(){
	setMSG "Installing $Pegasus_toolName"
	mkdir $pegasusPath -ErrorAction SilentlyContinue
	$url_pegasus = getLatestReleaseURLGH 'mmatyas/pegasus-frontend' 'zip' 'win'
	download $url_pegasus "Pegasus.7z"
	moveFromTo "$temp/Pegasus/" "$pegasusPath/"
	Remove-Item -Recurse -Force $temp/Pegasus -ErrorAction SilentlyContinue
	createLauncher "Pegasus"
}

#ApplyInitialSettings
function Pegasus_init(){
	setMSG "Setting up $Pegasus_toolName"
	$destination="$Pegasus_path/"
	mkdir $destination -ErrorAction SilentlyContinue
	copyFromTo "$env:USERPROFILE\AppData\Roaming\EmuDeck\backend\configs\pegasus" "$destination"

	#metadata and cores paths
	copyFromTo "$env:USERPROFILE\AppData\Roaming\EmuDeck\backend\roms" "roms"

	Get-ChildItem -Path $romsPath -File -Filter "metadata.txt" | ForEach-Object {
		(Get-Content $_.FullName) | ForEach-Object {
			$_ -replace "CORESPATH", "$emusPath\RetroArch\cores"
		} | Set-Content $_.FullName
	}

	sedFile "$Pegasus_dir_file" "/run/media/mmcblk0p1/Emulation" "$emulationPath"

}


function Pegasus_resetConfig(){
	Pegasus_init &>/dev/null && echo "true" || echo "false"
}

function Pegasus_update(){
	Pegasus_init &>/dev/null && echo "true" || echo "false"
}

function Pegasus_addCustomSystems(){
	echo "NYI"
}

function Pegasus_applyTheme(){
	echo "NYI"
}

function Pegasus_setDefaultEmulators(){
	echo "NYI"
}

function Pegasus_setEmu(){
	echo "NYI"
}

function Pegasus_IsInstalled(){
	$test=Test-Path -Path "$Pegasus_path\pegasus-fe.exe"
	if($test){
		Write-Output "true"
	}
}

function Pegasus_uninstall(){
	echo "NYI"
}
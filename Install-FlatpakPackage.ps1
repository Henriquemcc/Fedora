param(
    [Parameter(Mandatory = $true)]$Package,
    [Parameter(Mandatory = $false)][switch]$User
)

<#
.SYNOPSIS
    Installs a Flatpak package.
.DESCRIPTION
    This installs a Flatpak packages.
.PARAMETER Package
    Package name or list of packages' name to be installed.
.PARAMETER User
    Installs the application or runtime in a per-user installation.
.EXAMPLE
    PS /> ./Install-FlatpakPackage.ps1 -Package "https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref"
    This example installs GIMP.
#>

# Checking if flatpak is installed
$flatpakIsInstalled = ./Test-Expression.ps1 -Command "flatpak"
if (-not$flatpakIsInstalled) {
    ./Install-Flatpak.ps1
}


if ($Package -is [System.String]) {

    if ( $Package.Contains(" ")) {
        ./Install-FlatpakPackage.ps1 -Package $Package.Split(" ") -User:$User
    }

    else {
        $command = "flatpak install --assumeyes"

        if ($User) {
            $command += " --user"
        }

        else {
            $command += " --system"
            $command = "sudo $command"
        }

        $command += " $Package"

        Invoke-Expression -Command $command
    }
}

elseif ($Package -is [System.Collections.ICollection]) {
    foreach ($p in $Package) {
        ./Install-FlatpakPackage.ps1 -Package $p -User:$User
    }
}
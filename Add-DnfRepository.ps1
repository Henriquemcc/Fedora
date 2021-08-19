function Add-DnfRepository
{
    param (
        [Parameter(Mandatory = $true)]$Repository
    )

    Invoke-Expression -Command "sudo dnf --assumeyes config-manager --add-repo=$Repository"
}
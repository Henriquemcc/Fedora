using module "./Install-SnapPackage.ps1"
function Install-VisualStudioCode
{
    Install-SnapPackage -package "code" -classic
}
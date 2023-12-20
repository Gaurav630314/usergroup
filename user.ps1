i# Define an array of user information
$Users = @(
    @{Username = "nocadmin1"; Password = "MphRx#2020"},
    @{Username = "nocadmin2"; Password = "MphRx#2020"},
    @{Username = "techadmin1"; Password = "SigMphRx22"},
	@{Username = "techadmin2"; Password = "SigMphRx22"},
    @{Username = "techadmin3"; Password = "SigMphRx22"}
)
 
$RemoteDesktopUsersGroup = "Remote Desktop Users"
 
foreach ($User in $Users) {
    $Username = $User.Username
    $Password = $User.Password
 
    # Check if the user already exists
    if (-not (Get-LocalUser -Name $Username -ErrorAction SilentlyContinue)) {
        # Create a new user
        New-LocalUser -Name $Username -Password (ConvertTo-SecureString -String $Password -AsPlainText -Force) -Description "RDP User" -AccountNeverExpires
 
        # Add the user to the Remote Desktop Users group
        Add-LocalGroupMember -Group $RemoteDesktopUsersGroup -Member $Username
 
        Write-Host "User '$Username' created successfully."
    } else {
        Write-Host "User '$Username' already exists."
    }
}

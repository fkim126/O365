# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName [ENTER ADMIN UPN HERE] -ShowProgress $true

# Retrieve all distribution groups and store them
$groups = Get-DistributionGroup

# Initialize an array to hold the data
$groupMembers = @()

foreach ($group in $groups) {
    # Retrieve members using the group's unique email address
    $members = Get-DistributionGroupMember -Identity $group.PrimarySmtpAddress
    foreach ($member in $members) {
        # Create a custom object with the group and member information
        $groupMembers += [PSCustomObject]@{
            "Group Name" = $group.DisplayName
            "Group Email" = $group.PrimarySmtpAddress
            "Member Name" = $member.DisplayName
            "Member Email" = $member.PrimarySmtpAddress
        }
    }
}

# Specify the path where you want to save the CSV file
$csvPath = "ENTER FILE PATH HERE/FILE NAME"

# Export the data to a CSV file
$groupMembers | Export-Csv -Path $csvPath -NoTypeInformation

Write-Host "Export complete. File saved to $csvPath"

# This script randomly selects an item from a list of strings. It removes that item from the list
# and continues to select items until the list is empty.


# Create an empty ArrayList for dynamic list management
$list = [System.Collections.ArrayList]@()


# Function to add items to the list
function Add-ListItem {
    param (
        [string]$item
    )
    $null = $list.Add($item)
}


# Add initial items
Add-ListItem "Digital Servicing"
Add-ListItem "Core Banking"
Add-ListItem "Digital Sales"
Add-ListItem "Corporate IT"
Add-ListItem "Quality Assurance, Dev Ops, and Environment Management"
Add-ListItem "AI and RPA"
Add-ListItem "VCIB"


# Function to select and remove a random item from the list.
function Select-RandomItem {
    param (
        [ref]$itemList
    )

    if ($itemList.Value.Count -eq 0) {
        Write-Host "The list is empty. No more items to select."
        return $null
    }

    # Generate a random index
    $randomIndex = Get-Random -Minimum 0 -Maximum $itemList.Value.Count

    # Select the item at the random index
    $selectedItem = $itemList.Value[$randomIndex]

    # Remove the selected item from the list
    $itemList.Value.RemoveAt($randomIndex)

    return $selectedItem
}


# Function to print each item in an array on its own line.
function Write-ListItems {
    param (
        [array]$items
    )

    foreach ($item in $items) {
        Write-Host $item
    }
}

    
# Main loop to select items until the list is empty.
while ($list.Count -gt 0) {
    $selected = Select-RandomItem -itemList ([ref]$list)
    if ($null -ne $selected) {
        Write-Host "`nPresenter: $selected"

        Write-Host "`nRemaining Presenters:"
        Write-ListItems -items $list
        
        Write-Host "`nPress Space Bar to select another item or ESC to exit..."
        
        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        
        if ($key.VirtualKeyCode -eq 27) { # ESC key
            exit
        }
        elseif ($key.VirtualKeyCode -ne 32) { # Not Space Bar
            Write-Host "`nPlease press Space Bar to continue or ESC to exit..."
        }
    }

}

Write-Host "`nEveryone has presented!"
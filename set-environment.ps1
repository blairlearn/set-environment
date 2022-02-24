param (
	[string]$variableName,
	[string]$value
 )

function Main() {

	 if( [string]::IsNullOrWhitespace( $variableName) -or
		 [string]::IsNullOrWhitespace( $value) ) {
		Write-Host -foregroundcolor 'green' 'Usage: set-environment <variable_name> <value>'
		Return
	 }

	$isAdmin = Is-Admin;
	if( $isAdmin ) {

		[System.Environment]::SetEnvironmentVariable($variableName, $value, [System.EnvironmentVariableTarget]::Machine)
		Write-Host "$variableName will be set to '$value' on the next login."

	} else {
		Write-Host -foregroundcolor 'red' "This script must be run with elevated privileges.";
	}
}

function Is-Admin {
 $id = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent());
 $id.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator);
}

Main;


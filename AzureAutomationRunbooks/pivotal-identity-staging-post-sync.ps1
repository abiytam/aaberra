# Get the username and password from the SQL Credential
$SqlServer = "pivotal-identity.database.windows.net"
$SqlServerPort = "1433"
$Database = "pivotal-identity-staging"
$SqlCredential = Get-AutomationPSCredential -Name 'pivotal-identity-db-user'
$SqlUsername = $SqlCredential.UserName
$SqlPass = $SqlCredential.GetNetworkCredential().Password
    

# Define the connection to the SQL Database
$Conn = New-Object System.Data.SqlClient.SqlConnection("Server=tcp:$SqlServer,$SqlServerPort;Database=$Database;User ID=$SqlUsername;Password=$SqlPass;Trusted_Connection=False;Encrypt=True;Connection Timeout=30;")
# Open the SQL connection
$Conn.Open()


# Define the SQL command to run. In this case we are getting the number of rows in the table
$Cmd=new-object system.Data.SqlClient.SqlCommand("UPDATE dbo.Clients SET BackChannelLogoutUri = ''", $Conn)
$Cmd.CommandTimeout=120

# Execute the SQL command
$Ds=New-Object system.Data.DataSet
$Da=New-Object system.Data.SqlClient.SqlDataAdapter($Cmd)
[void]$Da.fill($Ds)

# Output the count
#$Ds.Tables.Column1

# Close the SQL connection
$Conn.Close()
#testing sync
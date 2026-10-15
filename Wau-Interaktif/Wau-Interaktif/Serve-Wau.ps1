param([switch]$NoBrowser, [int]$Port = 0)
$ErrorActionPreference = 'Stop'
$wauRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot 'dist'))
$wauListener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $Port)
$wauListener.Start()
$wauPort = $wauListener.LocalEndpoint.Port
if (-not $NoBrowser) { Start-Process ('http://127.0.0.1:' + $wauPort + '/') }
Write-Output ('Local: http://127.0.0.1:' + $wauPort + '/')
$wauMime = @{ '.html'='text/html; charset=utf-8'; '.js'='text/javascript; charset=utf-8'; '.css'='text/css; charset=utf-8'; '.json'='application/json'; '.jpg'='image/jpeg'; '.png'='image/png'; '.bin'='application/octet-stream'; '.woff2'='font/woff2' }
$wauLastUse = [DateTime]::UtcNow
try {
 while (([DateTime]::UtcNow - $wauLastUse).TotalHours -lt 2) {
  if (-not $wauListener.Pending()) { Start-Sleep -Milliseconds 100; continue }
  $wauClient = $wauListener.AcceptTcpClient()
  try {
   $wauClient.ReceiveTimeout = 3000
   $wauStream = $wauClient.GetStream()
   $wauReader = [System.IO.StreamReader]::new($wauStream, [System.Text.Encoding]::ASCII, $false, 1024, $true)
   $wauRequest = $wauReader.ReadLine()
   while ($wauReader.ReadLine()) {}
   $wauRelative = [Uri]::UnescapeDataString(($wauRequest.Split(' ')[1].Split('?')[0])).TrimStart('/')
   if (-not $wauRelative) { $wauRelative = 'index.html' }
   $wauFile = [System.IO.Path]::GetFullPath((Join-Path $wauRoot $wauRelative))
   if (-not $wauFile.StartsWith($wauRoot + [System.IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase) -or -not [System.IO.File]::Exists($wauFile)) {
    $wauData = [Text.Encoding]::UTF8.GetBytes('Not found'); $wauStatus = '404 Not Found'; $wauType = 'text/plain'
   } else {
    $wauData = [System.IO.File]::ReadAllBytes($wauFile); $wauStatus = '200 OK'; $wauType = $wauMime[[System.IO.Path]::GetExtension($wauFile)]
    if (-not $wauType) { $wauType = 'application/octet-stream' }
   }
   $wauHeader = [Text.Encoding]::ASCII.GetBytes("HTTP/1.1 $wauStatus`r`nContent-Type: $wauType`r`nContent-Length: $($wauData.Length)`r`nConnection: close`r`n`r`n")
   $wauStream.Write($wauHeader, 0, $wauHeader.Length)
   $wauStream.Write($wauData, 0, $wauData.Length)
   $wauLastUse = [DateTime]::UtcNow
  } catch {} finally { $wauClient.Dispose() }
 }
} finally { $wauListener.Stop() }

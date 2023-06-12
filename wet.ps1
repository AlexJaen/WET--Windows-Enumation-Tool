Write-Host "Herramienta de enumeración y escaneo."
Write-Host "Enumeration and scan tool."
Write-Host "Github ---> https://github.com/Lorealex"
Function showmenu {
Clear-Host
Write-Host @"
+===============================================+
|  WET ALEJANDRO JAEN - MAIN MENU               | 
+===============================================+
|                                               |
|    1) PING +                                  |
|    2) ESCANEO DE PUERTOS +                    |
|    3) BANNER GRABBING                         |
|    4) CABECERAS HTTP                          |
|    5) DETECCIÓN DE SO                         |
|    6) BÚSQUEDA DE DIRECTORIOS WEB             |
|    7) SALIR                                   |
+===============================================+

"@
}

Function scanmenu {
Clear-Host
Write-Host @"
+===============================================+
|  WET ALEJANDRO JAEN - SCAN MENU               | 
+===============================================+
|                                               |
|    1) ARP PING                                |
|    2) TCP PING                                |
|    3) UDP PING                                |
|    4) ICMP PING                               |
|    5) ATRAS                                   |
|    6) SALIR                                   |
+===============================================+

"@
}

Function menu_puertos{
Clear-Host
Write-Host @"
+===============================================+
|  WET ALEJANDRO JAEN - PORTSCAN MENU           | 
+===============================================+
|                                               |
|    1) TCP SCAN +                              |
|    2) ACK SCAN +                              |
|    3) ATRAS                                   |
|    4) SALIR                                   |
+===============================================+

"@
}

function menu_tcpscan {
Clear-Host
Write-Host @"
+===============================================+
|  WET ALEJANDRO JAEN - PORT  MENU              | 
+===============================================+
|                                               |
|    1) Well-Known Ports (1-1024)               |
|    2) Puertos más comunes (ftp, http, ssh...) |
|    3) Todos los puertos (1-65535)             |
|    4) Puerto concreto                         |
|    5) ATRAS                                   |
|    6) SALIR                                   |
+===============================================+

"@
}


Function scan {
scanmenu
 
$opcionscan = Read-Host -Prompt "Selecciona una opción: "
 
switch($opcionscan){
        1 {
            Clear-Host
            arpscan
        }
        2 {
            Clear-Host
            tcpping
        }
        3 {
            Clear-Host
            udpping
            }
        4 {
            Clear-Host
            icmpping
            }
        5 {
            Clear-Host
            menu
            }
        6 {
            exit
        }
        default {Write-Host -ForegroundColor red -BackgroundColor white "Opción incorrecta, seleccione otra opción";pause}
        
    }
scan

}

function arpscan{
    Clear-Host
    arp -a
    Write-Host
    read-Host "Pulse una ENTER para continuar"
}

function tcpping {
Clear-Host
$ip= Read-Host "Introduzca una direccion IP: "
if ($ip){
    .\psping.exe $ip -accepteula
    write-host ""
    read-Host "Pulse una ENTER para continuar"
    $ip=$null
    }
    else {
    Write-Host "Entrada no válida..."
    sleep 1
    tcpping
    }
}

function udpping {
Clear-Host
$ip= Read-Host "Introduzca una direccion IP: "
if ($ip){
    .\psping.exe -u -s 127.0.0.1:50000 $ip -accepteula
    write-host ""
    read-Host "Pulse una ENTER para continuar"
    $ip=$null
    }
    else {
    Write-Host "Entrada no válida..."
    sleep 1
    tcpping
    }
}

function icmpping {
Clear-Host
$ip= Read-Host "Introduzca una direccion IP: "
if ($ip){
    ping $ip
    write-host ""
    read-Host "Pulse una ENTER para continuar"
    $ip=$null
    }
    else {
    Write-Host "Entrada no válida..."
    sleep 1
    tcpping
    }
}


function portscan {
menu_puertos
$opcionscan2 = Read-Host -Prompt "Selecciona una opción: "
 
switch($opcionscan2){
        1 {
            Clear-Host
            tcpscan
        }
        2 {
            Clear-Host
            ack_scan
            }
        3 {
            Clear-Host
            menu
            }
        4{
            exit
        }
        default {Write-Host -ForegroundColor red -BackgroundColor white "Opción incorrecta, seleccione otra opción";pause}
    }
portscan
}

function tcpscan {
menu_tcpscan
$opciontcp = Read-Host -Prompt "Selecciona una opción: "

switch($opciontcp){
        1 {
            $puertos=1..1024
        }
        2 {
            $puertos=21,22,23,25,53,80,101,110,123,137,138,139,143,179,194,443,445,587,591,853,990,993,995,1194,1723,1812,1813,2049,2082,2083,3074,3306,3389,4662,4672,4899,5000,5400,5500,5600,5700,5800,5900,6881,6969,8080,51400,25565
        }
        3 {
            $puertos=1..65535
           }

        4 {
            $puertos = Read-Host -Prompt "Introduce un puerto o varios separados por comas ej: 80,123,443"
            $puertos = $puertos -split ","
               }
        5 {
            Clear-Host
            menu
            }
        6 {
            exit
        }
        default {Write-Host -ForegroundColor red -BackgroundColor white "Opción incorrecta, seleccione otra opción";pause}
    }

       $ip= Read-Host "Introduzca una direccion IP: "
       if ($ip){
           $puertos | % {Write-Host -ForegroundColor Green ((new-object Net.Sockets.TcpClient).Connect(“$ip”,$_)) “El puerto $_ está abierto!”} 2>$null
           write-host ""
           read-Host "Pulse una ENTER para continuar"
           $ip=$null
           }
           else {
           Write-Host "Entrada no válida..."
           sleep 1
           tcpscan
          }
       }


function ack_scan {
menu_tcpscan
$opciontcp = Read-Host -Prompt "Selecciona una opción: "

switch($opciontcp){
        1 {
            $puertos=1..1024
        }
        2 {
            $puertos=21,22,23,25,53,80,101,110,123,137,138,139,143,179,194,443,445,587,591,853,990,993,995,1194,1723,1812,1813,2049,2082,2083,3074,3306,3389,4662,4672,4899,5000,5400,5500,5600,5700,5800,5900,6881,6969,8080,51400,25565
        }
        3 {
            $puertos=1..65535
           }

        4 {
            $puertos = Read-Host -Prompt "Introduce un puerto o varios separados por comas ej: 80,123,443"
            $puertos = $puertos -split ","
               }
        5 {
            Clear-Host
            menu
            }
        6 {"Exit"; break}
        default {Write-Host -ForegroundColor red -BackgroundColor white "Opción incorrecta, seleccione otra opción";pause}
    }

       $ip= Read-Host "Introduzca una direccion IP: "
       if ($ip){
           $puertos | Foreach-Object -Process `
           {If (($a=Test-NetConnection $ip -Port $_ -WarningAction SilentlyContinue).tcpTestSucceeded -eq $true) `
           {Write-Host “El puerto " $a.RemotePort " está abierto!” -ForegroundColor Green} else `
           {Write-Host “El puerto " $a.RemotePort " está cerrado!” -ForegroundColor red}}
           write-host ""
           read-Host "Pulse una ENTER para continuar"
           $ip=$null
           }
           else {
           Write-Host "Entrada no válida..."
           sleep 1
           ack_scan
          }
       }


function banner_grab {
Clear-Host
$results=@()
$details=@()
$ip = Read-Host "Introduzca una direccion IP "
$puertos = Read-Host -Prompt "Introduce un puerto o varios separados por comas ej ==> 80,123,443"
$puertos = $puertos -split ","
Write-Host ""

function QueryPort ([string]$ip2, [string]$puerto2) {
    Write-Host ""
    $socket= New-Object System.Net.Sockets.TCPClient
    $connected = ($socket.BeginConnect( $ip2, $puerto2, $Null, $Null )).AsyncwaitHandle.WaitOne(300) 
    if ($connected -eq "True") {
        $stream = $socket.getStream()
        Start-Sleep -m 500; $text=""
        while ($stream.DataAvailable) { $text += [char]$stream.ReadByte() }
    if ($text.Length -eq 0) { $text = "No se ha recibido ningun banner" }
        $text = "TCP:$puerto2 is open: $text"
        $text
        $socket.Close()
    } 
    else {}
    }

If (Test-Connection -Count 1 -ComputerName $ip -Quiet) {
    $details = @{
        Date = get-date
        IPAddress = $ip
        Online = "Yes"
        Ports = ""
}
    foreach ($puerto in $puertos) {
    try {
        $TestPort = QueryPort $ip $puerto
        $details.Ports += $TestPort #+ "'r'n"
        if ($TestPort.Length -eq 0){ echo $puerto } else { echo "$puerto : $TestPort"} 
    } catch {}
}
    $results += New-Object PSObject -Property $details
}


    write-host ""
    read-Host "Pulse ENTER para continuar"
    menu
}


function http_head {
    $result= ""
    $url = Read-Host "Indique la direccion IP y el puerto del servidor web (por defecto puerto 80) "
    $result = Invoke-WebRequest -Method HEAD -Uri $url -UseBasicParsing
    Write-Host ""

    $result.Headers.Server
    read-Host "Pulse ENTER para continuar"
    menu
}

function detect {
   $ip = Read-Host "Introduzca una direccion IP: "
   $os = (Test-Connection -Count 1 $ip).ResponseTimeToLive
   if ($os -lt 65 )
    {
      write-host -f green "La máquina objetivo se trata de un sistema Linux en base al valor del TTL ==> ${os}"
    }
   elseif ($os -gt 64 -and $os -lt 129)
   {
      write-host -f green "La máquina objetivo se trata de un sistema Windows en base al valor del TTL ==> ${os}"

   }
   read-Host "Pulse ENTER para continuar"
   menu
}


function dir_find {
    $ErrorActionPreference= 'silentlycontinue'
    $archivo = Get-Content .\lista.txt
    $ip = Read-Host "Introduzca una direccion URL "
    

    foreach ( $linea in $archivo) {
    $HTTP_Response = 0
    $url = "http://" + "$ip" + "/" + "$linea"

    $HTTP_Request = [System.Net.WebRequest]::Create($url)

    $HTTP_Response = $HTTP_Request.GetResponse() 

    $HTTP_Status = [int]$HTTP_Response.StatusCode

    If ($HTTP_Status -eq 200) {
        Write-Host -f green "Se ha encontrado $url en el servidor web"
        }

    If ($HTTP_Response -eq $null) { } 
    Else { $HTTP_Response.Close() }
}
    read-Host "Pulse ENTER para continuar"
    menu
}

function menu{ 
showmenu
 
$opcion = Read-Host -Prompt "Select an option"
 
switch($opcion){
        1 {
            Clear-Host
            scan
        }
        2 {
            Clear-Host
            portscan
        }
        3 {
            Clear-Host
            banner_grab
            }
        4 {
            Clear-Host
            http_head
            }
        5 {
            Clear-Host
            detect
            }
        6 {
            Clear-Host
            dir_find
            }
        7 {
            exit
            }
        default {Write-Host -ForegroundColor red -BackgroundColor white "Opción incorrecta, seleccione otra opción";pause}
        
    }
}
menu

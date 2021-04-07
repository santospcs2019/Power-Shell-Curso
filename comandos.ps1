$PSVersionTable.PSVersion
get-host
(Get-Host).version
Get-Command -CommandType cmdlet

clear
Write-Host "hello World"
Get-ChildItem D:\00_virtual_box\Cassandra

# Update Help
Update-Help
get-help Write-Host
get-help Write-Host -online # Pagina na Microsoft
Get-Date -DisplayHint Date
get-help Get-Date -ShowWindow # Abre uma janela Grafica 

Get-Command -CommandType cmdlet | more

Get-Command -CommandType Cmdlet *eventlog*

Get-Command -CommandType Function | more

Get-ChildItem function:\Clear-Host | type

Get-Command -CommandType alias | more

 Set-Alias limpar clear-host


 Get-Process | more

 Get-Process | Format-list | more

 Get-Process | ConvertTo-html | Out-File "Processos.html"

  start .\Processos.html

PS C:\Users\santo\posh> Get-Date > lista.txt
PS C:\Users\santo\posh> type .\lista.txt

segunda-feira, 29 de março de 2021 14:12:03


# saida de erro do comando

 update-help 2> erro.log
 type .\erro.log

 # Gera uma planilha que permite filtra e classificar a informação
 Get-Process | Out-GridView

 # Recebendo dados do comando anterior e filtratando pela coluna status do comando Get-service.
 Get-Service | Where-Object {$_.Status -eq "Running"}

 Get-Service | Where-Object {$_.Status -ne "Running"}

 Get-Service | Where-Object {$_.DisplayName -like "*Security*"}

 #######################################
 # Modulos                             #
 #######################################

 
 Get-Module -ListAvailable

 Get-Command -module SmbShare # lista as funções do modulo smbshare

 Get-SmbShare

 Get-Command -module defender

 # Importando modulos para o powershell
 # Arquivos com extensão .psm1 (são modulos para o powershell)

 Import-Module \NanosServerImageGenerator.psm1

 Get-PSRepository # Verifica Repositorio

 # https://www.powershellgallery.com/

 Install-Module -Name PSDownr

Repositório não confiável
Você está instalando módulos de um repositório não confiável. Se você confiar nesse repositório, altere seu valor
InstallationPolicy. Basta executar o cmdlet Set-PSRepository. Tem certeza de que deseja instalar os módulos de
'PSGallery'?
[S] Sim  [A] Sim para Todos  [N] Não  [T] Não para Todos  [U] Suspender  [?] Ajuda (o padrão é "N"): A
PS C:\Users\santo\posh>

 Get-Command -Module PSDownr

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Convert-Video                                      1.0.3.0    PSDownr
Cmdlet          Get-YoutubeAudio                                   1.0.3.0    PSDownr
Cmdlet          Get-YoutubeVideo                                   1.0.3.0    PSDownr


Get-Command Get-YoutubeAudio

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Get-YoutubeAudio                                   1.0.3.0    PSDownr


PS C:\Users\santo\posh> Get-Command Get-YoutubeAudio -Syntax

Get-YoutubeAudio -Uri <string> [-DestinationPath <string>] [-FileName <string>] [<CommonParameters>]

##########################
# Variaveis              #
#########################

$ - Variavel

#no powershell dos
#
#$env:APPDATA --> mostra o conteudo

Clear-host
$nome = Read-Host "Qual é o seu nome? "
$saudacao = "Olá"
$frase = "$saudacao, $nome"

#Write-Host "$frase" # Nem precisa
$frase.Length
$frase.ToUpper()
$frase


###############################
# Array                       #
###############################


Clear-host
$GoogleDNS = @("8.8.8.8", "8.8.4.4")
$TotalDNS = $GoogleDNS.Count
write-host Pingando todos os $GoogleDNS.Count DNS do Goggle
Test-Connection $GoogleDNS -Count 2
sleep 10
write-host FIM!

###############################
# Hash Table                  #
###############################

Clear-host
$servidores = [ordered] @{Server1="127.0.0.1";Server2="127.0.0.2";Server3="127.0.0.3"}
$servidores
$servidores.count
# Adicionar

$servidores["Server4"]="127.0.0.4"
$servidores
$servidores.count
# Remover

$servidores.Remove("Server4")
$servidores

#Contar
$servidores.count

# Mostra o conteudo da coluna
$servidores.Server2

# testa conexão com o  conteudo da coluna da hash table

Test-Connection $servidores.Server2

Test-NetConnection

Test-NetConnection -InformationLevel "Detailed"
Test-NetConnection -ComputerName "www.google.com" -InformationLevel "Detailed"

# Mostrar os valores da hash table

$servidores.values

#############################
# Select-String             #
#############################

Get-Help Select-String

Get-Help Select-String - Examples

# Uma String

get-Content D:\onedrive\07_Profissional\07_oracle_scr\0000000000000000_db\linux_cmd.txt | Select-String GREP

# Varias Strings

get-Content D:\onedrive\07_Profissional\07_oracle_scr\0000000000000000_db\linux_cmd.txt | Select-String GREP, CPU, SQLPLUS, SCP

Select-String -Pattern GREP D:\onedrive\07_Profissional\07_oracle_scr\0000000000000000_db\linux_cmd.txt

Get-ChildItem D:\onedrive\07_Profissional\07_oracle_scr\0000000000000000_db\*.txt | select-string  -Pattern scp

select-string  -path "D:\onedrive\07_Profissional\07_oracle_scr\0000000000000000_db\linux_cmd.txt" -Pattern oracle -Context 1,1 # do que vc achou uma linha acima outra abaixo no COntext

# Not Match -- oracle

select-string  -path "D:\onedrive\07_Profissional\07_oracle_scr\0000000000000000_db\linux_cmd.txt" -Pattern oracle -NotMatch

###################################
# REGEX                           #
###################################

$email = Read-Host Qual seu email ?
$regex = "^[a-z]+\.[a-z]+@contoso.com$"
If ($email –notmatch $regex) {
  Write-Host "Errou o endereço de email  $email" 
  Exit
  }

    
Write-Host Acertou !

get-content cpf.txt | Select-String -Pattern '\d.\d.\d-\d'

##########################################
# IF.... ELSE                            #
##########################################

# Consulta Serviço no Windows

$serv = Get-Service -Name LMS
if ($serv.Status -eq "Running")
    {
    Write-Host "Em execução"
    }
    Else
     {
    Write-Host "Serviço Parado"
    }

# Teste de Internet

Clear
$conn = (Test-Connection www.google.com -Count 1 -Quiet)
if ($conn -eq "true") {Write-Host "Google respondendo" -ForegroundColor Yellow}

####################################
# Loop                             #
####################################

#Exemplo do Comando For

Clear-Host
for ($var=1; $var -le 15; $var++) {Test-Connection 192.168.0.$var -Count 1}

# For simples para iniciar um serviço enquanto o status estiver "Stopped"
 
for($serviço = Get-Service wuauserv; $serviço.Status -eq "Stopped";Start-Service wuauserv){
Write-Host -ForegroundColor Green $serviço.DisplayName": O serviço foi iniciado"
$serviço = Get-Service wuauserv
}

# Exemplo foreach

Get-Process notepad | foreach kill # Encerra todos os processos notepad

cls
foreach ($numeros in 1,2,3,4,5,6,7,8) {echo $numeros}

cls
foreach ($arquivos in Get-ChildItem) {echo $arquivos}

cls
foreach ($arquivos in Get-ChildItem) 
 { if ($arquivos.IsReadOnly) 
  {write-host $arquivos.FullName, $arquivos.Length}
  }

# ForEach simples que verifica o caminho de arquivos .txt através dos dados retornados do comando Get-ChildItem
 
$Arquivos = Get-ChildItem C:\Users\RobotChicken
 
ForEach($Arquivo in $Arquivos){
    If($Arquivo.Name -match "txt"){
        Write-Host -ForegroundColor Green "Arquivo TXT encontrado: " $Arquivo.FullName
            }
        }

Get-ChildItem C:\Users\RobotChicken | ForEach{ 
    If($_.Name -match "txt"){
        Write-Host -ForegroundColor Green "Arquivo TXT encontrado: " $_.FullName
            }
}

# ForEach simples que verifica o status dos adaptadores de rede instalados no computador através dos dados retornados pelo objeto Get-NetAdapter
 
ForEach($Adaptador in Get-NetAdapter){
  Write-Host -ForegroundColor Yellow "O status do Adaptador de Rede:" $Adaptador.InterfaceDescription "é:" $Adaptador.Status
            }



# Exemplo de While

# Loop infinito

$i = 0
while($true)
{
 $i++
 write-host "Contando $i"
 }

 # break

 $i = 0
while($true)
{
 $i++
 write-host "Contando $i"
 if ($i -ge 1000) {break}
 }
 #######################################
 # Função                              #
 #######################################

 function somar
 {
 param ($a, $b)
 $resultado = $a + $b
 write-host "A resposta é $resultado"
 }

 somar 3 8

 function iniciar-editores
 {
  Start-Process Notepad
  sleep 5
  Start-Process Wordpad
  }

  iniciar-editores

# Microsoft PowerShell script to create a simple function
# Author: Guy Thomas
Function Get-BatAvg{
Param ($Name, $Runs, $Outs)
$Avg = [int]($Runs / $Outs*100)/100
Write-Output "$Name's Average = $Avg, $Runs, $Outs"
}

Get-BatAvg Bradman 6996 70

# Function to Discover WMI Primary Keys

Clear-Host
Function  Get-WmiKey {
$Class = [WmiClass]$args[0]
$Class.Properties | `
Select @{Name="PName";Expression={$_.name}} -Expand Qualifiers | `
Where {$_.Name -eq "key"} | `
foreach {$_.Pname}
}

Get-WmiKey Win32_LogicalDisk

function Output-SalesTax {
 param( [int]$Price, [int]$Tax )
 $Price + $Tax
}

Output-SalesTax -price 1000 -tax 38

####################################
# WorkFlow                         #
####################################

#workflow helloword

workflow tipo-cmdlet
{
write-output "Hello World"
}

tipo-cmdlet

(Get-Command tipo-cmdlet).parameters

# Parallel execution
# Comparação da função que executa uma por vez com o workflow que executa em parallelo

# Função

function iniciar-editores
 {
  Start-Process Notepad
  sleep 5
  Start-Process Wordpad
  }

#Workflow

workflow start-editores
{Parallel 
 {
  Start-Process Notepad
  sleep 5
  Start-Process Wordpad
  }
 }

 start-editores

 ##########################################
 # Job e Schedule Jobs                    #
 ##########################################

 workflow workflowdemorado
 {
 while(1)
     {
     (get-date).ToString() + " Script Infinito"
     Start-Sleep -Seconds 2
     }
 }

 workflowdemorado


 $wfjob = workflowdemorado -AsJob # -Asjob execute como um job em backuground
 $wfjob # a propria variavel mostra o job

 # ver o resultado do job executando

 Receive-job $wfjob

 # Pause Job 

 Suspend-Job $wfjob -force # opcional

 # Retoma

 resume-job $wfjob

 # Stop Job

 Stop-Job $wfjob

 # Scheduler Jobs

 # Comandos Jobs scheduler 

 clear-host
 Get-Command -Module PSScheduledJOB | Sort-Object Noun

 # Definindo datas de agendamento ou triggers

 $diario = New-JobTrigger -Daily -at 3am
 $umavez = New-JobTrigger -Once -at(Get-Date).AddHours(1)
 $semanal = New-JobTrigger -Weekly -DaysOfWeek Monday -At 6pm

 # Agendar

 Register-ScheduledJob -Name Backup -Trigger $diario -ScriptBlock {
 Copy-Item D:\onedrive\100_Treinamento\08_Powershell\*.* C:\Users\santo\posh -Recurse -Force
 }

 # Checa o Agendamento

 Get-scheduledJob Backup | Get-jobTrigger 

 # Retirar o job so agendamento

 Get-scheduledJob Backup | Unregister-ScheduledJob 
 
 ###############################################
 #   Wscript.Shell                             #
 ###############################################

 $wshell = New-Object -ComObject WScript.shell
 

 $wshell | Get-Member

 PS C:\WINDOWS\system32>  $wshell | Get-Member


   TypeName: System.__ComObject#{41904400-be18-11d3-a28b-00104bd35090}

Name                     MemberType            Definition                                   
----                     ----------            ----------                                   
AppActivate              Method                bool AppActivate (Variant, Variant)          
CreateShortcut           Method                IDispatch CreateShortcut (string)            
Exec                     Method                IWshExec Exec (string)                       
ExpandEnvironmentStrings Method                string ExpandEnvironmentStrings (string)     
LogEvent                 Method                bool LogEvent (Variant, string, string)      
Popup                    Method                int Popup (string, Variant, Variant, Variant)
RegDelete                Method                void RegDelete (string)                      
RegRead                  Method                Variant RegRead (string)                     
RegWrite                 Method                void RegWrite (string, Variant, Variant)     
Run                      Method                int Run (string, Variant, Variant)           
SendKeys                 Method                void SendKeys (string, Variant)              
Environment              ParameterizedProperty IWshEnvironment Environment (Variant) {get}  
CurrentDirectory         Property              string CurrentDirectory () {get} {set}       
SpecialFolders           Property              IWshCollection SpecialFolders () {get}       



$wshell.Popup("Este curso e Basico demais")

# Escreve dados dentro do notepad

$wshell.run("notepad")
$wshell.appActivate("notepad")
start-sleep 2
$wshell.SendKeys("Escreve dados dentro do notepad do windows")

############################################
# Execução Remota                          #
############################################

Get-HotFix

Get-HotFix -id KB5000858

invoke-command -ComputerName ROMA -ScriptBlock {Get-HotFix -id KB5000858}

# Sessão interativa

Enter-PSSession remote computer name
---> sair Exit-PSSession

# Exemplo de sessão persistente usando PSSession, Invoke-Command e jobs

Clear-Host

#variavel 

$s = New-PSSession -name W2012R2 # nome do computador.

Invoke-Command -Session $s -ScriptBlock {
workflow workflowdemorado
 {
 while(1)
     {
     (get-date).ToString() + " Script Infinito"
     Start-Sleep -Seconds 2
     }
 } -Asjob -JobName LongoTrabalho
 }


 # Ver o que esta acontecendo no job remotamente

 Get-job -name LongoTrabalho | Receive-job -keep 


# Comandos 

# Desconectar da Sessão

Disconnect-PSSession $s

# reconectar

Receive-PSSession $s

# stop job 

Get-job -name LongoTrabalho | Stop-Job

Get-Command *PSSEssion

CommandType     Name                                               Version    Source                                                                    
-----------     ----                                               -------    ------                                                                    
Cmdlet          Connect-PSSession                                  3.0.0.0    Microsoft.PowerShell.Core                                                 
Cmdlet          Disconnect-PSSession                               3.0.0.0    Microsoft.PowerShell.Core                                                 
Cmdlet          Enter-PSSession                                    3.0.0.0    Microsoft.PowerShell.Core                                                 
Cmdlet          Exit-PSSession                                     3.0.0.0    Microsoft.PowerShell.Core                                                 
Cmdlet          Export-PSSession                                   3.1.0.0    Microsoft.PowerShell.Utility                                              
Cmdlet          Get-PSSession                                      3.0.0.0    Microsoft.PowerShell.Core                                                 
Cmdlet          Import-PSSession                                   3.1.0.0    Microsoft.PowerShell.Utility                                              
Cmdlet          New-PSSession                                      3.0.0.0    Microsoft.PowerShell.Core                                                 
Cmdlet          Receive-PSSession                                  3.0.0.0    Microsoft.PowerShell.Core                                                 
Cmdlet          Remove-PSSession                                   3.0.0.0    Microsoft.PowerShell.Core                                                 

###############################################################
# Liberando acesso remoto para o PowerShell fora do dominio   #
###############################################################

Set-Item WSMan:\localhost\Client\TrustedHosts 'ROMA' # Cuidado O * permite qualuer um, troque 0 * pelo nome de uma maquina.

#1) Teste a conexão

Test-Connection ROMA
#2) Abra a conexão.

New-PSSession -ComputerName ROMA -Credential dominio\administrator # Abri a seção remota no caso aqui e ROMA mas pode ser qualquer servidor.

Enter-PSSession -ID 2 # Número da seção, retornado após o New-Pssession.

# Guardando a credencial antes.

clear-host

$cred = Get-Credential DOMINIO\ADMINISTRATOR # Abrirá a Tela para pediar a senha e armazenar na variavel.

New-PSSession -ComputerName ROMA -Credential $cred

# Conectando a uma lista de computadores.

clear-host

$cred = Get-Credential DOMINIO\ADMINISTRATOR 
$rede = New-PSSession -ComputerName (Get-Content C:\rede\lista_servidores.txt) -Credential $cred

# Executar o comando em varias maquinas da rede, observer que a variavel $rede herdou a credencial da $cred e é usada no Invoke-comand abaixo

Invoke-Command $rede {Get-Service}

###################################
# Renomeando Computarname         #
###################################

$info = Get-WmiObject -Class Win32_ComputerSystem
$info
$info.Name
$info.Rename("ROMA")
Restart-Computer

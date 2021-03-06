#By BigTeddy 05 September 2011

$folder = 'C:\Users\pdasilvapaixo\Desktop\Videos\MP4' # Enter the root path you want to monitor.
$filter = '*.*'  # You can enter a wildcard filter here.

# In the following line, you can change 'IncludeSubdirectories to $true if required.                          
$fsw = New-Object IO.FileSystemWatcher $folder, $filter -Property @{IncludeSubdirectories = $false;NotifyFilter = [IO.NotifyFilters]'FileName, LastWrite'}

# Here, all three events are registerd.  You need only subscribe to events that you need:
Register-ObjectEvent $fsw Created -SourceIdentifier FileCreated -Action {
	$name = $Event.SourceEventArgs.Name
	$changeType = $Event.SourceEventArgs.ChangeType
	$timeStamp = $Event.TimeGenerated
	$workingDirectory = pwd
	$inputFile = $workingDirectory.Path + '\MP4\' + $name
	$outputFile = $workingDirectory.Path + '\GIF\' + $name.replace(".mp4",".gif")
	&"C:\Program Files (x86)\ffmpegyag\bin\ffmpeg-hi10-heaac.exe" -i $inputFile $outputFile
}

# To stop the monitoring, run the following commands:
# Unregister-Event FileDeleted
# Unregister-Event FileCreated
# Unregister-Event FileChanged
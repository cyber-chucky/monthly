# Parameters:
$SiteName = "NlpApi"
$AppDirectory = "D:\Applications\Abbie.NLP.Api.1.0.25"
$PreviousAppDirectory = "D:\Applications\Abbie.NLP.Api.1.0.23"
$VirtualEnvDirectory = ".venv"

# Change site physical path 
Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/site[@name='$SiteName']/application[@path='/']/virtualDirectory[@path='/']" -name "physicalPath" -value "$AppDirectory"

# Add FastCgi handler to the site
Add-WebConfigurationProperty -pspath "MACHINE/WEBROOT/APPHOST/$SiteName"  -filter "system.webServer/handlers" -name "." -value @{name='PyHandler';path='*';verb='*';modules='FastCgiModule';scriptProcessor="$AppDirectory\$VirtualEnvDirectory\Scripts\python.exe|$AppDirectory\wfastcgi.py"}

# Create new FastCgi Application
Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.webServer/fastCgi" -name "." -value @{fullPath="$AppDirectory\$VirtualEnvDirectory\Scripts\python.exe";arguments="$AppDirectory\wfastcgi.py"}

# Delete previous FastCgi Application
Remove-WebConfigurationProperty  -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.webServer/fastCgi" -name "." -AtElement @{fullPath="$PreviousAppDirectory\$VirtualEnvDirectory\Scripts\python.exe";arguments="$PreviousAppDirectory\wfastcgi.py"}


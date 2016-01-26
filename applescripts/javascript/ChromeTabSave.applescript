var chrome = Application('Google Chrome'),
	app = Application.currentApplication()
    qs = Application('Quicksilver')

app.includeStandardAdditions = true;

var tab = chrome.windows.at(chrome.activeWindow).activeTab
try {
	result = app.doShellScript('grep "' + tab.url() + '" ~/TODO/Reading.md')
	qs.showNotification("Already stored.");
} catch(e) {
	app.doShellScript('echo "- [ ' + tab.title() + ' ](' + tab.url() + ')" >> ~/TODO/Reading.md')
	
	qs.showNotification(tab.title() + " saved.");

}


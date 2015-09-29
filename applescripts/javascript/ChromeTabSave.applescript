var chrome = Application('Google Chrome'),
	app = Application.currentApplication()
    qs = Application('Quicksilver')

app.includeStandardAdditions = true;

var tab = chrome.windows.at(chrome.activeWindow).activeTab

app.doShellScript('echo "[ ' + tab.title() + ' ](' + tab.url() + ')" >> ~/TODO/Reading.md')

qs.showNotification(tab.title() + " saved.");

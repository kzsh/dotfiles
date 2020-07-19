// target="/Applications/Google Chrome.app"
var currentApp = Application.currentApplication();

currentApp.includeStandardAdditions = true;

try {
  if (currentApp.title() === 'Google Chrome' ||
      currentApp.title() === 'Google Chrome Canary') {
    var chrome = currentApp;

    var tab = chrome.windows.at(chrome.activeWindow).activeTab
    try {
      result = app.doShellScript('grep "' + tab.url() + '" $NOTES_DIR/Reading.md')
      notify("Already stored.");
    } catch(e) {
      currentApp.doShellScript('echo "- [ ' + tab.title() + ' ](' + tab.url() + ')" >> $NOTES_DIR/Reading.md')
      notify(tab.title() + " saved.");
    }
  }
} catch(e) {
  notify("Couldn't find a tab.  Are you in Chrome or Chrome Canary?")
}

function notify(notification) {
  // use currentApp to avoid a privilege violation
  currentApp.displayNotification(notification)
}

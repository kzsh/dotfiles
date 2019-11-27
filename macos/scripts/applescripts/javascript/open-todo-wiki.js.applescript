var app = Application('iterm');

var window = app.createWindowWithDefaultProfile();

var tab = window.currentTab;

var session = tab.currentSession;

app.write(session, {text: "vim -c 'VimwikiIndex'; exit"});
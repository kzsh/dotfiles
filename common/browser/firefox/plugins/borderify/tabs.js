document.addEventListener("DOMContentLoaded", listTabs);

function getCurrentWindowTabs() {
  return browser.tabs.query({ currentWindow: true });
}

function listTabs() {
  getCurrentWindowTabs().then(tabs => {
    let tabsList = document.getElementById("tabs-list");
    let currentTabs = document.createDocumentFragment();
    let limit = 5;
    let counter = 0;

    tabsList.textContent = "";

    for (let tab of tabs) {
      if (!tab.active && counter <= limit) {
        let tabLink = document.createElement("a");

        tabLink.textContent = tab.title || tab.id;

        tabLink.setAttribute("href", tab.id);
        tabLink.classList.add("switch-tabs");
        currentTabs.appendChild(tabLink);
      } else if (e.target.id === "tabs-alertinfo") {
        callOnActiveTab(tab => {
          let props = "";
          for (let item in tab) {
            props += `${item} = ${tab[item]} \n`;
          }
          alert(props);
        });
      }

      counter += 1;
    }
    tabsList.appendChild(currentTabs);
  });
}

document.addEventListener("click", function(e) {
 function callOnActiveTab(callback) {
   getCurrentWindowTabs().then((tabs) => {
     for (var tab of tabs) {
       if (tab.active) {
         callback(tab, tabs);
       }
     }
   });
 }
}


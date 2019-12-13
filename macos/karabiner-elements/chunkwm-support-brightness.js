const { mapKeycodeToKeyCodeWithScript } = require('./build-utils');

function buildBrightnessCommands() {
  return {
    "description": "trigger brightness value script on brightness change",
    "manipulators" : [
      mapKeycodeToKeyCodeWithScript("f1", ["fn"], "f1", ["fn"], "~/.dotfiles/macos/bash/chunkwm-integrations/set_space_brightness_from_current_brightness.sh"),
      mapKeycodeToKeyCodeWithScript("f2", ["fn"], "f2", ["fn"], "~/.dotfiles/macos/bash/chunkwm-integrations/set_space_brightness_from_current_brightness.sh"),
    ]
  };
}

module.exports = buildBrightnessCommands;

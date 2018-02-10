const { mapKeycodeToKeyCode } = require('./build-utils');
const TOGGLE_KEYS = [];

const TOGGLE_MODS = [];
const SOURCE_KEYS = [
  "q", "w", "e", "r", "t",
  "a", "s", "d", "f", "g",
  "z", "x", "c", "v", "b"
]
const SOURCE_MODS = ["right_command"]
const TARGET_KEYS = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

const TARGET_MODS = [
  ["left_shift", "right_command", "left_option"],
  ["left_shift", "right_command", "left_option", "left_control"],
]

const SPACE_COUNT = 15

function buildWorkspaceChangeCommands() {
    let currentTargetModIndex = -1;
    return {
      "description": "Use right_command+q/w/e/r/t/a/s/d/f/g/z/x/c/v/b' to switch current space",
      "manipulators" : SOURCE_KEYS.map(function (srcKey, index) {
        if (index % TARGET_KEYS.length  === 0) {
          currentTargetModIndex++;
        }
        return mapKeycodeToKeyCode(srcKey, SOURCE_MODS, TARGET_KEYS[index % TARGET_KEYS.length], TARGET_MODS[currentTargetModIndex]);
      })
    };
}

module.exports = buildWorkspaceChangeCommands;

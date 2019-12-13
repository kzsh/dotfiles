const { mapKeycodeToKeyCode } = require("./build-utils");

const TOGGLE_VAR_NAME = "altGroup";

const SPACE_KEYS = ["a", "s", "d", "f"];

const MAX_SPACE_COUNT = 60;

// prettier-ignore
const SOURCE_KEYS = [
  "q", "w", "e", "r", "t",
  "a", "s", "d", "f", "g",
  "z", "x", "c", "v", "b"
]

const SOURCE_MODS = ["right_command"];

// prettier-ignore
const TARGET_KEYS = [
  "1", "2", "3", "4", "5", 
  "6", "7", "8", "9", "0",
  "f1", "f2", "f3", "f4", "f5",
  "f6", "f7", "f8", "f9", "f10"
];

const TARGET_MODS = [
  ["left_shift", "left_command", "left_option"],
  ["left_shift", "left_command", "left_control"],
  ["left_shift", "left_command", "left_control", "left_option"]
];

function buildWorkspaceChangeCommands() {
  let currentTargetModIndex = -1;
  let groupIndex = -1;
  return {
    description:
      "Use right_command+q/w/e/r/t/a/s/d/f/g/z/x/c/v/b' to switch current space",
    manipulators: [
      ...SPACE_KEYS.reduce(
        (accum, k, spaceIndex) => [
          ...accum,
          ...TARGET_KEYS.map(function(targetKey, index) {
            const globalIndex = spaceIndex * TARGET_KEYS.length + index;

            if (index === 0) {
              currentTargetModIndex++;
            }

            if (globalIndex % SOURCE_KEYS.length === 0) {
              groupIndex++;
            }

            if (globalIndex >= MAX_SPACE_COUNT) {
              return null;
            }

            return mapKeycodeToKeyCode(
              SOURCE_KEYS[globalIndex % SOURCE_KEYS.length],
              SOURCE_MODS,
              targetKey,
              TARGET_MODS[currentTargetModIndex],
              groupIndex
            );
          })
        ],
        []
      ),
      ...SPACE_KEYS.map((k, i) => ({
        type: "basic",
        from: {
          key_code: k,
          modifiers: {
            mandatory: ["right_command", "right_alt"]
          }
        },
        to: [
          {
            set_variable: {
              name: TOGGLE_VAR_NAME,
              value: i
            }
          },
          {
            shell_command:
              'echo "' + i + '" > ~/.config/karabiner-workspaces/current'
          }
        ]
      }))
    ].filter(Boolean)
  };
}

module.exports = buildWorkspaceChangeCommands;

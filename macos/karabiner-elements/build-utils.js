function mapKeycodeToKeyCode(key, mods, outKey, outMods, group) {
  console.log(
    `key ${key}, outKey ${outKey}, outMods: ${outMods}, Group ${group}`
  );
  return {
    type: "basic",
    from: {
      key_code: key,
      modifiers: {
        mandatory: mods
      }
    },
    to: [
      {
        key_code: outKey,
        modifiers: outMods
      }
    ],
    conditions: [
      {
        type: "variable_if",
        name: "altGroup",
        value: group
      }
    ]
  };
}

function mapKeycodeToKeyCodeWithScript(key, mods, outKey, outMods, scriptPath) {
  return {
    type: "basic",
    from: {
      key_code: key,
      modifiers: {
        mandatory: mods
      }
    },
    to: [
      {
        shell_command: scriptPath
      },
      {
        key_code: outKey,
        modifiers: outMods
      }
    ]
  };
}

module.exports = {
  mapKeycodeToKeyCode,
  mapKeycodeToKeyCodeWithScript
};

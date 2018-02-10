function mapKeycodeToKeyCode(key, mods, outKey, outMods) {
  console.log("mapKeycodeToKeyCode", key, mods, outKey, outMods);
  return {
    "type": "basic",
    "from": {
      "key_code": key,
      "modifiers": {
        "mandatory": mods
      }
    },
    "to": [
      {
        "key_code": outKey,
        "modifiers": outMods
      }
    ]
  }
}

function mapKeycodeToKeyCodeWithScript(key, mods, outKey, outMods, scriptPath) {
  console.log("mapKeycodeToKeyCodeWithScript", key, mods, outKey, outMods, scriptPath);
  return {
    "type": "basic",
    "from": {
      "key_code": key,
      "modifiers": {
        "mandatory": mods
      }
    },
    "to": [
      {
        "shell_command": scriptPath
      },
      {
        "key_code": outKey,
        "modifiers": outMods
      }
    ]
  }
}

module.exports = {
  mapKeycodeToKeyCode,
  mapKeycodeToKeyCodeWithScript
}

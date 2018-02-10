#!/usr/bin/env node
const { promisify } = require('util');
const path = require('path');
const fs = require('fs');
const writeFile = promisify(fs.writeFile);

const buildWorkspaceChangeCommands = require('./chunkwm-support-workspaces')
const buildBrightnessCommands = require('./chunkwm-support-brightness')

const OUT_DIR = path.resolve(__dirname, "assets")
const OUT_FILE = path.resolve(OUT_DIR, "chunkwm-support.json")

function writeResult(data) {
  writeFile(OUT_FILE, JSON.stringify(data, null, 2))
}

function buildFile() {
  let template = baseTemplate();
  const rules = template["rules"];
  rules.push(buildWorkspaceChangeCommands());
  rules.push(buildBrightnessCommands());
  writeResult(template)
}

function baseTemplate() {
  return {
    "title": "Use right_command+q/w/e/r/t/a/s/d/f/g/z/x/c/v/b' to switch current space",
    "rules": []
  }
}

buildFile();

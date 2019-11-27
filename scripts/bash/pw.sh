pass $@ $(rg --files $HOME/.password-store | node -e "
var readline = require('readline');
var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

rl.on('line', function(line){
  const [_, rest] = line.split('.password-store/');
  process.stdout.write(rest.replace(/\.gpg$/gi, '') + '\n');
})
" | fzf)

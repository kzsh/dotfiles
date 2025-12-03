#/usr/bin/env bash
_scratch_completions()
{
  COMPREPLY=($(compgen -W "$(find "$HOME/.scratch_pad" -type f -print0 | sed "s#$HOME/.scratch_pad/##g"| xargs -0 -L 1 echo)" "${COMP_WORDS[1]}"))
}

complete -F _scratch_completions scratch 

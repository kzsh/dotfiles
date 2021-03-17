if command -v crc > /dev/null 2>&1;  then
  if crc ip > /dev/null 2>&1; then
    echo "we think we found it"
    export PATH="$HOME/.crc/bin/oc:$PATH"
    eval $(crc oc-env)
  fi
fi

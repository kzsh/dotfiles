if command -v oc 2>&1 > /dev/null; then
  source <(oc completion bash) 
else 
  echo "Skipping OpenShift: no executable \`oc\` found"
fi

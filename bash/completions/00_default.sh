if command -v tofu &>/dev/null; then
  complete -C /usr/bin/tofu tofu
fi

COMPLETION_COMMANDS=(helm helmfile k3d kubectl)
for cmd in "${COMPLETION_COMMANDS[@]}"; do
  if command -v "$cmd" &>/dev/null; then
    source <("$cmd" completion bash)
  fi
done

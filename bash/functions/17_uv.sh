if [[ -n "$(command -v uv 2>/dev/null)" ]]; then
  source <(uv generate-shell-completion bash)
fi


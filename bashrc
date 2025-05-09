alias cursor="/c/Users/Marius/AppData/Local/Programs/cursor/resources/app/bin/code"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

fcd() {
  if [[ ! -f ~/.project_dirs ]]; then
    find "$HOME/dev" -type d -name ".git" \
      ! -path "*/node_modules/*" \
      2>/dev/null | sed 's/\/.git$//' > ~/.project_dirs
  fi
  local dir
  dir=$(cat ~/.project_dirs | fzf) && cd "$dir"
}

alias refresh-projects='rm ~/.project_dirs && echo "🔄 Project list refreshed!"'






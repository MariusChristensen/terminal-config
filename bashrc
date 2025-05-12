alias cursor="/c/Users/Marius/AppData/Local/Programs/cursor/resources/app/bin/code"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

fcd() {
  if [[ ! -f ~/.project_dirs ]]; then
    find "$HOME/dev" -type d -name ".git" \
      ! -path "*/node_modules/*" \
      2>/dev/null | sed 's/\/.git$//' > ~/.project_dirs
  fi
  local dir
  dir=$(cat ~/.project_dirs | fzf --exact) && cd "$dir"
}

alias refresh-projects='rm ~/.project_dirs && echo "□^=^t^d Project list refreshed!"'
alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'
alias dev='cd ~/dev'
alias proj='cd ~/dev/Personal'
alias reload='source ~/.bashrc'
alias glog='git log --oneline --graph --all --decorate'
alias bashopen='nano ~/.bashrc' 
alias g='git '
alias gc='git commit -m '
alias ga='git add '
alias gpu='git push -u origin '
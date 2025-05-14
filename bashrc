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

startup() {
    echo "🌞 Hello Marius! Time to work!"

    # Open tabs in Chrome
    start chrome \
    "https://facebook.com" \
    "https://www.kode24.no" \
    "https://www.vg.no" \
    "https://github.com/MariusChristensen" \
    "https://www.youtube.com/@ThePrimeTimeagen"
}

ghcreate() {
  foldername=${PWD##*/}

  # Check if origin remote exists
  if git remote get-url origin >/dev/null 2>&1; then
    echo "🚨 Remote 'origin' already exists. Aborting ghcreate to prevent disaster!"
    return 1
  fi

  # Create GitHub repo
  gh repo create "$foldername" "$@" --source=. --remote=origin

  # Push current branch after repo creation
  current_branch=$(git symbolic-ref --short HEAD)
  git push -u origin "$current_branch"
  echo "✅ Repo created & local branch '$current_branch' pushed to GitHub ($foldername)"
}

alias refresh-projects='rm ~/.project_dirs && echo "✅ Project list refreshed!"'
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
alias gs='git status '
alias gf='git fetch '
alias gm='git merge '
alias gp='git pull '
alias ga='git add '
alias gc='git commit -m '
alias gpu='git push -u origin '
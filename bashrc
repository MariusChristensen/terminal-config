alias cursor="/c/Users/Marius/AppData/Local/Programs/cursor/resources/app/bin/code"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

gbcreate() {
  if [ -z "$1" ]; then
    echo "Usage: gbcreate <new-branch-name> [<base-branch>]"
    return 1
  fi

  local new_branch="$1"

  # Auto-fix missing origin/HEAD (main/master detection)
  git remote set-head origin -a >/dev/null 2>&1

  # Detect default base branch or use user-supplied
  local base_branch="${2:-$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo main)}"

  # Check if branch already exists locally
  if git rev-parse --verify "$new_branch" >/dev/null 2>&1; then
    echo "✗ Branch '$new_branch' already exists locally."
    return 1
  fi

  # Fetch refs
  git fetch || return 1

  # Create and switch
  if git switch -c "$new_branch" "origin/$base_branch"; then
    echo "✓ Created and switched to '$new_branch' from 'origin/$base_branch'"
  else
    echo "✗ Failed to create from origin/$base_branch — does it exist?"
    return 1
  fi

  # Ask to push
  read -p "Push '$new_branch' to remote and set upstream? (y/N): " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    git push -u origin "$new_branch" && echo "↑ Branch pushed and tracking set"
  fi
}


gbdelete() {
  if [ -z "$1" ]; then
    echo "Usage: gdelete <branch-name>"
    return 1
  fi

  local branch="$1"

  git branch -d "$branch"
  git push origin --delete "$branch"
  git fetch --prune

  echo "□^|^e Cleanup complete for '$branch'."
}

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
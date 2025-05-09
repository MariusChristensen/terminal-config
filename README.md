# 💻 Marius's Terminal Config

A portable setup for Git Bash, fzf, and Windows Terminal that lets me jump between Git projects instantly.

---

## 🚀 Install Guide (New Computer)

### 1. Install Dependencies

- [Git for Windows (Git Bash)](https://git-scm.com/download/win)
- [Windows Terminal](https://aka.ms/terminal)
- [JetBrains Mono font](https://www.jetbrains.com/lp/mono/) (used in the terminal theme)

---

### 2. Clone this repo

```bash
git clone https://github.com/mariusbolik/terminal-config.git
cd terminal-config
```

### 3. Set up .bashrc

```bash
cp bashrc ~/.bashrc
source ~/.bashrc
```

Enables:

- `fcd` → fuzzy-jump between Git project folders in `$HOME/dev`
- `refresh-projects` → refresh the project list after adding/removing repos
- Cursor editor alias (if installed)

### 4. Install fzf

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

Choose default options during install.

### 5. Restore Windows Terminal Theme

```bash
cp windows-terminal-settings.json "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_*/LocalState/settings.json"
```

Then restart Windows Terminal.

Features:

- Cobalt 2 color scheme
- JetBrains Mono font
- Git Bash as default profile
- Custom keybindings

## ✅ Done!

You're now ready to jump around your projects like a beast. 🧙‍♂️

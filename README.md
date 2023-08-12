# Setup on a new computer

## 1. Clone the repo
```bash
git clone --bare https://www.github.com/jonawe/.dotfiles $HOME/.dotfiles
```

## 2. Setup temporary alias
```bash
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

## 3. Checkout the current version
```bash
config checkout
```

## 4. Ignore the gitfiles from the config itself
```bash
echo ".dotfiles" >> .gitignore
```

## 5. Do not show untracked files
```bash
config config --local status.showUntrackedFiles no
```

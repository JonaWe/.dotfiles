# Setup on a new computer

## 1. Clone the repo

```bash
git clone  https://www.github.com/jonawe/.dotfiles $HOME/dotfiles
```

## 2. Install dependencies

```bash
sudo pacman -S stow
```

## 3. Run Stow Command

```bash
stow .
```

### 3.1. If command fails adopt existing files

```bash
stow . --adopt
```

### 3.2 Delete adopted files if necessary

```bash
git restore --source=HEAD --staged --worktree .
```

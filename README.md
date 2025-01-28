# Dotfiles

- Non-sensitive configuration files
    - Brew
    - Stow
    - MesloLGS NF Font
    - Iterm2
    - VSCode
- Sensitive configuration files
    - migration.sh

## Non-sensitive

### Brew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle install --file=Brewfile
```

### Stow

```bash
./install.sh
```

### MesloLGS NF Font

```bash
installFonts(){
    # Install the fonts manually and trigger fontBook
    FONT_NAME="MesloLGS\ NF\ Regular.ttf"
    curl -L "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf" --output $HOME/Downloads/$FONT_NAME
    open -b com.apple.FontBook $HOME/Downloads/$FONT_NAME
}
installFonts
```

### Iterm2

1. Set color preset to `Solarized Dark` at `Preferences > Profiles > Colors`
2. Set font to `MesloLGS NF` at `Preferences > Profiles > Text`

### VSCode

1. Set font to `MesloLGS NF` at `Settings > Editor: Font Family`
2. Set color theme to `One Dark Pro` at `Settings > Color Theme`
3. Set `autoSave` to `afterDelay` at `Settings > Files: Auto Save`

### Oh My Zsh

```bash
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# p10k theme & autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

## Sensitive

Edit `sensitive_dotfiles` variable in `migration.sh` to include the files you want to migrate.

```bash
./migrate.sh dump
./migrate.sh dump --dry-run=false
```

```bash
./migrate.sh load
./migrate.sh load --dry-run=false
```
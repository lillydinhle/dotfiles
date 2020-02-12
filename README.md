# dotfiles

## Requirements 🗝

- MacOS

## Installation 💾

1. Clone the repository and navigate to the cloned directory:

```sh
$ git clone https://github.com/lillydinhle/dotfiles ~/.dotfiles && cd ~/.dotfiles
```

2. Install Homebrew and required packages:

```sh
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && brew bundle --file="mac/Brewfile"
```

2. Bootstrap configuration by symlinking the necessary files into the default configuration locations by running:

```sh
$ bootstrap/symlink
```

## Applying terminal color scheme 🎨

1. Double-click `mac/Pastel.terminal` to open your Terminal with the color scheme applied
2. Set the color scheme as your default scheme with `Shell > Use Settings as Default`

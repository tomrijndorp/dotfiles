# `.dotfiles` [![CircleCI][badge]][ci]

If you're not me, this is probably not for you. There are better starting points for using dotfiles I'm sure!
But perhaps this is useful for inspiration...

## Installation
1. `git clone git@github.com:tomrijndorp/dotfiles.git ~/.dotfiles`
2. `~/.dotfiles/system/bin/dot install all`

## Features

**`PATH_PRE_FILE` (default: `~/.path_pre`)**  
**`PATH_POST_FILE` (default: `~/.path_post`)**

Files with one path entry per line. Will be prepended / appended to the default `PATH`.
Ignored when not present.

**`~/.zshrc_hook.sh`**  
`.dotfiles` replaces your standard `~/.zshrc` with the one that is defined in this repo. File that is called into as part of the normal `~/.zshrc`.

## Installers

You can place any installer (it's really just a script that gets `source`d) under `installers`.

**These scripts _must_ be reentrant.** That is, in the sense that calling them again should yield the same
result. Up to you whether that means reinstalling or skipping installation if you can determine the thing
was already installed.



## Other installations to consider for Mac
VirtualBox
XCode
Wunderlist
Unreal Engine
iTerm2
Reaper
Steam

## Current issues
The stock Ubuntu bashrc contains quite a bit of logic and it's probably there for a reason. Might
want to find a way to have that thing remain and have it call your entrypoint instead.

## TODOs
- Automatically set zsh as default shell: modify /etc/shells
- Sublime snippets and configuration, packages, etc

[ci]: https://app.circleci.com/pipelines/github/tomrijndorp/dotfiles
[badge]: https://circleci.com/gh/tomrijndorp/dotfiles.svg?style=svg&circle-token=2490c976885733e39d74aaf534213a883103066c
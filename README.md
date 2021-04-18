# `.dotfiles` 
[![CircleCI][badge]][ci]

Like so many of these repos, this started off as a project that is really only useful
to its creator. I think this is still mainly true, but by now, if you happen to stumble
upon this repo, you might want to fork it or use as/is.

## Features

**1. Supports Mac and Linux**  
Because I use both daily.

**2. Tested in CI**  
See the build badge. On every commit, I try installing the whole shebang in a plain
Ubuntu image. Should give some confidence. Added plus: the Linux install can run
completely unattended.  
The Mac version needs the XCode developer tools, which are installed through a GUI.

**3. Sensible defaults**  
At least for me `:)`
- `zsh` is the default shell
- `vim` with Vundle plugins

All this stuff is easy to modify, but you'll probably want to fork the repo. This thing
is not built to support different users with different needs at the same time.

**4. Easy-ish hooks for extending stuff**
The main motivation for this was that I need to store secrets / other corporate data
in my environment. So I created "hooks" that I call into to extend the environment.
This way, you can store machine-specific info without having to modify files in this
repo.

**`PATH_PRE_FILE` (default: `~/.path_pre`)**  
**`PATH_POST_FILE` (default: `~/.path_post`)**

Files with one path entry per line. Will be prepended / appended to the default `PATH`.
Ignored when not present. Example `~/.path_pre`:  
```sh
# Comments work.
/company/tools/bin
~/foo/bar/bin
```
will result in `PATH` being e.g.
`/company/tools/bin:~/foo/bar/bin:/usr/bin/:<more>:usr/local/bin`.

**`~/.zshrc_hook.sh`**  
`.dotfiles` replaces your standard `~/.zshrc` with the one that is defined in this repo. File that is called into as part of the normal `~/.zshrc`.

**`.gitconfig_local`**
This script installs a new `.gitconfig` file that uses includes to point to a curated
config file in this repo. If you want to add your own, store those changes in
`.gitconfig_local`.

**5. Choose what to install**
All install scripts are located under `installers`. Using `dot install all` you can do a
batch install, but you'll be given an opportunity to filter out targets by modifying a
generated text file.

## Installation
Alright. I put this here so you wouldn't immediately try to install this stuff. If you
still think using this is a good idea, you might as well give it a shot.
1. `git clone git@github.com:tomrijndorp/dotfiles.git ~/.dotfiles`
2. `~/.dotfiles/system/bin/dot install all`

<hr />

## More detail

### Installers

You can place any installer (it's really just a script that gets `source`d) under `installers`.

Intended behavior of any of these scripts: Running them again must be either a no-op if
the thing is already installed, or a reinstall. It's not allowed to fail (such that you
can easily run `install all` again in case any step failed).

### Current issues
The stock Ubuntu bashrc contains quite a bit of logic and it's probably there for a reason. Might
want to find a way to have that thing remain and have it call your entrypoint instead.

### TODOs
- ...

[ci]: https://app.circleci.com/pipelines/github/tomrijndorp/dotfiles
[badge]: https://circleci.com/gh/tomrijndorp/dotfiles.svg?style=svg&circle-token=2490c976885733e39d74aaf534213a883103066c
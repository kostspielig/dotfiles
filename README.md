dotfiles
========

So, here is another place in the Internet where someone is backing up
her configuration files.  To use them, try out using `GNU Stow` as
described [in this
article](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html).
Here are some details about the provided configurations.

Stow can be use with top level dependencies, in this case: `bash,
emacs, xmonad, git`

emacs
-----

Configuration for GNU Emacs 24 from Debian Sid.  You might need to
install extra packages like `chktex`, but I have lost track of all
what you need.

To install all required packages run
`package-install-selected-packages`

You also need to install tern by running  `npm install -g tern`.


xmonad
------

This is the configuration for `xmonad`.  It also requires a very
recent `taffybar`, that you can just grab [from
upstream](https://github.com/travitch/taffybar).  Check `xmonad.hs` to
figure out all the other dependencies, like `suckless-tools`,
`cinnamon`, among others.

It also depends on
[wallpaperd](https://projects.pekdon.net/projects/wallpaperd) which
may be installed separatelly.

After installing the configuration, you may need to do:

### Extra stuff to make it work good

#. `xdotool`, the version in _deps/xdotool

```
    git update _deps/xdotool
    cd _deps/xdotool
    sudo apt install libxtst-dev libxkbcommon-dev
    make
    sudo make install
```

#. `sudo apt instal wmctrl`

#. Our version of the `numix` theme (maybe):

```
git submodule update xmonad/.themes/Numix
cd ~/.themes/Numix
make
```


bash
----

Here is some bash stuff.  Now it is all modularized in a `.bash.d`
folder, with `.bash.d/init.bash` being the entry point.

git
---

Git configuration too, yeah!

nixos
-----

Basic configuration for NixOS (:

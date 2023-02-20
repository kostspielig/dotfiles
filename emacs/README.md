# Emacs

Configuration for GNU Emacs 24 from Debian Sid.  You might need to
install extra packages like `chktex` or `texlive-bin` in arch, but I
have lost track of all what you need.

To install all required packages run
`package-install-selected-packages`

You also need to install:
* _tern_ by running `npm install -g tern`.
* _ag_ by running `sudo apt install silversearcher-ag` or `sudo pacman -S the_silver_searcher`



## Magit

See all documentaion [here](https://magit.vc/manual/magit.html#Getting-Started)

* `C-x g` Display information about the current Git repository in a dedicated buffer (the status buffer)
* `s` to stage files
* `C-c C-c` to create the actual commit.
* `P` Push changes

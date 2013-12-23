moo-zsh
=============

mooOS zsh configuration

Depends on: zsh zsh-syntax-highlighting zsh-completions

Install with
------------

    $ makepkg -sfi PKGBUILD

example:
    
     $ rm -rf ~/abs/moo-zsh && mkdir -p ~/abs/moo-zsh && cd ~/abs/moo-zsh && wget https://raw.github.com/idk/zsh/master/moo-zsh.install && wget https://raw.github.com/idk/zsh/master/PKGBUILD && makepkg -sfi

Remove with
-----------

    # pacman -Rs moo-zsh

Configure with
--------------

    $ cp /usr/share/moo-zsh/zshrc ~/.zshrc
    
    $ cp /usr/share/moo-zsh/zprofile ~/.zprofile
    
    $ cp /usr/share/moo-zsh/zsh ~/.zsh

SUPPORT
-------

[The Linux Distro Community][1]

[pdq][2]


Contributing
------------

1. Fork it.
2. Create a branch (`git checkout -b my_foo_bar`)
3. Commit your changes (`git commit -am "Added foo and bar"`)
4. Push to the branch (`git push origin my_foo_bar`)
5. Create an [Issue][2] with a link to your branch
6. Join the Linux Distro Community IRC! :D

SHARE AND ENJOY!
----------------

[1]: http://www.linuxdistrocommunity.com
[2]: https://github.com/idk/gtmsu_servicemenu/issues
[3]: http://tmsu.org

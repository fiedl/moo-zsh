# Maintainer: pdq <pdq@localhost>
pkgname=moo-zsh
pkgver=0.10
pkgrel=1
pkgdesc="mooOS zsh configuration"
arch=(any)
url="https://github.com/idk/zsh.git"
license=('GPL3')
makedepends=('git')
depends=('zsh' 'zsh-syntax-highlighting' 'zsh-completions')
#conflicts=('abc' 'xyz')
#source=("")
#md5sums=('SKIP')

_gitroot="git://github.com/idk/zsh.git"
_gitname="moo-zsh"

install=$pkgname.install

build() {
	cd "$srcdir"
	msg "Connecting to GIT server...."

	if [ -d $pkgname ] ; then
		cd $pkgname && git pull origin
		msg "The local files are updated."
	else
		git clone $_gitroot $pkgname
		cd $pkgname
	fi
	msg "GIT checkout done or server timeout"
}

package() {
	cd "$srcdir/$pkgname/"
    install -d "${pkgdir}/usr/share/$pkgname"
    cp -r "$srcdir/$pkgname/" "${pkgdir}/usr/share/"

	msg2 "Installing mooOS zsh configs${pkgver}."
    install -d "${pkgdir}/usr/share/$pkgname"
    cp -r "$srcdir/$pkgname/.zsh/git-prompt" "${pkgdir}/usr/share/$pkgname/zsh/"
	install -D -m 644 ".zprofile" "$pkgdir/usr/share/$pkgname/zprofile"
	install -D -m 644 ".zshrc" "$pkgdir/usr/share/$pkgname/zshrc"
}
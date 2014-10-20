# Maintainer: pdq <pdq@localhost>
pkgname=moo-zsh
pkgver=0.2
pkgrel=8
pkgdesc="mooOS zsh configuration"
arch=(any)
url="https://github.com/idk/zsh.git"
license=('GPL3')
makedepends=('git')
depends=('zsh' 'zsh-syntax-highlighting' 'zsh-completions')
groups=moo
#conflicts=('abc' 'xyz')
source=('git://github.com/idk/zsh.git')
sha512sums=('SKIP')

install=$pkgname.install

package() {
	install -d "${pkgdir}/usr/share/$pkgname"
    cp -r "$srcdir/zsh/.zsh/git-prompt" "${pkgdir}/usr/share/$pkgname/zsh/"
	install -Dm 644 "$srcdir/zsh/.zprofile" "$pkgdir/usr/share/$pkgname/zprofile"
	install -Dm 644 "$srcdir/zsh/.zshrc" "$pkgdir/usr/share/$pkgname/zshrc"
}
# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/deluge/deluge-1.1.1.ebuild,v 1.1 2009/01/25 14:10:04 armin76 Exp $

EAPI="2"

inherit eutils distutils flag-o-matic

DESCRIPTION="BitTorrent client with a client/server model."
HOMEPAGE="http://deluge-torrent.org/"
SRC_URI="http://download.deluge-torrent.org/source/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk"

DEPEND=">=dev-lang/python-2.4
	dev-python/setuptools
	|| ( >=dev-libs/boost-1.34 =dev-libs/boost-1.33*[threads] )"
RDEPEND="${DEPEND}
	dev-python/pyxdg
	dev-python/pygobject
	gtk? (
		>=dev-python/pygtk-2
		dev-python/pyxdg
		dev-python/dbus-python
		gnome-base/librsvg
	)"

pkg_setup() {
	filter-ldflags -Wl,--as-needed
}

src_install() {
	distutils_src_install
	newinitd "${FILESDIR}"/deluged.init deluged
	newconfd "${FILESDIR}"/deluged.conf deluged
}

pkg_postinst() {
	elog
	elog "If after upgrading it doesn't work, please remove the"
	elog "'~/.config/deluge' directory and try again, but make a backup"
	elog "first!"
	elog
	einfo "Please note that Deluge is still in it's early stages"
	einfo "of development. Use it carefully and feel free to submit bugs"
	einfo "in upstream page."
	elog
	elog "To start the daemon either run 'deluged' as user"
	elog "or modify /etc/conf.d/deluged and run"
	elog "/etc/init.d/deluged start as root"
	elog "You can still use deluge the old way"
	elog
	elog "For more information look at http://dev.deluge-torrent.org/wiki/Faq"
	elog
}

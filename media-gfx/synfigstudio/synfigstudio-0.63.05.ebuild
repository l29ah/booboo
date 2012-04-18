# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils fdo-mime

DESCRIPTION="Main UI of synfig: Film-Quality Vector Animation"
HOMEPAGE="http://www.synfig.org/"
SRC_URI="mirror://sourceforge/synfig/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fmod"

DEPEND="
	dev-cpp/gtkmm:2.4
	>=media-gfx/synfig-${PV}
	dev-libs/libsigc++:2"
RDEPEND=${DEPEND}

src_configure() {
	econf --disable-update-mimedb
}

src_install() {
	emake DESTDIR="${D}" install

	doicon images/synfig_icon.svg
	domenu synfigstudio.desktop
}

pkg_postinst() {
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
}


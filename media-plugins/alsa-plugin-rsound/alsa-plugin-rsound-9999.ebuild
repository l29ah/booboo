# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit autotools base git-2

DESCRIPTION="RSound plugin for ALSA"
HOMEPAGE="http://themaister.net/rsound.html"
SRC_URI=""
EGIT_REPO_URI="git://github.com/Themaister/alsa-plugins-rsound.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
SRC_URI=""

IUSE=""

RDEPEND="
	media-libs/alsa-lib
	media-sound/rsound
"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
}

src_compile() {
	cd "${S}/rsound"
	emake
}

src_install() {
	cd "${S}/rsound"
	emake DESTDIR="$D" install
}

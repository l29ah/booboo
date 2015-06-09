# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit versionator autotools eutils

DESCRIPTION="The Matchbox Desktop"
HOMEPAGE="http://matchbox-project.org/"
SRC_URI="http://matchbox-project.org/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~arm ~hppa ~ppc ~x86"
IUSE="debug dnotify startup-notification"

DEPEND=">=x11-libs/libmatchbox-1.5
	startup-notification? ( x11-libs/startup-notification )"

RDEPEND="${DEPEND}
	x11-wm/matchbox-common"

DOCS=( AUTHORS ChangeLog INSTALL NEWS README )

src_prepare() {
	epatch "${FILESDIR}/${P}-dlopen.patch"
	eautoreconf
}

src_configure() {
	econf	$(use_enable debug) \
		$(use_enable startup-notification) \
		$(use_enable dnotify)
}

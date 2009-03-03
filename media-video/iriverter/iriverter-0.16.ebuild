# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="iriverter is a simple video converter for portable media players"
HOMEPAGE="http://iriverter.sourceforge.net/"
SRC_URI="mirror://sourceforge/iriverter/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gcj"

RDEPEND=">=media-video/mplayer-1.0_rc2_p25993"

DEPEND="${RDEPEND}
	>=dev-java/swt-3.2_rc2"

pkg_setup() {
	if use gcj && ! built_with_use sys-devel/gcc gcj; then
		eerror "GCC was not built with GCJ support!"
		eerror "Rebuild sys-devel/gcc with \"gcj\" in your use-flags."
		die "no gcj"
	fi
}

src_compile() {
	econf \
		$(use_with gcj) \
		--with-swt=`java-config -p swt-3` \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
}

pkg_postinst() {
	if ! built_with_use media-video/mplayer encode; then
		ewarn "iriverter requires MPlayer to have MEncoder!"
		ewarn "Rebuild media-video/mplayer with \"encode\" in your use-flags."
	fi
	
	if ! built_with_use media-video/mplayer xvid; then
		ewarn "iriverter requires MPlayer to have XviD support!"
		ewarn "Rebuild media-video/mplayer with \"xvid\" in your use-flags."
	fi
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/wmii/wmii-3.6-r2.ebuild,v 1.3 2009/07/13 13:17:29 omp Exp $

inherit eutils multilib toolchain-funcs

MY_P="wmii+ixp-${PV/_beta/b}"

DESCRIPTION="A dynamic window manager for X11"
HOMEPAGE="http://wmii.suckless.org/"
SRC_URI="http://dl.suckless.org/wmii/$MY_P.tbz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}
	x11-apps/xmessage
	x11-apps/xsetroot
	x11-misc/dmenu
	media-fonts/font-misc-misc"

src_unpack() {
	unpack ${A}
	cd "$MY_P"

	sed -i -e "s/dmenu -b/dmenu/" \
		rc/{sh.wmii,wmiirc.sh} || die "sed failed"

	sed -i \
		-e "/^PREFIX/s|=.*|= ${D}/usr|" \
		-e "/^ETC/s|=.*|= ${D}/etc|" \
		-e "/^LIBDIR/s|=.*|= /usr/$(get_libdir)|" \
		config.mk || die "sed failed"
}

src_compile() {
	cd "$MY_P"
	emake -j1 || die "emake failed"
}

src_install() {
	cd "$MY_P"
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	dodoc NOTES README TODO

	# Rid paths of temporary install directory. (bug #199551)
	sed -i -e "s|${D}||g" "${D}/usr/bin/wmiistartrc"

	echo -e "#!/bin/sh\n/usr/bin/wmii" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}"

	insinto /usr/share/xsessions
	doins "${FILESDIR}/${PN}.desktop"
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dmenu/dmenu-4.0.ebuild,v 1.5 2009/09/05 00:10:49 ranger Exp $

EAPI=3

inherit eutils toolchain-funcs savedconfig

DESCRIPTION="a generic, highly customizable, and efficient menu for the X Window System"
HOMEPAGE="http://www.suckless.org/programs/dmenu.html"
SRC_URI="http://pkgs.fedoraproject.org/repo/pkgs/dmenu/dmenu-4.0.tar.gz/66e761a653930cc8a21614ba9fedf903/dmenu-4.0.tar.gz
	dmenu_path? ( http://tools.suckless.org/dmenu/patches/legacy/dmenu_path.c )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE="xinerama xft unicode +dmenu_path vanilla"

DEPEND="x11-libs/libX11
	xinerama? ( x11-libs/libXinerama )"
RDEPEND=${DEPEND}

src_prepare() {
	sed -i \
		-e "s/CFLAGS = -std=c99 -pedantic -Wall -Os/CFLAGS += -std=c99 -pedantic -Wall -g/" \
		-e "s/LDFLAGS = -s/LDFLAGS += -g/" \
		-e "s/XINERAMALIBS =/XINERAMALIBS ?=/" \
		-e "s/XINERAMAFLAGS =/XINERAMAFLAGS ?=/" \
		config.mk || die "sed failed"

	use vanilla || {
		if use xft; then
			epatch "${FILESDIR}/${P}-xft.diff"
			use unicode && epatch "${FILESDIR}/${P}-xft-unicode.diff"
		fi
	}
	if use savedconfig; then
		restore_config config.h
	fi
}

src_compile() {
	local msg
	use savedconfig && msg=", please check the configfile"
	if use xinerama; then
		emake CC=$(tc-getCC) || die "emake failed${msg}"
	else
		emake CC=$(tc-getCC) XINERAMAFLAGS="" XINERAMALIBS="" \
			|| die "emake failed${msg}"
	fi
	if use dmenu_path; then
		rm dmenu_path
		cc $CFLAGS "$DISTDIR/dmenu_path.c" -o dmenu_path
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"

	insinto /usr/share/${PN}
	newins config.h ${PF}.config.h

	dodoc README

	save_config config.h
}

pkg_postinst() {
	einfo "This ebuild has support for user defined configs"
	einfo "Please read this ebuild for more details and re-emerge as needed"
	einfo "if you want to add or remove functionality for ${PN}"
}

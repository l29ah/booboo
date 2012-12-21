# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/shell-fm/shell-fm-0.6.ebuild,v 1.2 2009/05/09 14:40:22 ssuominen Exp $

EAPI=2
inherit toolchain-funcs git

DESCRIPTION="A lightweight console based player for Last.FM radio streams"
HOMEPAGE="http://nex.scrapping.cc/shell-fm/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/jkramer/shell-fm.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="ao"

RDEPEND="media-libs/libmad
	ao? ( media-libs/libao )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i -e "s:-Os:${CFLAGS}:g" source/Makefile || die "sed failed"
	use ao || sed -i -e "s:\$(LIBAO)::g" source/Makefile || die "sed failed"
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
}

src_install() {
	dobin source/${PN} || die "dobin failed"
	doman manual/${PN}.1
	exeinto /usr/share/${PN}/scripts
	doexe scripts/{*.sh,*.pl,zcontrol} || die "doexe failed"
}


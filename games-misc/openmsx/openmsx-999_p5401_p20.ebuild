# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/openmsx/openmsx-0.3.1-r1.ebuild,v 1.6 2015/01/28 10:22:58 ago Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit python-any-r1 games

PV2=${PV/999_/}
PV3=${PV2//_/-}
MY_PV=${PV3//p/}
MY_P=${PN}-${MY_PV%-*}

DESCRIPTION="An ambiguously named music replacement set for OpenTTD"
HOMEPAGE="http://bundles.openttdcoop.org/openmsx/"
SRC_URI="http://bundles.openttdcoop.org/${PN}/nightlies/v${MY_PV}/${MY_P}-source.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"

S=${WORKDIR}/${MY_P}-source

pkg_setup() {
	python-any-r1_pkg_setup
	games_pkg_setup
}

src_prepare() {
	# work with later versions of unix2dos from app-text/dos2unix
	sed -i -e '/^UNIX2DOS_FLAGS/s/null/null >&2/' Makefile || die
}

#src_compile() {
#	emake || die
#}

src_install() {
	insinto "${GAMES_DATADIR}"/openttd/gm/${P}
	doins ${PN}/{*.mid,openmsx.obm} || die
	dodoc ${PN}/{changelog.txt,readme.txt} || die
	prepgamesdirs
}

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/opensfx/opensfx-0.2.3.ebuild,v 1.9 2015/02/06 21:43:18 tupone Exp $

EAPI=5
inherit games

PV2=${PV/999_/}
PV3=${PV2//_/-}
MY_PV=${PV3//p/}
MY_P=${PN}-${MY_PV%-*}

DESCRIPTION="OpenSFX data files for OpenTTD"
HOMEPAGE="http://bundles.openttdcoop.org/opensfx/"
SRC_URI="http://bundles.openttdcoop.org/${PN}/nightlies/v${MY_PV}/${MY_P}-source.tar.xz"

LICENSE="CC-Sampling-Plus-1.0"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86"
IUSE=""

DEPEND="games-util/catcodec"
RDEPEND=""

S=${WORKDIR}/${MY_P}-source

src_prepare() {
	# work with later versions of unix2dos from app-text/dos2unix
	sed -i -e '/^UNIX2DOS_FLAGS/s/null/null >&2/' Makefile || die
}

src_install() {
	insinto "${GAMES_DATADIR}"/openttd/data/
	doins opensfx.cat opensfx.obs
	dodoc docs/{changelog.txt,readme.ptxt}
	prepgamesdirs
}

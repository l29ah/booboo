# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games

texts_uri=http://simutrans-germany.com/translator/data/tab/language_pack-Base+texts.zip

DESCRIPTION="Language pack for Simutrans"
HOMEPAGE="http://www.simutrans.com/"
SRC_URI=""

LICENSE="Artistic"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="games-simulation/simutrans-exp"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
	mkdir -p "${S}/simutrans/text"
	cd "${S}/simutrans/text"

	wget ${texts_uri} -O simutrans-exp-language_pack-Base+texts.zip

	unpack ./simutrans-exp-language_pack-Base+texts.zip
	cd "${S}"
}

src_install() {
	insinto "${GAMES_DATADIR}"/simutrans-exp
	doins -r simutrans/* || die "doins failed"
}


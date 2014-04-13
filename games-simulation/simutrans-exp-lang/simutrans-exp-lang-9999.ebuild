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
	#do as in get_lang_files.sh (last seen rev 3fca29d44c67728ca38ef387a4e3c262602ddfbb)
	wget --post-data "version=0&choice=all&submit=Export!"  --delete-after http://simutrans-germany.com/translator/script/main.php?page=wrap || die "generate file language_pack-Base+texts.zip failed (wget returned $?)"
	wget -N ${texts_uri} -O simutrans-exp-language_pack-Base+texts.zip || die "download of file language_pack-Base+texts.zip failed (wget returned $?)"

	unpack ./simutrans-exp-language_pack-Base+texts.zip
	cd "${S}"
}

src_install() {
	insinto "${GAMES_DATADIR}"/simutrans-exp
	doins -r simutrans/* || die "doins failed"
}


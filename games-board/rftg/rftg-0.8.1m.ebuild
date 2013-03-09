# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit games autotools

DESCRIPTION="\"Race for the Galaxy\" card game."
HOMEPAGE="http://dl.dropbox.com/u/7379896/rftg/index.html"
SRC_URI="http://warpcore.org/rftg/rftg-0.8.1.tar.bz2
http://dl.dropbox.com/u/7379896/rftg/rftg-0.8.1m-source.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="x11-libs/gtk+:2"
RDEPEND="${DEPEND}"

src_unpack()
{
	unpack rftg-0.8.1.tar.bz2
	cd rftg-0.8.1
	unpack rftg-0.8.1m-source.zip
	S=`pwd`
}

src_prepare()
{
	epatch ${FILESDIR}/fix.patch
	eautoreconf
}

src_compile()
{
	games_src_compile

	for p in `seq 2 6`
	do
		for e in `seq 0 3`
		do
			./learner -e $e -p $p -f 100 -n 1 &
			./learner -e $e -p $p -f 100 -n 1 -a
			wait
		done
	done

}

src_install()
{
	dobin rftg || die

	#cards.txt, images.data
	insinto ${GAMES_DATADIR}/rftg/
	doins cards.txt images.data

	#network
	insinto ${GAMES_DATADIR}/rftg/network/
	doins network/*.net

	insinto ${GAMES_DATADIR}/rftg/image/
	doins icon*.png
}


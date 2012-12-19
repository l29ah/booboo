# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Last.fm scrobbler for cmus music player"
HOMEPAGE="http://arkq.awardspace.us/Multimedia/cmusfm/"
SRC_URI="http://dl.dropbox.com/u/15563529/cmusfm/${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64 "
IUSE=""

DEPEND="
	media-sound/cmus
	net-misc/curl"
RDEPEND="${DEPEND}"

src_install() {
	install -Dm755 cmusfm "${D}/usr/bin/cmusfm"
}

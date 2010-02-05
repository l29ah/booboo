# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="K is a proprietary array processing language."
HOMEPAGE="http://kx.com/"
SRC_URI="$PN.zip"

LICENSE="kdb+"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="fetch"
IUSE="readline"

DEPEND="app-arch/unzip"
RDEPEND="readline? ( app-misc/rlwrap )"

pkg_nofetch() {
    eerror "Please go to:"
    eerror "  ${HOMEPAGE}"
    eerror "select your platform and download kdb+"
    eerror "Then after downloading name it \"$SRC_URI\" and put it in:"
    eerror "  ${DISTDIR}"
}

src_unpack() {
	unzip "${DISTDIR}/$SRC_URI"
}

src_install() {
	dodir /opt
	mv q $D/opt/q
	dodir /usr/bin
	qrun='QHOME=/opt/q'
	use readline && qrun="$qrun rlwrap"
	qrun="$qrun"' /opt/q/l32/q "$@"'
	echo $qrun > $D/usr/bin/q
	chmod +x $D/usr/bin/q
}


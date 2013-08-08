# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils


DESCRIPTION="K is a proprietary array processing language."
HOMEPAGE="http://kx.com/"
SRC_URI="$PN.zip"

LICENSE="kdb+"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="readline"

DEPEND="app-arch/unzip"
RDEPEND="readline? ( app-misc/rlwrap )"

RESTRICT="fetch"
S="$WORKDIR"


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
	echo $qrun > $D/usr/bin/kdb-q
	chmod +x $D/usr/bin/kdb-q
}

pkg_postinst() {
	ewarn The executable script is named \'kdb-q\' due to the name conflict \
	with Gentoo q.
}

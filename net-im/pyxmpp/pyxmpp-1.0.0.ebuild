# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils distutils

DESCRIPTION="A Python XMPP (RFC 3920,3921) and Jabber implementation"
HOMEPAGE="http://pyxmpp.jajcus.net/"
SRC_URI="http://ftp.de.debian.org/debian/pool/main/p/pyxmpp/pyxmpp_1.0.0.orig.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND=">=dev-lang/python-2.3
	>=dev-libs/libxml2-2.6.23"
RDEPEND="${DEPEND}
	>=dev-python/dnspython-1.3.2
	>=dev-python/m2crypto-0.13.1"

pkg_setup() {
	if ! built_with_use dev-libs/libxml2 python ; then
		eerror "To build pyxmpp, libxml2 must be built with python"
		eerror "bindings. To continue merging pyxmpp, you must first "
		eerror "recompile libxml2 with the python use flag enabled"
		die "pyxmpp requires libxml2 with USE=python"
	fi
}

src_install() {
	DOCS="CHANGES"
	distutils_src_install
	if use doc; then
		dohtml -r doc/www/* || die "Dohtml failed"
	fi
}

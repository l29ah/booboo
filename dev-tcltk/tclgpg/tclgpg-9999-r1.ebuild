# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

ESVN_REPO_URI="http://tclgpg.googlecode.com/svn/trunk/"

inherit autotools subversion

DESCRIPTION="Tcl interface to GNU Privacy Guard with interface similar to TclGPGME."
HOMEPAGE="http://code.google.com/p/tclgpg/"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc helper threads vanilla"


RDEPEND="app-crypt/gnupg
	dev-lang/tcl[threads]
	!helper? ( dev-tcltk/tclx )"

DEPEND="${RDEPEND}
	dev-tcltk/tcllib"

src_prepare() {
	use vanilla || epatch "$FILESDIR/$PN-fix-keyexpired.patch"
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable helper c-helper) \
		$(use_enable threads)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog || die
	if use doc ; then
		dohtml doc/gpg.html || die
	fi
}

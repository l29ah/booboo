# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EFOSSIL_REPO_URI='https://chiselapp.com/user/sgolovan/repository/tclgpg'

inherit autotools fossil

DESCRIPTION="Tcl interface to GNU Privacy Guard with interface similar to TclGPGME."
HOMEPAGE="http://code.google.com/p/tclgpg/"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="doc helper threads"


RDEPEND="app-crypt/gnupg
	dev-lang/tcl[threads]
	!helper? ( dev-tcltk/tclx )"

DEPEND="${RDEPEND}
	dev-tcltk/tcllib"

src_prepare() {
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

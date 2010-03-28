# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils autotools subversion

DESCRIPTION="Tcl interface to GNU Privacy Guard with interface similar to TclGPGME."
HOMEPAGE="http://code.google.com/p/tclgpg/"
SRC_URI=""
ESVN_REPO_URI="http://tclgpg.googlecode.com/svn/trunk/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="helper threads doc"

DEPEND="app-crypt/gnupg
	dev-lang/tcl
	!helper? ( dev-tcltk/tclx )"

RDEPEND="${DEPEND}"

src_prepare() {
	eautoconf || die "eautoconf failed"
}

src_configure() {
	econf \
		$(use_enable helper c-helper) \
		$(use_enable threads) \
		|| die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use doc ; then
		dohtml doc/gpg.html || die
	fi
	dodoc ChangeLog || die
}
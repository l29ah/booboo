# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/uzbl/uzbl-9999.ebuild,v 1.8 2009/12/12 10:06:32 wired Exp $

EAPI="2"

inherit base git-2 savedconfig

DESCRIPTION="Vimprobable is a WWW browser that behaves like the Vimperator plugin available for Mozilla Firefox based on the WebKit engine using GTK bindings."
HOMEPAGE="http://www.yllr.net/vimprobable/"
SRC_URI=""

EGIT_REPO_URI="http://www.yllr.net/vimprobable/vimprobable.git"
EGIT_BRANCH="vimprobable1"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+experimental +savedconfig"

DEPEND=">=net-libs/webkit-gtk-1.1.15
		>=x11-libs/gtk+-2.14"

RDEPEND="${DEPEND}"

pkg_setup() {
	use experimental && { 
		EGIT_BRANCH="vimprobable2"
		EGIT_TREE="vimprobable2"
	}
}

src_unpack() {
	git_src_unpack || die
}

src_prepare() {
	if use savedconfig; then
		restore_config config.h
	fi
}

src_compile() {
	emake || die "compile failed"
}

src_install() {
	if use experimental; then
		dobin vimprobable2
		doman vimprobable2.1
	else
		dobin vimprobable
		doman vimprobable.1
	fi
	save_config config.h
}

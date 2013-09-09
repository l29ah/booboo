# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="xAutoClick is an autoclicker application to reduce or avoid repetitive stress injury (RSI) by simulating multiple mouse clicks."
HOMEPAGE="http://xautoclick.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gtk qt fltk"

DEPEND="qt? ( dev-qt/qtcore:4 )
	gtk? ( x11-libs/gtk+:2 )
	fltk? ( x11-libs/fltk:1 )"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's#moc-qt4#moc#' Makefile
}

src_configure() {
	# unknown option: --host=x86_64-pc-linux-gnu
	./configure --prefix=$D/usr
	echo HAVE_GTK2=$(usex gtk yes no) >> config.mak
	echo HAVE_QT4=$(usex qt yes no) >> config.mak
	echo HAVE_FLTK=$(usex fltk yes no) >> config.mak
}

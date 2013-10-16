# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git-2 autotools

DESCRIPTION="GtkMMorse is a morse code learning tool released under GPL, which provides two type of training methods:

Koch method
Classic method"
HOMEPAGE="http://gtkmmorse.nongnu.org/"
EGIT_REPO_URI='git://git.savannah.nongnu.org/gtkmmorse.git'

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	dev-cpp/gtkmm:2.4
	media-libs/libao
	dev-cpp/gconfmm"
RDEPEND="${DEPEND}"

src_unpack() {
	git_src_unpack
}

src_prepare() {
	sed -i -e '/^CXX=/d;s/ -g -ggdb//' src/Makefile.am || die 'sed failed'
	eautoreconf
}

src_install() {
	einstall
}

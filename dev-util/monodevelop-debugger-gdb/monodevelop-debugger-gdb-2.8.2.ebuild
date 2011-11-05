# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop-debugger-gdb/monodevelop-debugger-gdb-2.6.ebuild,v 1.2 2011/11/04 12:36:22 phajdan.jr Exp $

EAPI="4"

inherit mono multilib versionator

DESCRIPTION="GDB Extension for MonoDevelop"
HOMEPAGE="http://www.monodevelop.com/"
SRC_URI="http://download.mono-project.com/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug"

RDEPEND=">=dev-lang/mono-2.10
	=dev-util/monodevelop-$(get_version_component_range 1-2)*
	 sys-devel/gdb"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.23"

src_configure() {
	./configure \
		--prefix=/usr		\
	|| die "configure failed"
}

src_compile() {
	emake -j1
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	mono_multilib_comply
}

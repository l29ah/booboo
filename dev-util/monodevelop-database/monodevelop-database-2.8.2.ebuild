# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop-database/monodevelop-database-2.6.ebuild,v 1.2 2011/11/04 12:35:52 phajdan.jr Exp $

EAPI="4"

inherit mono multilib versionator

DESCRIPTION="Database Browser Extension for MonoDevelop"
HOMEPAGE="http://www.monodevelop.com/"
SRC_URI="http://download.mono-project.com/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=dev-lang/mono-2.10
	=dev-util/monodevelop-$(get_version_component_range 1-2)*"

DEPEND="${RDEPEND}
	x11-misc/shared-mime-info
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.19"

src_compile() {
	emake -j1
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ChangeLog README
	mono_multilib_comply
}

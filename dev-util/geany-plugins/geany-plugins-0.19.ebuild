# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit base

DESCRIPTION="A collection of different plugins for Geany"
HOMEPAGE="http://plugins.geany.org/geany-plugins"
SRC_URI="http://plugins.geany.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="enchant gtkspell lua nls"

LINGUAS="be ca da de es fr gl ja pt pt_BR ru tr zh_CN"

RDEPEND="=dev-util/geany-0.19*
	enchant? ( app-text/enchant )
	gtkspell? ( app-text/gtkspell )
	lua? ( dev-lang/lua )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_configure() {
	econf \
		$(use_enable enchant spellcheck) \
		$(use_enable gtkspell) \
		$(use_enable lua geanylua) \
		$(use_enable nls)
}

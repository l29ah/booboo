# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/esdl/esdl-1.2.ebuild,v 1.1 2013/02/12 14:41:54 george Exp $

EAPI="2"

inherit fixheadtails multilib eutils

DESCRIPTION="Erlang bindings for the SDL library"
HOMEPAGE="http://esdl.sourceforge.net/"
SRC_URI="mirror://sourceforge/esdl/${P}.src.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE="image truetype"

RDEPEND=">=dev-lang/erlang-14
	>=media-libs/libsdl-1.2.5[opengl]
	image? ( media-libs/sdl-image )
	truetype? ( media-libs/sdl-ttf )
	virtual/opengl
	dev-util/rebar"
DEPEND="${RDEPEND}"

src_compile() {
	rebar compile
}

src_install() {
	addpredict /usr/$(get_libdir)/erlang/lib
	ERLANG_DIR="/usr/$(get_libdir)/erlang/lib"
	ESDL_DIR="${ERLANG_DIR}/${P}"
	
	insinto "${ESDL_DIR}"
	doins -r ebin include src c_src priv
}

# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit autotools eutils flag-o-matic multilib-minimal toolchain-funcs git-r3

DESCRIPTION="a fork of the defunct project CUnit, with several fixes and patches applied"
EGIT_REPO_URI="https://github.com/BelledonneCommunications/bcunit"
HOMEPAGE="https://github.com/BelledonneCommunications/bcunit"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="ncurses static-libs"

RDEPEND="ncurses? ( >=sys-libs/ncurses-5.9-r3:0=[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS NEWS README ChangeLog )

src_prepare() {
	default

	sed -e "/^docdir/d" -i doc/Makefile.am || die
	sed -e '/^dochdrdir/{s:$(prefix)/doc/@PACKAGE@:$(docdir):}' \
		-i doc/headers/Makefile.am || die
	sed -e "s/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/" -i configure.in || die
	eautoreconf

	append-cppflags -D_BSD_SOURCE

	# unable to find headers otherwise
	multilib_copy_sources
}

multilib_src_configure() {
	local LIBS=${LIBS}
	append-libs $($(tc-getPKG_CONFIG) --libs ncurses)

	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		$(use_enable static-libs static) \
		--disable-debug \
		$(use_enable ncurses curses)
}

multilib_src_install_all() {
	einstalldocs
	prune_libtool_files
}

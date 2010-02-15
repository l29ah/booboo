# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion autotools

DESCRIPTION="Fast and lightweight IDE using GTK2"
HOMEPAGE="http://geany.uvena.de/"

ESVN_REPO_URI="https://geany.svn.sourceforge.net/svnroot/geany/trunk"
ESVN_BOOTSTRAP="NOCONFIGURE=1 ./autogen.sh"

LICENSE="GPL-2
	Scintilla"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

DEPEND=">=dev-libs/atk-1.9.0
	>=dev-libs/expat-1.95.8
	>=media-libs/fontconfig-2.2.3
	>=media-libs/freetype-2.1.9-r1
	>=media-libs/libpng-1.2.8
	sys-libs/zlib
	virtual/libc
	>=x11-libs/gtk+-2.6.0
	>=x11-libs/pango-1.10.2
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXcursor
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender"

src_unpack() {
	subversion_src_unpack

	# Add syntax highlighting for Portage
	sed -i \
		-e 's:*.sh;:*.sh;*.ebuild;*.eclass;:' \
		data/filetype_extensions.conf \
		|| die "sed filetype_extensions.conf failed"

	# GPL-2 references
	local licdir="${PORTDIR}/licenses"
	local lic="${licdir}/GPL-2"
	sed -i \
		-e "s:@GEANY_DATA_DIR@/GPL-2:${lic}:" \
		doc/geany.1.in || die "sed geany.1.in failed"

	sed -i \
		-e "s:\"GPL-2\", app->datadir:\"GPL-2\", \"${licdir}\":" \
		src/about.c || die "sed about.c failed"

	if ! use debug ; then
		# Turn off debugging messages
		sed -i \
		-e "s:-DGEANY_DEBUG::" \
		src/Makefile.{am,in} || die "sed Makefile.{am,in} failed"
	fi
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# Shuffle docs
	local docdir="${D}/usr/share/doc/${PN}"
	rm "${docdir/\/doc}"/GPL-2
	rm "${docdir}"/{COPYING,ScintillaLicense.txt}
	use doc || rm -r "${docdir}/html"
	dodoc "${docdir}"/* || die "dodoc failed"
	rm -r "${docdir}"
}

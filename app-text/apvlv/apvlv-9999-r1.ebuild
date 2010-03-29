# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

WANT_AUTOMAKE="1.7"
ESVN_REPO_URI="http://apvlv.googlecode.com/svn/trunk"
inherit eutils autotools subversion toolchain-funcs

DESCRIPTION="a PDF Viewer which behaviors like Vim"
HOMEPAGE="http://code.google.com/p/apvlv/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug djvu"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=app-text/poppler-0.12.3-r3[cairo]
    djvu? ( app-text/djvu )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"

src_prepare() {
	eautoreconf
}

src_configure() {
	LD="$(tc-getLD)" econf \
		$(use_enable debug) \
		--with-sysconfdir=/etc/${PN} \
		--with-docdir="/usr/share/doc/${P}" \
		--disable-dependency-tracking \
		--with-mandir=/usr/share/man \
		$(use_with djvu)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS NEWS README THANKS TODO
	newicon icons/pdf.png ${PN}.png
	make_desktop_entry ${PN} "Alf's PDF Viewer Like Vim" ${PN} "Office;Viewer"
}


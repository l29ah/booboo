# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkimg/tkimg-1.4.20100510.ebuild,v 1.2 2010/06/15 12:41:28 jlec Exp $

EAPI="3"
inherit eutils prefix subversion

DESCRIPTION="Adds a lot of image formats to Tcl/Tk"
HOMEPAGE="http://sourceforge.net/projects/tkimg/"
ESVN_REPO_URI="https://tkimg.svn.sourceforge.net/svnroot/tkimg/trunk"

IUSE="doc"
SLOT="0"
LICENSE="BSD"
KEYWORDS=""

DEPEND="
	dev-lang/tk
	>=dev-tcltk/tcllib-1.11
	>=media-libs/libpng-1.4
	virtual/jpeg
	media-libs/tiff"
RDEPEND="${DEPEND}"

src_install() {
	emake \
		DESTDIR="${D}" \
		INSTALL_ROOT="${D}" \
		install || die "emake install failed"
	# Make library links
	for l in "${ED}"/usr/lib*/Img*/*tcl*.so; do
		bl=$(basename $l)
		dosym Img1.4/${bl} /usr/$(get_libdir)/${bl}
	done

	dodoc ChangeLog README Reorganization.Notes.txt changes ANNOUNCE || die
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins demo.tcl || die
		insinto /usr/share/doc/${PF}/html
		doins -r doc/* || die
	fi
}

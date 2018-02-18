# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools-utils flag-o-matic toolchain-funcs

DESCRIPTION="Quite Universal Circuit Simulator in Qt4"
HOMEPAGE="http://qucs.sourceforge.net/"
fn="${PN}-$PV"
SRC_URI="mirror://sourceforge/${PN}/${fn}.tar.gz"
S="$WORKDIR/$fn"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-qt/qtcore:4[qt3support]
	dev-qt/qtgui:4[qt3support]
	dev-qt/qt3support:4
	x11-libs/libX11"
DEPEND="${RDEPEND}
	doc? ( sci-mathematics/octave )"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	# the package doesn't use pkg-config on Linux, only on Darwin
	# very smart of upstream...
	append-ldflags $( $(tc-getPKG_CONFIG) --libs-only-L \
			QtCore QtGui QtXml Qt3Support )

	local myeconfargs=(
		$(use_enable doc)	# https://github.com/Qucs/qucs/issues/582
	)

	autotools-utils_src_configure
}

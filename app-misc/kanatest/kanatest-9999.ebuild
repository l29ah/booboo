# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kanatest/kanatest-0.4.6.ebuild,v 1.1 2008/12/05 16:57:07 matsuu Exp $

inherit eutils subversion

DESCRIPTION="Visual flashcard tool for memorizing the Japanese Hiragana and Katakana alphabet"
HOMEPAGE="http://clay.ll.pl/kanatest"

ESVN_REPO_URI="http://svn.gna.org/svn/kanatest/trunk/"
SRC_URI=""
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
RDEPEND=">=x11-libs/gtk+-2.6
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	./autogen.sh
	econf
	emake
	emake DESTDIR="${D}" install || die

	doicon kanatest.svg
	make_desktop_entry "${PN}" Kanatest "${PN}" "GNOME;Education;X-KDE-Edu-Language;"

	dodoc AUTHORS ChangeLog README
}

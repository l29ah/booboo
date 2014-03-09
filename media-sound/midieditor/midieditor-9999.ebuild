# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils subversion

DESCRIPTION="Simple Midi-Editing on Windows and Linux!"
HOMEPAGE="http://midieditor.sourceforge.net/"
ESVN_REPO_URI="svn://svn.code.sf.net/p/midieditor/code/trunk"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtcore
	dev-qt/qtgui"
RDEPEND="${DEPEND}"

src_install() {
	dobin MidiEditor
	dodoc README
	# TODO doxygen docs
}

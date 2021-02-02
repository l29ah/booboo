# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python3_{6,7,8} )

inherit eutils subversion multilib

DESCRIPTION="IceProg version for IcoBoard PiHat"
HOMEPAGE="http://www.clifford.at/icestorm/"
LICENSE="ISC"
ESVN_REPO_URI="http://svn.clifford.at/handicraft/2015/icoprog/"

SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-libs/wiringPi"

DEPEND="${RDEPEND}"

src_compile() {
	emake DESTDIR="${D}" icoprog
}

src_install() {
	dobin icoprog
}


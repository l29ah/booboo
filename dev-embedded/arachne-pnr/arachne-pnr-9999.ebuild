# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python2_7 )

inherit eutils git-r3 multilib

DESCRIPTION="Arachne PNR - free and open-source place and route tool for FPGAs"
HOMEPAGE="http://www.clifford.at/icestorm/"
LICENSE="ISC"
EGIT_REPO_URI="https://github.com/cseed/arachne-pnr.git"

SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-embedded/icestorm"

DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-path-fix.patch
}


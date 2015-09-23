# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit versionator

DESCRIPTION="a script to send USSD (Unstructured Supplementary Services Data) queries to your broadband provider."
HOMEPAGE="http://linux.zum-quadrat.de/downloads/"
MY_P="${PN}_`replace_version_separator 3 -`"
SRC_URI="http://linux.zum-quadrat.de/downloads/${MY_P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND="
	doc? ( <dev-lang/perl-5.22 )"
RDEPEND="
	dev-perl/Expect"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	use doc || sed -i -e '/all:/s/doc//' Makefile
}

src_compile() {
	use doc && emake
}

src_install() {
	emake install PREFIX="$D/usr"
}

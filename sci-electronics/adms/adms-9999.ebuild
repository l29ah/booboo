# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="ADMS is a code generator for the Verilog-AMS language"
HOMEPAGE="https://github.com/Qucs/ADMS"
EGIT_REPO_URI="https://github.com/Qucs/ADMS"
EGIT_BRANCH=develop

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="
	sys-devel/flex
	sys-devel/bison"
DEPEND="
	dev-perl/XML-LibXML
	$RDEPEND"

src_prepare() {
	default
	./bootstrap.sh
}

# Copyright 1999-2015 Rails Roosters Foundation
# Distributed under the terms of the WTFPL
# $Header: $

EAPI=5

inherit findlib eutils git-2

DESCRIPTION="Polebrush — human-oriented markup language"
HOMEPAGE="http://komar.bitcheese.net/en/code/polebrush"
EGIT_REPO_URI="http://komar.in/git/polebrush/"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-lang/ocaml-3.11
	dev-ml/extlib"
RDEPEND=""

src_install() {
	findlib_src_preinst
	dobin "${PN}"
}

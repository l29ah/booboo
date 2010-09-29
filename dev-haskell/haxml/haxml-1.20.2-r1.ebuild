# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=3

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="HaXml"
MY_P="${MY_PN}-${PV##-r*}"

DESCRIPTION="Utilities for manipulating XML documents"
HOMEPAGE="http://www.cs.york.ac.uk/fp/HaXml/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="$(get_version_component_range 1-2 ${PV})"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		>=dev-haskell/polyparse-1.2"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "$FILESDIR/$MY_P-getopt-force-html.patch"
	epatch "$FILESDIR/$MY_P-lazy-option.patch"
	epatch "$FILESDIR/$MY_P-clean-lazy.patch"
}

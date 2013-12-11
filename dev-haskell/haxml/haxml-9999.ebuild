# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal darcs

DESCRIPTION="Utilities for manipulating XML documents"
HOMEPAGE="http://www.cs.york.ac.uk/fp/HaXml/"
EDARCS_REPOSITORY="http://code.haskell.org/~malcolm/HaXml"
SLOT="0"

LICENSE="LGPL-2.1"
#SLOT="1.21" # FIXME
KEYWORDS=""
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		>=dev-haskell/polyparse-1.2"
RDEPEND=''

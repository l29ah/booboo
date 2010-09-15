# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Revisiting the Numeric Classes"
HOMEPAGE="http://www.haskell.org/haskellwiki/Numeric_Prelude"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.1"

DEPEND="${RDEPEND}
		dev-haskell/parsec
		dev-haskell/cabal
		dev-haskell/non-negative
		dev-haskell/storable-record
		>=dev-haskell/utility-ht-0.0.4"

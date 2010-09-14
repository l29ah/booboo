# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="With this package you can build a Storable instance of a record type from Storable instances of its elements in an elegant way. It does not do any magic, just a bit arithmetic to compute the right offsets, that would be otherwise done manually or by a preprocessor like C2HS."
HOMEPAGE="http://code.haskell.org/~thielema/storable-record/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.1"

DEPEND="${RDEPEND}
		dev-haskell/transformers
		dev-haskell/cabal
		>=dev-haskell/utility-ht-0.0.4"

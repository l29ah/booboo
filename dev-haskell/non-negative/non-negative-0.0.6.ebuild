# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Provides a class for non-negative numbers, a wrapper which can turn any ordered numeric type into a member of that class, and a lazy number type for non-negative numbers (a generalization of Peano numbers)."
HOMEPAGE="http://code.haskell.org/~thielema/non-negative/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.1"

DEPEND="${RDEPEND}
		dev-haskell/cabal"

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="With these routines it is very easy to write a server, have it accept connections on multiple ports via IP4, IP6 or unix sockets and associate each of these bindings with a server routine."
HOMEPAGE="http://hackage.haskell.org/package/network-server"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.12.0"
DEPEND="${RDEPEND}
	>=dev-haskell/network-2.2.0.1"

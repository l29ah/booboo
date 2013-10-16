# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit base haskell-cabal git-2

DESCRIPTION="Easy-to-use TODOs manager."
HOMEPAGE="http://gitorious.org/todos"
EGIT_REPO_URI="git://gitorious.org/todos/todos.git"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND=""
DEPEND=">=dev-lang/ghc-6.12.1
	>=dev-haskell/cabal-1.2
	dev-haskell/utf8-string
	<dev-haskell/parsec-3.0.0
	dev-haskell/mtl
	dev-haskell/ansi-terminal
	dev-haskell/glob
	dev-haskell/time
	dev-haskell/regex-pcre
	dev-haskell/data-hash
	dev-haskell/dyre"

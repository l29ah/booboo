# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999

CABAL_FEATURES=""
inherit haskell-cabal git-r3

DESCRIPTION="proxies e-mail to a configurable address"
HOMEPAGE="https://github.com/l29ah/mailmasquerade"
EGIT_REPO_URI="https://github.com/l29ah/mailmasquerade"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND=">=dev-haskell/aeson-2.1.2.1 <dev-haskell/aeson-2.2
	>=dev-haskell/haskellnet-0.6.1.2 <dev-haskell/haskellnet-0.7
	>=dev-haskell/haskellnet-ssl-0.3.4.4 <dev-haskell/haskellnet-ssl-0.4
	>=dev-haskell/hsemail-2.2.1 <dev-haskell/hsemail-2.3
	>=dev-haskell/hslogger-1.3.1.0 <dev-haskell/hslogger-1.4
	>=dev-haskell/parsec-3.1.16.1 <dev-haskell/parsec-3.2
	>=dev-haskell/regex-1.1.0.2 <dev-haskell/regex-1.2
	>=dev-haskell/string-class-0.1.7.1 <dev-haskell/string-class-0.2
	>=dev-haskell/text-1.2.4.1 <dev-haskell/text-2.1
	>=dev-lang/ghc-9.6.4
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.10.1.0
"

src_install() {
	default
	elog Put your configuration in /var/db/mailmasquerade
	keepdir /var/db/mailmasquerade
	doinitd openrc/mailmasquerade
}
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit git-r3

DESCRIPTION="Sedsed can debug, indent, tokenize and HTMLize your SED scripts."
HOMEPAGE="http://aurelio.net/sedsed/"
EGIT_REPO_URI="https://github.com/aureliojargas/sedsed"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/python"

src_install() {
	dobin sedsed.py
}

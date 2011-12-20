# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit subversion

DESCRIPTION="Sedsed can debug, indent, tokenize and HTMLize your SED scripts."
HOMEPAGE="http://aurelio.net/sedsed/"
ESVN_REPO_URI="http://sedsed.googlecode.com/svn/trunk/"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/python"

src_install() {
	dobin sedsed
}

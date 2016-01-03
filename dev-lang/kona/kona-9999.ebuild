# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git-2

DESCRIPTION="Kona is an open-source implementation of the K programming language."
HOMEPAGE="https://github.com/kevinlawler/kona"
EGIT_REPO_URI='https://github.com/kevinlawler/kona.git'

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dodir /usr/bin
	emake install PREFIX="${D}/usr/"
}

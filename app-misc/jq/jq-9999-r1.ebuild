# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jq/jq-1.4.ebuild,v 1.2 2014/12/11 07:32:54 radhermit Exp $

EAPI=5

inherit autotools eutils git-r3

DESCRIPTION="A lightweight and flexible command-line JSON processor"
HOMEPAGE="http://stedolan.github.com/jq/"
EGIT_REPO_URI="https://github.com/stedolan/jq.git"
SRC_URI=""

LICENSE="MIT CC-BY-3.0"
SLOT="0"
KEYWORDS=""
IUSE="test +dynamic static-libs"

DEPEND=">sys-devel/bison-3.0
	dev-libs/oniguruma:=[static-libs?]
	sys-devel/flex
	test? ( dev-util/valgrind )"

DOCS=( AUTHORS README )

src_prepare() {
	sed -i '/^dist_doc_DATA/d' Makefile.am || die
	eautoreconf
}

src_configure() {
	# don't try to rebuild docs
	econf --disable-docs $(use_enable dynamic dynamic) $(use_enable static-libs static)
}

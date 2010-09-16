# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit base

DESCRIPTION="This package consists of a set of programs for manipulating and analyzing Unicode text. The analysis utilities are useful when working with Unicode files when one doesn't know the writing system, doesn't have the necessary font, needs to inspect invisible characters, needs to find out whether characters have been combined or in what order they occur, or needs statistics on which characters occur."
HOMEPAGE="http://billposer.org/Software/unidesc.html"
SRC_URI="http://billposer.org/Software/Downloads/$P.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="sys-devel/gcc sys-devel/make"
RDEPEND=""


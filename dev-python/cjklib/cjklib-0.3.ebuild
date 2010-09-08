# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit distutils python

DESCRIPTION="Cjklib provides language routines related to Han characters (characters based on Chinese characters named Hanzi, Kanji, Hanja and chu Han respectively) used in writing of the Chinese, the Japanese, infrequently the Korean and formerly the Vietnamese language(s). Functionality is included for character pronunciations, radicals, glyph components, stroke decomposition and variant information."
HOMEPAGE="http://code.google.com/p/cjklib/"
SRC_URI="http://cjklib.googlecode.com/files/$P.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/python-2.5
	dev-python/sqlalchemy
	dev-db/sqlite:3"
RDEPEND="${DEPEND}"


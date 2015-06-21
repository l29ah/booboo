# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit python

DESCRIPTION="Web of trust statistics and pathfinder"
HOMEPAGE="https://www.lysator.liu.se/~jc/wotsap/"
SRC_URI="https://www.lysator.liu.se/~jc/wotsap/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+png"

DEPEND=""
RDEPEND="<dev-lang/python-3
	png? ( virtual/python-imaging )"	# FIXME proper python deps

src_install() {
	python_convert_shebangs -r -x -- 2 .
	sed -i -e 's#global Image.*#global PIL#;s# \(Image\)# PIL.\1#g' wotsap
	dobin pks2wot wotsap
	dodoc README ChangeLog wotfileformat-0.1.txt wotfileformat.txt
}

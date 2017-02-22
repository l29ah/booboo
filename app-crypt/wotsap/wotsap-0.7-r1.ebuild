# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1 python-utils-r1

DESCRIPTION="Web of trust statistics and pathfinder"
HOMEPAGE="https://www.lysator.liu.se/~jc/wotsap/"
SRC_URI="https://www.lysator.liu.se/~jc/wotsap/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+png"

DEPEND=""
RDEPEND="png? ( dev-python/pillow[$PYTHON_USEDEP] )"

src_install() {
	python_fix_shebang .
	sed -i -e 's#global Image.*#global PIL#;s# \(Image\)# PIL.\1#g;s#fromstring#frombytes#g' wotsap
	dobin pks2wot wotsap
	dodoc README ChangeLog wotfileformat-0.1.txt wotfileformat.txt
}

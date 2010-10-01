# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-iterate/cl-iterate-1.4.3.ebuild,v 1.2 2010/01/07 15:04:15 fauli Exp $

inherit common-lisp eutils darcs

DESCRIPTION="ITERATE is a lispy and extensible replacement for the Common Lisp LOOP macro"
HOMEPAGE="http://common-lisp.net/project/iterate/
	http://www.cliki.net/iterate"
EDARCS_REPOSITORY='http://common-lisp.net/project/iterate/darcs/iterate'
LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc"

DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"
RDEPEND=

CLPACKAGE=iterate

src_unpack() {
	darcs_src_unpack
	rm "${S}/Makefile"
}

src_compile() {
	base_src_compile
	if use doc; then
		cd doc
		./gendocs.sh iterate iterate
	fi
}

src_install() {
	common-lisp-install *.{lisp,asd} || die
	common-lisp-system-symlink || die
	insinto /usr/share/doc/${PF}
	use doc && doins doc/*.pdf
}

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
WANT_AUTOMAKE=none

inherit autotools git-r3

DESCRIPTION="Converter for Microsoft Word, Excel, PowerPoint and RTF files to text"
HOMEPAGE="http://www.wagner.pp.ru/~vitus/software/catdoc/"
EGIT_REPO_URI="http://www.wagner.pp.ru/git/oss/catdoc.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="tk"

DEPEND="tk? ( >=dev-lang/tk-8.1 )"

DOCS="CODING.STD CREDITS NEWS README TODO"

src_prepare() {
	default
	# only install wordview.desktop when tk is enabled (bug #522766)
	if ! use tk ; then
		sed -i 's/ desktop//' Makefile.in || die
	fi

	# Fix for case-insensitive filesystems
	echo ".PHONY: all install clean distclean dist" >> Makefile.in

	eautoconf
}

src_configure() {
	econf --with-install-root="${D}" \
		$(use_with tk wish "${EPREFIX}"/usr/bin/wish) \
		$(use_enable tk wordview)
}

src_compile() {
	emake LIB_DIR="${EPREFIX}"/usr/share/catdoc
}

src_install() {
	emake -j1 mandir="${EPREFIX}"/usr/share/man/man1 install

	if [[ -e ${ED}/usr/bin/xls2csv ]]; then
		einfo "Renaming xls2csv to xls2csv-${PN} because of bug 314657."
		mv -vf "${ED}"/usr/bin/xls2csv "${ED}"/usr/bin/xls2csv-${PN} || die
	fi

	dodoc ${DOCS}
}

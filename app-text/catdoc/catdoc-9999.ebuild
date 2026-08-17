# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
WANT_AUTOMAKE=none

inherit autotools git-r3

DESCRIPTION="Converter for Microsoft Word, Excel, PowerPoint and RTF files to text"
HOMEPAGE="http://www.wagner.pp.ru/~vitus/software/catdoc/"
EGIT_REPO_URI="https://github.com/vbwagner/catdoc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="apparmor tk"

DEPEND="tk? ( >=dev-lang/tk-8.1 )"

DOCS="CODING.STD CREDITS NEWS README TODO"

pkg_setup() {
	ewarn "This project is known to contain multiple unaddressed vulnerabilities:"
	ewarn "https://bugs.gentoo.org/916866#c2"
	ewarn "https://github.com/vbwagner/catdoc/issues"
}

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

	if use apparmor; then
		mkdir -p "${ED}"/etc/apparmor.d
		cp "${FILESDIR}/${PN}-apparmor" "${ED}"/etc/apparmor.d/${PN} || die
	fi
}

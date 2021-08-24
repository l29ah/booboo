# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

S="${WORKDIR}/${PN}${PV}"
DESCRIPTION="Kanji quiz and a lookup tool for X, helps in memorizing
Japanese characters"
HOMEPAGE="http://www.bolthole.com/kdrill/"
SRC_URI="http://www.bolthole.com/kdrill/${PN}${PV}.tar.gz"

LICENSE="kdrill"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""

DEPEND="x11-base/xorg-server
		x11-misc/imake"
	
src_prepare() {
	# getline is already defined by libc
	sed -i -e 's#getline(#my_&#g' *.c *.h
	default
}

src_compile() {
	mv Imakefile Imakefile.orig
	echo "DESTDIR=\"${D}\"" > Imakefile
	echo "CFLAGS+=${CFLAGS}" >> Imakefile
	echo "LDFLAGS+=${LDFLAGS}" >> Imakefile
	cat Imakefile.orig >> Imakefile
	sed -i s,/usr/local/lib,/usr/share/kdrill,g Imakefile
	xmkmf || die "xmkmf failed"

	emake || die "make failed"
}

src_install() {
	emake install || die "emake install failed"
	dobin makedic/makedic makedic/makeedict

	dodoc LICENSE NOTES README PATCHLIST BUGS TODO

	mv kdrill.man kdrill.1
	doman kdrill.1 makedic/makedic.1 makedic/makeedict.1

	insinto /usr/share/pixmaps
	doins kdrill.xpm

	insinto /usr/share/kdrill
	gzip kanjidic
	doins makedic/*.edic kanjidic.gz
	rm ${D}/usr/lib/X11/app-defaults
}

pkg_postinst() {
	einfo
	einfo "KDrill will by default use the kanjidic dictionary file."
	einfo "If you're a beginner you may want to start with a kana only"
	einfo "quiz, e.g:"
	einfo "kdrill -edictfile /usr/share/kdrill/fullkatahira.edic -kdictfile none"
	einfo "or"
	einfo "kdrill -edictfile /usr/share/kdrill/hiraplus.edic -kdictfile none"
	einfo "Then, when you're ready for kanjidic, run:"
	einfo "kdrill -kdictfile /usr/share/kdrill/kanjidic.gz"
	einfo
	einfo "Additional dictionaries can be installed in /usr/share/kdrill."
	einfo "http://www.bolthole.com/kdrill/kmirrors.html has many good ones."
	einfo
}

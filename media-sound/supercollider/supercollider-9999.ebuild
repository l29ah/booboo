# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
DESCRIPTION="A real time audio synthesis programming language"
HOMEPAGE="http://www.audiosynth.com/"
SRC_URI="${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="emacs"
#RESTRICT="nostrip"
DEPEND="media-sound/jack-audio-connection-kit
	media-libs/alsa-lib
	media-libs/libsndfile
	sys-devel/automake"
#RDEPEND=""

S="${WORKDIR}/SuperCollider3"

src_unpack() {
	unpack ${A}

	# Change default config file location from /etc to /etc/supercollider
	sed -ie "s:/etc/sclang.cfg:/etc/supercollider/sclang.cfg:" ${S}/source/lang/LangSource/SC_LanguageClient.cpp
	sed -ie "s:/etc/sclang.cfg:/etc/supercollider/sclang.cfg:" ${S}/linux/examples/sclang.cfg.in

	# Change the ridiculous default scsynth location on sample ~/.scsynth.sc file
	sed -ie "s:/usr/local/music/bin/scsynth:/usr/bin/scsynth:" ${S}/linux/examples/sclang.sc

	# Uncommenting a line per linux/examples/sclang.cfg.in
	if ! use emacs; then
		sed -ie "s:#-@SC_LIB_DIR@/Common/GUI/Document.sc:-@SC_LIB_DIR@/Common/GUI/Document.sc:" ${S}/linux/examples/sclang.cfg.in
	fi
}

src_compile() {
	local myconf
	if use emacs; then
		myconf="${myconf} --enable-scel"
	else
		myconf="${myconf} --disable-scel"
	fi

	# Do the main compilation
	./linux/bootstrap
	econf ${myconf} || die
	emake || die "emake failed"
	cd ${S}/linux/examples
	make sclang.cfg

	# Also compile Emacs extensions if need be
	if use emacs; then
		cd ${S}/linux/scel
		emake || die "emake on skel failed"
	fi
}

src_install() {
	
	# Main install
	einstall || die "einstall failed"

	# Install our config file
	insinto /etc/supercollider
	doins linux/examples/sclang.cfg

	# Documentation
	mv linux/README linux/README-linux
	mv linux/scel/README linux/scel/README-scel
	dodoc COPYING linux/README-linux linux/scel/README-scel

	# Our documentation
	sed -e "s:@DOCBASE@:/usr/share/doc/${PF}:" < ${FILESDIR}/README-gentoo.txt | gzip > ${D}/usr/share/doc/${PF}/README-gentoo.txt.gz

	# RTFs (don't gzip)
	insinto /usr/share/doc/${PF}
	doins doc/*.rtf changes.rtf

	# Example files (don't gzip)
	insinto /usr/share/doc/${PF}/examples
	doins linux/examples/onetwoonetwo.sc linux/examples/sclang.sc

	# Help files included with project (again, don't gzip)
	cp -R ${S}/build/Help ${D}/usr/share/doc/${PF}

	# Emacs installation
	if use emacs; then
		cd ${S}/linux/scel
		einstall || die "einstall on scel failed"
	fi

}

pkg_postinst() {
	einfo
	einfo "Notice: SuperCollider is not very intuitive to get up and running."
	einfo "The best course of action to make sure that the installation was"
	einfo "successful and get you started with using SuperCollider is to take"
	einfo "a look through /usr/share/doc/${PF}/README-gentoo.txt.gz"
	einfo
}

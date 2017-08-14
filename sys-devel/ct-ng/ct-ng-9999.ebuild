# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/ct-ng/ct-ng-1.21.0.ebuild,v 1.2 2015/05/26 22:27:20 blueness Exp $

EAPI="5"

inherit autotools bash-completion-r1 eutils git-r3

DESCRIPTION="crosstool-ng is a tool to build cross-compiling toolchains"
HOMEPAGE="http://crosstool-ng.org"
EGIT_REPO_URI="https://github.com/crosstool-ng/crosstool-ng"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND="net-misc/curl
	dev-util/gperf
	dev-vcs/cvs
	dev-vcs/subversion"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-kconfig-respect-flags.patch

	./bootstrap
}

src_configure () {
	econf INSTALL="/usr/bin/install"
}

src_install() {
	emake DESTDIR="${D%/}" install
	newbashcomp ${PN}.comp ${PN}
	dodoc README.md TODO
	use doc && mv "${D}"/usr/share/doc/crosstool-ng/"${PN}.${PVR}"/* \
		"${D}"/usr/share/doc/"${PF}"
	rm -rf "${D}"/usr/share/doc/crosstool-ng
}

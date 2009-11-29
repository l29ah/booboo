# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kismet/kismet-2008.05.1.ebuild,v 1.5 2009/08/09 15:09:23 ssuominen Exp $

EAPI=2

inherit toolchain-funcs linux-info eutils subversion

#MY_P=${P/\./-}
#MY_P=${MY_P/./-R}
#S=${WORKDIR}/${MY_P}

DESCRIPTION="IEEE 802.11 wireless LAN sniffer"
HOMEPAGE="http://www.kismetwireless.net/"
SRC_URI=""
ESVN_REPO_URI="https://www.kismetwireless.net/code/svn/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="dbus ncurses suid"

DEPEND="${RDEPEND}"
RDEPEND="net-wireless/wireless-tools
	net-libs/libpcap
	ncurses? ( sys-libs/ncurses )
	dbus? ( sys-apps/dbus )"

src_prepare() {
	sed -i -e "s:^\(logtemplate\)=\(.*\):\1=/tmp/\2:" \
		conf/kismet.conf.in

	# Don't strip and set correct mangrp
	sed -i -e 's| -s||g' \
		-e 's|@mangrp@|root|g' Makefile.in
}

src_compile() {
	# the configure script only honors '--disable-foo'

	if ! use ncurses; then
		myconf="${myconf} --disable-curses --disable-panel"
	fi
	if ! use dbus; then
		myconf="${myconf} --disable-dbus"
	fi

	econf ${myconf} \
		--with-linuxheaders="${KV_DIR}" || die "econf failed"

	emake dep || die "emake dep failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc  CHANGELOG README 
	dohtml -r docs/devel-wiki-docs


	# INSTALL KISMET_CAPTURE IN ALL CASES

	dobin   kismet_capture
	fowners root:kismet kismet_capture
	use suid && fperms  4750 /usr/bin/kismet_capture

	newinitd "${FILESDIR}"/${PN}.initd kismet
	newconfd "${FILESDIR}"/${PN}.confd kismet
}

pkg_setup () {
	linux-info_pkg_setup
	enewgroup kismet
}

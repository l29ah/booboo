# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils git-2

EGIT_REPO_URI="git://git.torproject.org/arm.git"

DESCRIPTION="Terminal tor status monitor"
HOMEPAGE="http://www.atagar.com/arm/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/python
		net-misc/tor"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -ie "s#/usr/#${D}/usr/#g" setup.py
	sed -ie "s#/usr/bin/arm#/usr/bin/tor-arm#g" arm
}

src_install() {
	# this thing summons external lib TorCtl with some magic,
	# TODO: fetch it gentoo-way :3
	yes | ./install
	mv ${D}/usr/bin/arm ${D}/usr/bin/tor-arm
}

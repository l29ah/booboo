# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

EGIT_REPO_URI='https://github.com/the3dfxdude/7kaa.git'

inherit git-r3 autotools

DESCRIPTION="Seven Kingdoms: Ancient Adversaries"
HOMEPAGE="https://www.7kfans.com/"
SRC_URI="https://www.7kfans.com/downloads/7kaa-music.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="media-libs/openal
media-libs/libsdl2[video,sound]
net-libs/enet:1.3"
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
	cd "${S}"
	unpack ${A}
}

src_prepare() {
	eapply_user

	eautoreconf -vif || die autoreconf

}

src_configure() {
	econf || die
}

src_compile() {
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	insinto /usr/share/7kaa/music
	doins 7kaa-music/music/*
}


# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

DESCRIPTION="Use external locker as X screen saver."
HOMEPAGE="https://bitbucket.org/raymonad/xss-lock"
EGIT_REPO_URI="https://bitbucket.org/raymonad/xss-lock.git"

LICENSE="MIT-with-advertising"
SLOT="0"

RDEPEND="dev-libs/glib
	x11-libs/libxcb
	dev-python/docutils"

src_install() {
	cmake_src_install

	dodoc  "${D}"/usr/share/doc/xss-lock/*
	rm -rf "${D}/usr/share"/{doc/xss-lock,zsh}
}

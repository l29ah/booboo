# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit base git-r3

DESCRIPTION="Clang blacklist synchronizer."
HOMEPAGE="https://github.com/l29ah/gentoo-clang-scripts"
EGIT_REPO_URI="https://github.com/l29ah/gentoo-clang-scripts"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-vcs/git"
RDEPEND="$DEPEND
	app-eselect/eselect-package-manager"

src_compile() {
	true
}

pkg_postinst() {
	cd /etc/portage
	git clone https://github.com/l29ah/gentoo-clang-db gentoo-clang
	ewarn "If you're a paludis user, don't forget to put '. /etc/paludis/bashrc.clang' to your /etc/paludis/bashrc"
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/bnf-syntax/bnf-syntax-1.2-r1.ebuild,v 1.9 2007/07/11 05:14:07 mr_bones_ Exp $

EAPI=2

inherit vim-plugin

DESCRIPTION="vim plugin: rc shell script syntax highlighting"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2880"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=11957
	-> $P.vim"
LICENSE="as-is"
KEYWORDS="alpha amd64 ia64 mips ppc ppc64 sparc x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for rc script files."

src_install() {
	dodir /usr/share/vim/vimfiles/syntax/
	cp $DISTDIR/$A $D/usr/share/vim/vimfiles/syntax/rc.vim
}


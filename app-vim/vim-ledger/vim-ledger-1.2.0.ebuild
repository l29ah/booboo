# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/gentoo-syntax/gentoo-syntax-99999999.ebuild,v 1.6 2013/06/01 09:32:03 radhermit Exp $

EAPI=7

inherit vim-plugin

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ledger/vim-ledger"
else
	SRC_URI="https://github.com/ledger/vim-ledger/archive/refs/tags/v$PV.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="vim plugin: app-office/ledger file format syntax"
HOMEPAGE="https://github.com/ledger/vim-ledger"
LICENSE="vim"

VIM_PLUGIN_HELPFILES="ledger-syntax"
VIM_PLUGIN_MESSAGES="filetype"

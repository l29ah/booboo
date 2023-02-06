# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vim-plugin git-r3

EGIT_REPO_URI="https://github.com/ledger/vim-ledger"

DESCRIPTION="vim plugin: app-office/ledger file format syntax"
HOMEPAGE="https://github.com/ledger/vim-ledger"
LICENSE="vim"

VIM_PLUGIN_HELPFILES="ledger-syntax"
VIM_PLUGIN_MESSAGES="filetype"

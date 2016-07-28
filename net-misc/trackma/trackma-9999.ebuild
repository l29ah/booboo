# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_4,3_5} )

inherit git-r3 distutils-r1

DESCRIPTION="Open multi-site list manager for media tracking sites."
HOMEPAGE="https://github.com/z411/trackma"

EGIT_REPO_URI="https://github.com/z411/trackma.git"

SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+urwid gtk qt4"

DEPEND="urwid? ( dev-python/urwid[${PYTHON_USEDEP}] )
	gtk? (
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
	)
	qt4? (
		dev-python/PyQt4[${PYTHON_USEDEP}]
         	dev-python/pillow[${PYTHON_USEDEP}]
	)
	${PYTHON_DEPS}"
RDEPEND="sys-process/lsof
	${DEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"


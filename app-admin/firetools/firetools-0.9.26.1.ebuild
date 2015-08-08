# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit base

DESCRIPTION="Firetools is the graphical user interface of Firejail security sandbox. It provides a sandbox launcher integrated with the system tray, sandbox editing, management and statistics. The application is built using Qt4 libraries, and it is distributed as a separate package."
HOMEPAGE="https://l3net.wordpress.com/projects/firejail/"
SRC_URI="mirror://sourceforge/firejail/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-admin/firejail"
RDEPEND="${DEPEND}"

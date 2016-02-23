# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit git-r3 distutils-r1

DESCRIPTION="A simple tool for uploading files to the filesystem of an ESP8266 running NodeMCU as well as some other useful commands."
HOMEPAGE="https://github.com/kmpm/nodemcu-uploader"
EGIT_REPO_URI="https://github.com/kmpm/nodemcu-uploader"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="
	>=dev-python/pyserial-2.7"

# Copyright 2022 Your Mom
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..13} )
inherit distutils-r1 git-r3

EGIT_REPO_URI="https://github.com/SpotlightKid/jack-matchmaker.git"

DESCRIPTION="Auto-connect JACK ports as they appear and when they match the port patterns given on the command line or read from a file."
HOMEPAGE="https://github.com/SpotlightKid/jack-matchmaker"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="
	virtual/jack"
BDEPEND="
    virtual/jack"

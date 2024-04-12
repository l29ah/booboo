# Copyright 2024 Your Mom
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Radicle is an open source, peer-to-peer code collaboration stack built on Git."
HOMEPAGE="https://radicle.xyz/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cli httpd +node +git"

RDEPEND="
        cli? ( >=net-p2p/radicle-cli-${PV}:0 )
        httpd? ( >=net-p2p/radicle-httpd-${PV}:0 )
        node? ( >=net-p2p/radicle-node-${PV}:0 )
        git? ( >=net-p2p/radicle-remote-helper-${PV}:0 )
"


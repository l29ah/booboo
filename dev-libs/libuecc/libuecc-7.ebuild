# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit cmake-multilib

DESCRIPTION="libuecc is a very small generic-purpose Elliptic Curve Cryptography library compatible with Ed25519"
HOMEPAGE="https://projects.universe-factory.net/projects/fastd"
SRC_URI="https://projects.universe-factory.net/attachments/download/85/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( README COPYRIGHT )

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils autotools

DESCRIPTION="This is libgq, a set of small libraries with Q wrappers for G things."
HOMEPAGE="http://maemo.org/packages/source/view/fremantle_sdk-tools_free_source/libgq/0.2-3+0m5/"
SRC_URI="http://repository.maemo.org/pool/maemo5.0/free/libg/libgq/libgq_0.2-3+0m5.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND="dev-qt/qttest:4"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch_user
	sed -i "s:-Werror::" configure.ac || die
	eautoreconf
}

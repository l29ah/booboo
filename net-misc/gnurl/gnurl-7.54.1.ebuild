# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils prefix

DESCRIPTION="libgnurl is a fork of libcurl, which is mostly for GNUnet but it might be usable for others, hence we're releasing the code on this website to the general public"
HOMEPAGE="https://gnunet.org/gnurl"
SRC_URI="https://gnunet.org/sites/default/files/$P.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	net-libs/gnutls:0=
	app-misc/ca-certificates
"
DEPEND="$RDEPEND
	>=virtual/pkgconfig-0-r1
"

src_prepare() {
	eapply_user
	eprefixify gnurl-config.in
	eautoreconf
}

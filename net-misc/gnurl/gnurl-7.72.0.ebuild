# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools prefix

DESCRIPTION="libgnurl is a fork of libcurl, which is mostly for GNUnet"
HOMEPAGE="https://gnunet.org/gnurl"
SRC_URI="mirror://gnu/gnunet/$P.tar.gz"

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

src_configure() {
	econf --enable-ipv6 --with-gnutls --without-libssh2 \
		--without-libmetalink --without-winidn \
		--without-librtmp --without-nghttp2 \
		--without-nss --without-cyassl \
		--without-polarssl --without-ssl \
		--without-winssl --without-darwinssl \
		--disable-sspi --disable-ntlm-wb \
		--disable-ldap --disable-rtsp --disable-dict \
		--disable-telnet --disable-tftp --disable-pop3 \
		--disable-imap --disable-smtp --disable-gopher \
		--disable-file --disable-ftp --disable-smb \
		--without-libpsl \
		--disable-valgrind
}

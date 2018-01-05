# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit cmake-utils user

DESCRIPTION="Fast and Secure Tunneling Daemon (fastd)"
HOMEPAGE="https://projects.universe-factory.net/projects/fastd"
SRC_URI="https://projects.universe-factory.net/attachments/download/86/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="ssl +sodium nacl lto +caps cipher-aes128-ctr +cipher-null-memcpy +cipher-null +cipher-salsa20 +cipher-salsa2012 +cipher-salsa2012-nacl +cipher-salsa2012-xmm +cipher-salsa20-nacl +cipher-salca20-xmm +dynamic-peers +mac-ghash +mac-ghash-builtin +mac-ghash-pclmultqdq +mac-uhash +mac-uhash-builtin +method-cipher-test +method-composed-gmac +method-composed-umac +method-generic-gmac +method-generic-poly1305 +method-generic-umac +method-null +method-xsalsa20-poly1305 +status-socket"

REQUIRED_USE="cipher-aes128-openssl? ( ssl )"

DEPEND=">=dev-libs/libuecc-7
		dev-libs/json-c
		caps? ( sys-libs/libcap )
		sodium? ( dev-libs/libsodium )
		nacl? ( net-libs/nacl )
		ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

src_configure() {
    local mycmakeargs=(
		$(cmake-utils_use_enable sodium LIBSODIUM)
		$(cmake-utils_use_enable ssl OPENSSL)
		$(cmake-utils_use_enable lto LTO)
		$(cmake-utils_use_with caps CAPABILITIES)
		$(cmake-utils_use_with cipher-aes128-ctr CIPHER_AES128_CTR)
		$(cmake-utils_use_with cipher-null-memcpy CIPHER_NULL_MEMCPY)
		$(cmake-utils_use_with cipher-null CIPHER_NULL)
		$(cmake-utils_use_with cipher-salsa20 CIPHER_SALSA20)
		$(cmake-utils_use_with cipher-salsa2012 CIPHER_SALSA2012)
		$(cmake-utils_use_with cipher-salsa2012-nacl CIPHER_SALSA2012_NACL)
		$(cmake-utils_use_with cipher-salsa2012-xmm CIPHER_SALSA2012_XMM)
		$(cmake-utils_use_with cipher-salsa20-nacl CIPHER_SALSA20_NACL)
		$(cmake-utils_use_with cipher-salca20-xmm CIPHER_SALCA20_XMM)
		$(cmake-utils_use_with dynamic-peers DYNAMIC_PEERS)
		$(cmake-utils_use_with mac-ghash MAC_GHASH)
		$(cmake-utils_use_with mac-ghash-builtin MAC_GHASH_BUILTIN)
		$(cmake-utils_use_with mac-ghash-pclmultqdq MAC_GHASH_PCLMULTQDQ)
		$(cmake-utils_use_with mac-uhash MAC_UHASH)
		$(cmake-utils_use_with mac-uhash-builtin MAC_UHASH_BUILTIN)
		$(cmake-utils_use_with method-cipher-test METHOD_CIPHER_TEST)
		$(cmake-utils_use_with method-composed-gmac METHOD_CIPHER_TEST)
		$(cmake-utils_use_with method-composed-umac METHOD_COMPOSED_UMAC)
		$(cmake-utils_use_with method-generic-gmac METHOD_GENERIC_GMAC)
		$(cmake-utils_use_with method-generic-poly1305 METHOD_GENERIC_POLY1305)
		$(cmake-utils_use_with method-generic-umac METHOD_GENERIC_UMAC)
		$(cmake-utils_use_with method-null METHOD_NULL)
		$(cmake-utils_use_with method-xsalsa20-poly1305 METHOD_XSALSA20_POLY1305)
		$(cmake-utils_use_with status-socket STATUS_SOCKET)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	doman doc/${PN}.1

	keepdir /etc/fastd
	newinitd "${FILESDIR}/${PN}.init" fastd
}

pkg_postinst() {
	enewgroup fastd
	enewuser fastd "" "" "" fastd
}

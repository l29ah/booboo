# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit multilib toolchain-funcs

DESCRIPTION="A simple, minimalistic ActivityPub instance"
HOMEPAGE="https://codeberg.org/grunfink/snac2"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/grunfunk/${PN}.git"
else
	SRC_URI="https://codeberg.org/grunfink/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi


LICENSE="MIT"
SLOT="0"
IUSE="+mastodon +landlock"

RDEPEND="
	acct-user/snac2
	acct-group/snac2
	net-misc/curl
	dev-libs/openssl:0=
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

S=${WORKDIR}/${PN}

src_compile() {
	use mastodon || export CFLAGS="${CFLAGS} -DNO_MASTODON_API"
	use landlock && export CFLAGS="${CFLAGS} -DWITH_LINUX_SANDBOX"

	emake PREFIX="/usr"
}

src_install() {
	emake PREFIX="${D}"/usr install
	keepdir /var/lib/snac2
	fowners snac2:snac2 /var/lib/snac2
	fperms 0750 /var/lib/snac2
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
}

# Copyright 1999-2021 Your Mom
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit multilib-minimal git-r3 toolchain-funcs

DESCRIPTION="Fake dbus"
HOMEPAGE="https://github.com/stefan11111/fake-dbus/"
EGIT_REPO_URI="https://github.com/stefan11111/fake-dbus.git"

IUSE=""

LICENSE="GPL-3"
SLOT="0/3" # libdbus.so.3

BDEPEND="
	virtual/pkgconfig
"

RDEPEND="
	!sys-apps/dbus
"

src_prepare() {
	default

	multilib_copy_sources
}

multilib_src_compile() {
	sed -i "s/lib64/$(get_libdir)/" dbus-1.pc || die
	CC="$(tc-getCC)" default
}

multilib_src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" LIBDIR="${EPREFIX}/$(get_libdir)" install
}


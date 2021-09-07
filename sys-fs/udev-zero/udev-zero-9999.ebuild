# Copyright 2021 Your Mom
# Distributed under the terms of the GNU General Public License v3

EAPI=7

inherit multilib-minimal git-r3 toolchain-funcs

DESCRIPTION="Drop-in replacement for libudev intended to work with any device manager"
HOMEPAGE="https://github.com/illiliti/libudev-zero"
EGIT_REPO_URI="https://github.com/illiliti/libudev-zero.git"

IUSE="static-libs +helper"

LICENSE="LGPL-2.1"
SLOT="0/1" # libudev.so.1

BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	default

	if ! use static-libs; then
		local sed_args=(
			-e '/\tcp -f .*\/libudev.a/d'
			-e '/^all: /s/ libudev.a//'
			-e '/^install: /s/ libudev.a//'
	    )
		sed -i "${sed_args[@]}" Makefile || die
	fi

	multilib_copy_sources
}

multilib_src_compile() {
	default
	emake
	if use helper && multilib_is_native_abi; then
		$(tc-getCC) ${CFLAGS} -o helper contrib/helper.c
	fi
}

multilib_src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" LIBDIR="${EPREFIX}/usr/$(get_libdir)" install
	if use helper && multilib_is_native_abi; then
		dosbin helper
	fi
}

multilib_src_install_all() {
	newinitd "${FILESDIR}"/udev.initd udev
}

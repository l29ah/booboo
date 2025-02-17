# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs git-r3

DESCRIPTION="minimal dumb-terminal emulation program"
HOMEPAGE="https://github.com/npat-efault/picocom"
EGIT_REPO_URI="https://github.com/npat-efault/picocom"

LICENSE="GPL-2"
SLOT="0"

src_prepare() {
	default

	sed -i -e 's:\./picocom:picocom:' pcasc || die

	# Custom baud rates
	sed -i -e '/-DUSE_CUSTOM_BAUD/s,#,,;/termios2/s,#,,' Makefile || die
}

src_compile() {
	# CPPFLAGS is shared between CFLAGS and CXXFLAGS, but there is no
	# C++ file, and the pre-processor is never called directly, this
	# is easier than patching it out.
	emake LDFLAGS="${LDFLAGS}" CFLAGS="${CFLAGS} ${CPPFLAGS} -Wall" \
		CC="$(tc-getCC)"
}

src_install() {
	dobin picocom pc{asc,xm,ym,zm}
	doman picocom.1
	dodoc picocom.1.html
	dodoc CONTRIBUTORS README.md TODO
}

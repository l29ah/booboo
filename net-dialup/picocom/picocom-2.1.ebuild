# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

inherit eutils toolchain-funcs

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/npat-efault/picocom"
else
	KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
	SRC_URI="https://github.com/npat-efault/picocom/archive/$PV.tar.gz -> $P.tar.gz"
fi
DESCRIPTION="minimal dumb-terminal emulation program"
HOMEPAGE="https://github.com/npat-efault/picocom"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=""

src_prepare() {
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
	dohtml picocom.1.html
	dodoc CONTRIBUTORS README.md TODO
}

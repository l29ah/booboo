# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs

MY_P="${PN}-1.0"

DESCRIPTION="NVIDIA Linux X11 Settings Utility"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="ftp://download.nvidia.com/XFree86/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86 ~x86-fbsd"
IUSE=""

# xorg-server is used in the depends as nvidia-settings builds against some
# headers in /usr/include/xorg/.
# This also allows us to optimize out a lot of the other dependancies, as
# between gtk and xorg-server, almost all libraries and headers are accounted
# for.
DEPEND=">=x11-libs/gtk+-2
	dev-util/pkgconfig
	x11-base/xorg-server
	x11-libs/libXt
	x11-libs/libXv
	x11-proto/xf86driproto
	x11-proto/xf86vidmodeproto"

RDEPEND=">=x11-libs/gtk+-2
	x11-base/xorg-server
	x11-libs/libXt
	x11-drivers/nvidia-drivers"

S="${WORKDIR}/${MY_P}"

src_compile() {
	einfo "Building libXNVCtrl..."
	cd "${S}/src/libXNVCtrl"
	make clean || die "Cleaning old libXNVCtrl failed"
	emake CDEBUGFLAGS="${CFLAGS}" CC="$(tc-getCC)" libXNVCtrl.a || die "Building libXNVCtrl failed!"

	cd "${S}"
	einfo "Building nVidia-Settings..."
	emake  CC="$(tc-getCC)" || die "Failed to build nvidia-settings"
}

src_install() {
	# Install the executable
	exeinto /usr/bin
	doexe nvidia-settings

	# Install libXNVCtrl and headers
	insinto "/usr/$(get_libdir)"
	doins src/libXNVCtrl/libXNVCtrl.a
	insinto /usr/include/NVCtrl
	doins src/libXNVCtrl/{NVCtrl,NVCtrlLib}.h

	# Install icon and .desktop entry
	doicon "${FILESDIR}/icon/${PN}.png"
	domenu "${FILESDIR}/icon/${PN}.desktop"

	# Install manpage
	doman doc/nvidia-settings.1

	# Now install documentation
	dodoc doc/*.txt
}

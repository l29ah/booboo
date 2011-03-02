# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit mercurial

EHG_REPO_URI="http://opensound.hg.sourceforge.net:8000/hgroot/opensound/opensound"

DESCRIPTION="Open Sound System - portable, mixing-capable, high quality sound system for Unix."
HOMEPAGE="http://developer.opensound.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-apps/gawk
	>=x11-libs/gtk+-2
	>=sys-kernel/linux-headers-2.6.11"
RDEPEND=">=x11-libs/gtk+-2"

S="${WORKDIR}/build"

src_unpack() {
	S="$WORKDIR/opensound" mercurial_src_unpack
	mkdir "${WORKDIR}/build"

	einfo "Replacing init script with gentoo friendly one..."
	cp "${FILESDIR}/oss" "${WORKDIR}/opensound/setup/Linux/oss/etc/S89oss"
}

src_configure() {
	einfo "Running configure..."
	cd "${WORKDIR}/build"
	"$WORKDIR/opensound/configure" || die "configure failed"

	einfo "Stripping compiler flags..."
	sed -i -e 's/-D_KERNEL//' \
		"${WORKDIR}/build/Makefile" || die 'sed failed'
}

src_compile() {
	emake build || die "emake build failed"
}

src_install() {
	newinitd "${FILESDIR}"/oss oss
	cd "${WORKDIR}/build"
	cp -R prototype/* "${D}"

	echo 'CONFIG_PROTECT="$CONFIG_PROTECT /usr/lib/oss/conf/"' > 99oss
	doenvd 99oss || die "doenvd failed"
}

pkg_postinst() {
	elog "To use OSSv4 for the first time you must run"
	elog "# /etc/init.d/oss start "
	elog ""
	elog "If you are upgrading, run"
	elog "# /etc/init.d/oss restart "
	elog 'and may need to remove /lib/modules/$KERNEL_VERSION/kernel/oss/'
	elog ""
	elog "Enjoy OSSv4 !"
}

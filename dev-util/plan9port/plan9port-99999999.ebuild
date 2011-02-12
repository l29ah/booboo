# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit mercurial

DESCRIPTION="Plan9 Ported to Linux"
HOMEPAGE="http://swtch.com/plan9port/"
EHG_REPO_URI="http://code.swtch.com/${PN}"

LICENSE="Lucent-1.02"
SLOT="0"
IUSE=""

DEPEND="x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libxcb
		sys-libs/glibc"
RDEPEND="${DEPEND}"

S=${WORKDIR}/plan9port

PLAN9=/usr/plan9

src_prepare()
{
	einfo "Fixing hard-coded /usr/local/plan9 paths"
	find -type f -exec sed -i 's!/usr/local/plan9!${PLAN9}!g' '{}' ';'
}

src_compile() {
	./INSTALL -b || die "Plan9 build failed"
}

src_install() {
	dodir "${PLAN9}" || die "creating ${PLAN9} failed"

	# do* plays with the executable bit, and we cannot modify them
	cp -a * "${D}/${PLAN9}"

	# build the environment variables and install them in env.d 
	cat > "${T}/30plan9port" <<EOF
PLAN9=${PLAN9}
PATH=${PLAN9}/bin
ROOTPATH=${PLAN9}/bin
MANPATH=${PLAN9}/man
EOF
	doenvd "${T}/30plan9port" || die "installing 30plan9port failed"
}

pkg_postinst() {
	einfo "Recalibrating Plan 9 from User Space to its new environment."
	einfo "This could take a while..."

	cd "${PLAN9}"
	./INSTALL -c &> /dev/null

	elog "Plan 9 from User Space has been successfully installed into"
	elog "${PLAN9}. Your PLAN9 and PATH environment variables"
	elog "have also been appropriately set, please use env-update and"
	elog "source /etc/profile to bring that into immediate effect."
	elog
	elog "Please note that \${PLAN9}/bin has been appended to the *end*"
	elog "or your PATH to prevent conflicts. To use the Plan9 versions"
	elog "of common UNIX tools, use the absolute path:"
	elog "${PLAN9}/bin or the 9 command (eg: 9 troff)"
}

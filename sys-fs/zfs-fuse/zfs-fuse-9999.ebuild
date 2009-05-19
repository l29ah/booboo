# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/zfs-fuse/zfs-fuse-9999.ebuild,v 1.2 2008/09/25 16:29:02 trapni Exp $

IUSE="doc debug"

inherit eutils mercurial

DESCRIPTION="An implementation of the ZFS filesystem for FUSE/Linux"
HOMEPAGE="http://www.wizy.org/wiki/ZFS_on_FUSE"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=sys-libs/glibc-2.3.3
		>=dev-util/scons-0.96.1
		>=dev-libs/libaio-0.3
		>=sys-fs/fuse-2.6.1"

RDEPEND=">=sys-fs/fuse-2.6.1"

S=${WORKDIR}/trunk/src

src_unpack() {
	mercurial_fetch http://www.wizy.org/mercurial/zfs-fuse/trunk
	cd "${S}"

	epatch "${FILESDIR}/${PV}/fix_zdb_path.patch"
	epatch "${FILESDIR}/${PV}/fix_zfs-fuse_path.patch"
	epatch "${FILESDIR}/${PV}/fix_ztest_path.patch"
	epatch "${FILESDIR}/no_Werror.patch"
}

src_compile() {
	scons || die "Make failed"
}

src_install() {
	if useq debug; then
		mv cmd/ztest/ztest cmd/ztest/run-ztest || die
		mv cmd/ztest/runtest.sh cmd/ztest/ztest || die
		dosbin cmd/ztest/run-ztest || die
	fi
	dosbin cmd/ztest/ztest || die

	if useq debug; then
		mv zfs-fuse/zfs-fuse zfs-fuse/run-zfs-fuse || die
		mv zfs-fuse/run.sh zfs-fuse/zfs-fuse || die
		dobin zfs-fuse/run-zfs-fuse || die
	fi
	dosbin "zfs-fuse/zfs-fuse" || die

	dosbin "cmd/zfs/zfs" || die
	dosbin "cmd/zpool/zpool" || die
	dosbin "cmd/zdb/zdb" || die

	newinitd "${FILESDIR}/${PV}/${PN}.rc" "zfs-fuse" || die

	keepdir /var/lock/zfs || die
	fowners daemon.disk /var/lock/zfs || die

	keepdir /var/run/zfs || die
	fowners daemon.disk /var/run/zfs || die

	cd "${WORKDIR}/trunk" || die

	dodoc CHANGES || die

	if use doc; then
		dodoc {INSTALL,TODO,STATUS,TESTING,HACKING,BUGS} || die
	fi
}

pkg_postinst() {
	echo
	einfo "To debug and play with ZFS-FUSE make sure you have a recent 2.6.xx"
	einfo "series kernel with the FUSE module compiled in OR built as a"
	einfo "kernel module."
	einfo
	einfo "You can start the ZFS-FUSE daemon by running"
	einfo
	einfo "     /etc/init.d/zfs-fuse start"
	einfo
	einfo "as root from the command line. "
	einfo
	einfo "And don't forget to add it permanently, if you want to:"
	einfo
	einfo "    rc-update add zfs-fuse boot"
	einfo
	einfo "For additional ZFS related commands I recommend the ZFS admin"
	einfo "guide. http://opensolaris.org/os/community/zfs/docs/zfsadmin.pdf"
	einfo
	einfo "Don't forget this is an beta-quality release. Testing has been"
	einfo "very limited so please make sure you backup any important data."
	einfo
	einfo "If you have any problems with zfs-fuse please visit the ZFS-FUSE."
	einfo "website at http://developer.berlios.de/projects/zfs-fuse/"
	echo
}

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
ETYPE="sources"
#UNIPATCH_STRICTORDER="yes"

K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="2"
R4V=""
POHMELFSV="12"
TUXONICE_VERSION="3.0-rc8"
TUXONICE_TARGET="2.6.28"
TUXONICE_SRC="tuxonice-${TUXONICE_VERSION}-for-${TUXONICE_TARGET}"
TUXONICE_URI="http://www.tuxonice.net/downloads/all/${TUXONICE_SRC}.patch.bz2"


IUSE="${IUSE} +reiser4 tuxonice +pohmelfs"

RDEPEND="${RDEPEND}
   	tuxonice? ( >=sys-apps/tuxonice-userui-0.7.3
	>=sys-power/hibernate-script-1.99 )"


inherit kernel-2
detect_version
detect_arch

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
HOMEPAGE="http://l29ah.ru/"

DESCRIPTION="Full sources with some useful patches."

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"
if use reiser4; then 
	SRC_URI="${SRC_URI}
	http://www.kernel.org/pub/linux/kernel/people/edward/reiser4/reiser4-for-${KV_MAJOR}.${KV_MINOR}/reiser4-for-${PV}.patch.bz2"
	UNIPATCH_LIST="${UNIPATCH_LIST}
	${DISTDIR}/reiser4-for-${PV}${R4V}.patch.bz2"
fi
if use pohmelfs; then 
	SRC_URI="${SRC_URI}
	http://tservice.net.ru/~s0mbre/archive/pohmelfs/pohmelfs.${POHMELFSV} ->
	pohmelfs.${POHMELFSV}.patch"
	UNIPATCH_LIST="${UNIPATCH_LIST} ${DISTDIR}/pohmelfs.${POHMELFSV}.patch"
fi
if use tuxonice; then 
	SRC_URI="${SRC_URI} ${TUXONICE_URI}"
	UNIPATCH_LIST="${UNIPATCH_LIST} ${DISTDIR}/${TUXONICE_SRC}.patch.bz2"
fi

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}


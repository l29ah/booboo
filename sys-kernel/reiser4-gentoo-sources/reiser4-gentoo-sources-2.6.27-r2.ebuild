# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="4"
R4V=""
inherit kernel-2
detect_version
detect_arch

KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"
HOMEPAGE="http://gentoo-wiki.com/HOWTO_Reiser4_With_Gentoo-Sources"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree and the reiser4 patchset from namesys"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}
http://www.kernel.org/pub/linux/kernel/people/edward/reiser4/reiser4-for-${KV_MAJOR}.${KV_MINOR}/reiser4-for-2.6.27.patch.bz2"
UNIPATCH_LIST="${DISTDIR}/reiser4-for-2.6.27.patch.bz2"

pkg_postinst() {
        kernel-2_pkg_postinst
        einfo "For more info on this patchset, and how to report problems, see:"
        einfo "${HOMEPAGE}"
}

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MVER=$(wget -O - -o /dev/null \
'http://www.at.kernel.org/pub/linux/kernel/v2.6/testing/' | \
sed -n '/.*LATEST-IS.*/s/.*"LATEST-IS-\(.*\)">.*/\1/p' | sed 's/-/_/')

EAPI="2"
ETYPE="sources"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
HOMEPAGE="http://wiki.github.com/l29ah/booboo"
DESCRIPTION="Full sources with some useful patches."
UNIPATCH_STRICTORDER="yes"

# yandex mirror sucks, maybe others too
RESTRICT="nomirror"

inherit kernel-2
#detect_version
#detect_arch


REISER4V="2.6.29"

REISER4_SRC="reiser4-for-${REISER4V}.patch.bz2"
[[ ${PR} != r0 ]] && GPSSUFF=-${PR/r/git}
GIT_PATCH_SRC="patch-${PV/_/-}${GPSSUFF}.bz2"
GIT_PATCH_URI="mirror://kernel/linux/kernel/v2.6/snapshots/${GIT_PATCH_SRC}"
REISER4_URI="http://www.kernel.org/pub/linux/kernel/people/edward/reiser4/reiser4-for-${KV_MAJOR}.${KV_MINOR}/${REISER4_SRC}"
TUXONICE_SRC="current-tuxonice-for-head.patch-20090313-v1.bz2"
TUXONICE_URI="http://www.tuxonice.net/downloads/all/${TUXONICE_SRC}"

IUSE="${IUSE} reiser4"	
# Defaults to gentoo-sources

SRC_URI="${KERNEL_URI} ${ARCH_URI} ${GIT_PATCH_URI}
	reiser4? ( ${REISER4_URI} )
	tuxonice? ( ${TUXONICE_URI} )
"

#UNIPATCH_LIST="${UNIPATCH_LIST}
#	${DISTDIR}/${GIT_UPDATE_7_SRC}"
#UNIPATCH_LIST="${DISTDIR}/${GIT_PATCH_SRC} ${UNIPATCH_LIST}"

if use genpatches; then
	ewarn "What genpatches? ^_^"
fi
if use reiser4; then 
	UNIPATCH_LIST="${UNIPATCH_LIST}
	${DISTDIR}/${REISER4_SRC}"
fi
if use tuxonice; then
	ewarn "What tuxonice?"
fi

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

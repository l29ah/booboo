# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit base

DESCRIPTION="An Open-Source, Digital Signal Processing and Sound Synthesis Language"
HOMEPAGE="http://music.columbia.edu/cmc/RTcmix/intro.html"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE="X alsa perl python jack"

DEPEND="net-misc/wget sys-devel/gcc"
RDEPEND="${DEPEND}"

src_unpack() {
	fn=$PN-all.tar.gz
	wget ftp://presto.music.virginia.edu/pub/rtcmix/snapshots.daily/$fn || die "wget failed"
	tar -xf $fn -C "${WORKDIR}" || die "untar failed"
	# Noob magic!
	cd RTcmix-all-*
	S="$PWD"
}

src_configure() {
	econf \
		$(use_enable 64bit amd64) \
		$(use_with python) \
		$(use_with X x) \
		$(use_with jack) \
		$(use_with perl) \
		$(use_with python) || die "econf failed"
	sed -i -e '$aOPT += -fPIC ' defs.conf
	for f in `find . -iname Makefile`; do
		perl -pi -e 's/(\$\(MAKE\) \$\(MFLAGS\).*?)([;)}])/\1 || exit 1\2/' "$f"
	done
}


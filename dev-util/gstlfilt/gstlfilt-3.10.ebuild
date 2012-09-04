# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="STLFilt simplifies and/or reformats long-winded C++ error and
warning messages, with a focus on STL-related diagnostics"
HOMEPAGE="http://www.bdsoft.com/tools/stlfilt.html"
SRC_URI="http://www.bdsoft.com/dist/${PN}.tar"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -ni '1 {x; s_^$_#!/usr/bin/perl_; p; x}; p' gSTLFilt.pl 
}

src_install() {
	dobin "gSTLFilt.pl"
}

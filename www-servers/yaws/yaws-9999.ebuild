# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git-2 eutils autotools

EGIT_REPO_URI="https://github.com/klacke/yaws.git"
DESCRIPTION="Yaws is a high performance HTTP 1.1 web server."
HOMEPAGE="http://yaws.hyber.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="pam"

DEPEND="dev-lang/erlang"

PROVIDE="virtual/httpd-basic virtual/httpd-cgi"

src_unpack() {
    git_src_unpack || die
}

src_prepare() {
    sed -i -e 's,$(PREFIX)/var/log,/var/log,g' scripts/Makefile
    cp -f "${FILESDIR}"/yaws.conf.template scripts/
    eautoconf || die
}

src_configure() {
    econf $(use_disable pam) || die "econf failed"
}

src_compile() {
    emake  || die "emake failed"
}

src_install() {
    emake DESTDIR=${D} install || die
    keepdir /var/log/yaws
    rmdir ${D}var/lib/log/yaws
    rmdir ${D}var/lib/log
    # We need to keep these directories so that the example yaws.conf works
    # properly
    keepdir /usr/lib/yaws/examples/ebin
    keepdir /usr/lib/yaws/examples/include
    dodoc ChangeLog LICENSE README
}

pkg_postinst() {
    einfo "An example YAWS configuration has been setup to run on"
    einfo "Please edit /etc/yaws/yaws.conf to suit your needs."
}

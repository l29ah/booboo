# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools eutils

DESCRIPTION="The Multimedia Applications FrameWork (MAFW) complements GStreamer to enhance the multimedia experience in the Maemo platform, providing developers with a flexible, easy to use, and extensible high-level layer on top of other included multimedia-related technologies."
HOMEPAGE="https://wiki.maemo.org/Documentation/Maemo_5_Developer_Guide/Using_Multimedia_Components/Media_Application_Framework_(MAFW)"
SRC_URI="http://repository.maemo.org/pool/maemo5.0/free/libm/libmafw/libmafw_0.2.2010.06-1+0m5.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND="
	dev-libs/check"
RDEPEND=""

src_prepare() {
	epatch_user
	sed -i -e '/doc/d' configure.ac Makefile.am
	sed -i -e 's#check_pic#check#' checkmore/Makefile.am
	sed -i -e '/UPDATE/d' Makefile.am
	rm -rf doc
	eautoreconf
}

src_configure() {
	econf --disable-tests
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

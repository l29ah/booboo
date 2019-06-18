# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
inherit git-r3

DESCRIPTION="hatexmpp is a xmpp-client featuring ii-like interface"
HOMEPAGE="http://github.com/l29ah/hatexmpp"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS=""
IUSE="screen"
EGIT_REPO_URI="https://github.com/l29ah/hatexmpp.git"
RDEPEND="
		>=dev-libs/glib-2.18.4
		>=sys-fs/fuse-2.7.4
		>=net-libs/loudmouth-1.4.3
"
DEPEND="${RDEPEND}
		screen? ( app-misc/rlwrap )
		screen? ( dev-perl/TimeDate )
		screen? ( app-misc/screen )
"

src_install()
{
	use screen	&& dobin frontends/hatescreen.sh
	dobin hatexmpp
	mkdir -p "${D}/usr/share/doc/${PF}/"
	cp ADVENTURE "${D}/usr/share/doc/${PF}/README"
}

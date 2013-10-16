# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit git-2

DESCRIPTION="hatexmpp is a xmpp-client featuring ii-like interface"
HOMEPAGE="http://github.com/l29ah/hatexmpp"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS=""
IUSE="screen"
EGIT_REPO_URI="git://github.com/l29ah/hatexmpp.git"
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

src_compile()
{
	emake || die "emake filed"
}

src_install()
{
	use screen	&& dobin frontends/hatescreen.sh
	dobin hatexmpp
	dodoc README
}

pkg_postinst()
{
	einfo "hatexmpp is a xmpp-client featuring ii-like interface"
	einfo "to run: hatexmpp <mountpoint> -d"
	einfo "to configure: echo 'username' > <mountpoint>/config/username"
	einfo "The same operation you need to do with other settings like"
	einfo "server, password, resource, muc_default_nick, jiv_name, jiv_os, jiv_version"
}

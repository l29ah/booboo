inherit git

DESCRIPTION="hatexmpp is a xmpp-client featuring ii-like interface"
HOMEPAGE="http://github.com/l29ah/hatexmpp"
SRC_URI=""

LICENSE="GPL"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="screen gtk"
EGIT_REPO_URI="git://github.com/l29ah/hatexmpp.git"
RDEPEND="
		>=dev-libs/glib-2.18.4
		>=sys-fs/fuse-2.7.4
		>=net-libs/loudmouth-1.4.3
		screen? ( app-misc/rlwrap )
		screen? ( dev-perl/TimeDate )
		screen? ( app-misc/screen ) 
		gtk?  ( >=x11-libs/gtk+-2.12.11 )"
DEPEND="${RDEPEND}"

src_compile()
{
	emake || die "emake filed"
	use gtk && cd frontends/gtkface && emake || die "gtk emake failed"
}

src_install()
{
	use screen	&& dobin frontends/hatescreen.sh 
	use gtk		&& dobin frontends/gtkface/gtkface
	dobin hatexmpp
	dodoc README
}

pkg_postinst()
{
einfo "hatexmpp is a xmpp-client featuring ii-like interface"
einfo "to run: hatexmpp <mountpoint> -d"
einfo "to configure: echo 'username' > <mountpoint>/config/username"
einfo "The same operation you need to do with other settings like"
einfo "server, password, resource, muc_default_nick, jiv_name, jiv_os,
jiv_version"
einfo "to scream, go to hatexmpp@conference.jabber.ru"
}

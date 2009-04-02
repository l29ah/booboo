inherit git
DESCRIPTION="hatexmpp is a xmpp-client featuring ii-like interface"
HOMEPAGE="http://github.com/l29ah/hatexmpp"
SRC_URI=""

LICENSE="GLP-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
EGIT_REPO_URI="git://github.com/l29ah/hatexmpp.git"
RDEPEND="
		>=dev-libs/glib-2.18.4
		>=sys-fs/fuse-2.7.4
		>=net-libs/loudmouth-1.4.3"
DEPEND="${RDEPEND}"

src_compile()
{
	emake || die "emake filed"
}

src_install()
{
	dobin hatexmpp
}

pkg_postinst()
{
einfo "hatexmpp is a xmpp-client featuring ii-like interface"
einfo "synopsis: hatexmpp <mountpoint> -d"
einfo "to scream, go to hatexmpp@conference.jabber.ru"
}

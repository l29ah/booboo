inherit eutils

DESCRIPTION="9P2000 Server"
NAME="u9fs"
HOMEPAGE="http://v9fs.sf.net"
SRC_URI="mirror://sourceforge/v9fs/${P}.tar.gz"

LICENSE="Lucent Public License"
SLOT="0"
KEYWORDS="~x86"
IUSE="xinetd"

DEPEND=""
RDEPEND="${RDEPEND}
	xinetd? ( sys-apps/xinetd )"


src_unpack() {
	unpack ${A}

	# the source unpacks to just "u9fs", rename to the full name+version
	mv "u9fs" "${P}"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	into /usr
	doman u9fs.8
	dosbin u9fs
	dodoc CHANGES README TODO

	if use xinetd; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}/9pfs" 9pfs
	fi
}

pkg_postinst() {
	if ! use xinetd; then
		einfo
		einfo "u9fs requires an inetd-alike daemon to run, it does NOT"
		einfo "work stand-alone."
		einfo
		einfo "If you want to use xinetd, remerge with USE=xinetd, and a"
		einfo "sample configuration file will be placed in /etc/xinetd.d/9pfs."
		einfo
	else
		einfo
		einfo "A sample configuration file for xinetd has been placed in"
		einfo "/etc/xinetd.d/9pfs, use it wisely."
		einfo
	fi
}
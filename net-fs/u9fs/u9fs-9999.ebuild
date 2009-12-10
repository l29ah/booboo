inherit eutils

DESCRIPTION="9P2000 Server"
NAME="u9fs"
HOMEPAGE="http://plan9.bell-labs.com/sources/plan9/sys/src/cmd/unix/u9fs/"
SRC_URI=""

LICENSE="Lucent Public License"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="xinetd"

DEPEND="${RDEPEND}
	sys-libs/libixp
"
RDEPEND="xinetd? ( sys-apps/xinetd )"


src_unpack() {
	# Should make the v9fs version, but it seems like nobody cares
	export IXP_ADDRESS='tcp!sources.cs.bell-labs.com!564'

	ixpc read plan9/sys/man/4/u9fs > u9fs.8

	# Better use xargs
	files=`ixpc ls plan9/sys/src/cmd/unix/u9fs`
	for f in $files; do
		echo $f
		ixpc read plan9/sys/src/cmd/unix/u9fs/$f > $f
	done
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	into /usr
	doman u9fs.8
	dosbin u9fs
	dodoc LICENSE

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

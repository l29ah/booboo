# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils linux-info

DESCRIPTION="Userspace tools for kernel L2TP implementation."
HOMEPAGE="http://openl2tp.sourceforge.net"
SRC_URI="mirror://sourceforge/openl2tp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +client pppd rpc server -stats"

CDEPEND="net-dialup/ppp
	sys-libs/readline
	"
DEPEND="${CDEPEND}
	sys-devel/bison
	sys-devel/flex
	"
RDEPEND="${CDEPEND}
	rpc? ( || (
		net-nds/rpcbind
		net-nds/portmap
	) )"

CONFIG_CHECK="~PPPOL2TP"

pkg_setup() {
	# check for sane USE flags
	if ! use server && ! use client; then
		eerror
		eerror "You have disabled both server and client parts!"
		eerror "At least one of them must be enabled. ;)"
		eerror
		die "bad USE flags"
	fi
	# kernel requirements
	linux-info_pkg_setup
	if kernel_is -lt 2 6 23; then
		eerror
		eerror "Your kernel is too old. At least 2.6.23 is required to work with this program."
		eerror
		die "kernel is too old"
	fi
}

src_prepare() {
	# disable -Werror, as warnings may occur on different CFLAGS
	epatch "${FILESDIR}/${P}-werror.patch"
	# use system LDFLAGS
	epatch "${FILESDIR}/${P}-ldflags.patch"
	# let ebuild to control pppd plugins support
	epatch "${FILESDIR}/${P}-pppd.patch"
	# do not gzip man pages, let portage to compress them
	epatch "${FILESDIR}/${P}-man.patch"
	# install l2tpconfig to /usr/sbin with 0700 permissions
	# to make it at least a bit more secure
	epatch "${FILESDIR}/${P}-l2tpconfig.patch"
}

src_configure() {
	myconf=""	# not local, should be used at src_compile()

	use client || myconf+="L2TP_FEATURE_LAC_SUPPORT=n \
						   L2TP_FEATURE_LAIC_SUPPORT=n \
						   L2TP_FEATURE_LAOC_SUPPORT=n "

	use server || myconf+="L2TP_FEATURE_LNS_SUPPORT=n \
						   L2TP_FEATURE_LNIC_SUPPORT=n \
						   L2TP_FEATURE_LNOC_SUPPORT=n "

	use rpc || myconf+="L2TP_FEATURE_RPC_MANAGEMENT=n "

	use stats && myconf+="L2TP_FEATURE_LOCAL_STAT_FILE=y "

	# pppd plugin is only needed for pppd < 2.4.5
	unset PPPD_SUBDIR
	if use pppd; then
		export PPPD_VERSION=$( gawk '{
			if ($2=="VERSION") {
				gsub("\"","",$3);
				print $3
			}
		}' /usr/include/pppd/patchlevel.h ) || die "gawk failed"
		einfo "Building for pppd version $PPPD_VERSION"

		# convert version to comparable format
		local ver=$( echo PPPD_VERSION | gawk -F "." '{
			print lshift($1,16) + lshift($2,8) + $3
		}' )
	if [[ $ver -lt $(( 2<<16 + 4<<8 + 5)) ]]; then
			export PPPD_SUBDIR="pppd"
		else
		ewarn
			ewarn "openl2tp plugins are already integrated in >=net-dialup/ppp-2.4.5"
		fi
	fi
}

src_compile() {
	# upstream use OPT_CFLAGS for optimizations
	export OPT_CFLAGS=${CFLAGS}
	emake ${myconf} || die "emake failed"
}

src_install() {
	emake ${myconf} DESTDIR=${D} install || die "emake install failed"
	dodoc CHANGES INSTALL README

	if use doc; then
		dodoc doc/*.txt "${FILESDIR}"/openl2tpd.conf.sample
		newdoc plugins/README README.plugins
		use pppd && newdoc pppd/README README.pppd
		docinto ipsec
		dodoc ipsec/*
	fi

	newinitd "${FILESDIR}"/openl2tpd.initd openl2tpd
	# init.d script is quite different for RPC and non-RPC versions.
	use rpc || sed -i s/userpc=\"yes\"/userpc=\"no\"/ "${D}/etc/init.d/openl2tpd" || die "sed failed"
	newconfd "${FILESDIR}"/openl2tpd.confd openl2tpd
}

pkg_postinst() {
	if use rpc; then
		ewarn
		ewarn "RPC control does not provide any auth checks for control connection."
		ewarn "By default localhost only is allowed and l2tpconfig is installed"
		ewarn "accessible only by root, but local users may install or compile binary"
		ewarn "on they own if not prohibited by system administrator."
		ewarn
		ewarn "Therefore DO NOT USE RPC IN INSECURE ENVIRONMENTS!"
	else
		ewarn
		ewarn "Without RPC support you won't be able to use l2tpconfig."
	fi
	if use stats; then
		ewarn
		ewarn "To enable status files openl2tpd must be started with -S option."
		ewarn "Upstream warns about runtime overhead with status files enabled."
	fi
}

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=2
inherit autotools flag-o-matic subversion

DESCRIPTION="GNU Midnight Commander is a s-lang based file manager."
HOMEPAGE="http://people.redhat-club.org/slavaz/trac/wiki/ProjectMc"
ESVN_REPO_URI="http://mc.redhat-club.org/svn/trunk"
ESVN_PROJECT="mc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+7zip -attrs +background +editor ext2undel -dnotify gpm +network nls samba
+unicode +vfs X"

RDEPEND=">=dev-libs/glib-2
	app-arch/zip
	app-arch/unzip
	7zip? ( app-arch/p7zip )
	ext2undel? ( sys-fs/e2fsprogs )
	gpm? ( sys-libs/gpm )
	samba? ( net-fs/samba )
	unicode? ( >=sys-libs/slang-2.1.3 )
	!unicode? ( sys-libs/ncurses )
	X? ( x11-libs/libX11
		x11-libs/libICE
		x11-libs/libXau
		x11-libs/libXdmcp
	x11-libs/libSM )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

src_unpack() {
	subversion_src_unpack
	# we need this to fix autoreconf
	mkdir config
	touch config/config.rpath
	eautoreconf
}

src_configure() {
	# check for conflicts (currently doesn't compile with --without-vfs)
	use vfs || {
		use network || use samba && \
		die "VFS is required for network or samba support."
	}

	local myconf="--with-ext2undel --enable-charset"
	append-flags "-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE"

	use attrs && {
		myconf+=" --enable-preserve-attrs"
		ewarn "'Preserve Attributes' support is currently BROKEN. Use at your own risk."
	}

	use dnotify && {
		myconf+=" --enable-dnotify"
		ewarn "Support for dnotify is currently BROKEN. Use at your own risk."
	}

	if use samba; then
		myconf+=" --with-samba --with-configdir=/etc/samba --with-codepagedir=/var/lib/samba/codepages"
	else
		myconf+=" --without-samba"
	fi

	if use unicode; then
		myconf+=" --enable-utf8 --with-screen=slang"
	else
		myconf+=" --disable-utf8 --with-screen=ncurses"
		ewarn "Non UTF-8 setup is deprecated."
		ewarn "You are highly encouraged to use UTF-8 compatible system locale."
	fi

	subversion_wc_info
	export MCREVISION="r$ESVN_WC_REVISION"

	econf --disable-dependency-tracking \
			$(use_enable background) \
			$(use_enable network netcode) \
			$(use_enable nls) \
			$(use_with editor edit) \
			$(use_with ext2undel) \
			$(use_with gpm gpm-mouse) \
			$(use_with vfs) \
			$(use_with X x) \
			${myconf}
}

src_compile() {
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS FAQ HACKING MAINTAINERS NEWS README* TODO

	# Install cons.saver setuid to actually work
	fperms u+s /usr/libexec/mc/cons.saver
}

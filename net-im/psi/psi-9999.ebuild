# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-9999.ebuild,v 1.0 2008/03/24 08:52:16 Rion Exp $

EAPI="2"

inherit eutils qt4 multilib git subversion flag-o-matic

LANGPACK_VER="20090217"
RU_LANGPACK_VER="23_Feb_2009"

DESCRIPTION="Qt4 Jabber Client, with Licq-like interface"
HOMEPAGE="http://psi-im.org/"

IUSE="crypt dbus debug doc spell ssl xscreensaver powersave onewindow"
LANGS="cs de eo es_ES fr it mk pl pt_BR ru uk ur_PK vi zh zh_TW"
for LNG in ${LANGS}; do
	IUSE="${IUSE} linguas_${LNG}"
done

SRC_URI="
	linguas_ru? ( http://psi-ru.googlecode.com/files/Psi_ru_${RU_LANGPACK_VER}.zip )
	!linguas_ru? ( mirror://gentoo/${PN}-langs-${LANGPACK_VER}.tar.bz2 )
	http://psi-dev.googlecode.com/svn/trunk/iconsets/clients/fingerprint.jisp
	http://psi-dev.googlecode.com/svn/trunk/iconsets/moods/silk.jisp"
EGIT_REPO_URI="git://github.com/psi-im/psi.git"
EGIT_PROJECT="psi"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"



COMMON_DEPEND=">=x11-libs/qt-gui-4.4:4[qt3support,dbus?]
	>=x11-libs/qt-svg-4.4
	>=app-crypt/qca-2
	spell? ( app-text/aspell )
	xscreensaver? ( x11-libs/libXScrnSaver )"

DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )
	sys-devel/qconf"

RDEPEND="${COMMON_DEPEND}
	crypt? ( >=app-crypt/qca-gnupg-2.0.0_beta2 )
	ssl? ( >=app-crypt/qca-ossl-2.0.0_beta2 )"

src_unpack() {
	use linguas_ru && unpack "Psi_ru_${RU_LANGPACK_VER}.zip"
	! use linguas_ru && unpack "${PN}-langs-${LANGPACK_VER}.tar.bz2"

	git_src_unpack

	S="${S}/iris"
	EGIT_REPO_URI="git://github.com/psi-im/iris.git"
	EGIT_PROJECT="iris"
	git_src_unpack

	S="${WORKDIR}/patches"
	ESVN_REPO_URI=http://psi-dev.googlecode.com/svn/trunk/patches
	ESVN_PROJECT=psi_patches
	subversion_src_unpack
}

src_prepare() {
	rm "${WORKDIR}/patches"/*-psi-win-* #useless windows patches
	rm "${WORKDIR}/patches"/380*

	local rev
	rev=`svnversion "${PORTAGE_ACTUAL_DISTDIR}/svn-src/psi_patches/patches"`
	sed "s/\(xxx Beta\)/${rev} Beta/" -i "${WORKDIR}/patches"/280-psi-application-info.diff

	S="${WORKDIR}/${P}"
	cd "${S}"
	epatch "${WORKDIR}/patches"/*.diff
	epatch "${FILESDIR}/psi-md5-nick-color.patch"

	use powersave && epatch "${WORKDIR}/patches"/psi-reduce_power_consumption.patch
	use onewindow && epatch "${WORKDIR}/patches"/psi-all_in_one_window.patch
}

src_configure() {
	cd iris
	qconf
	#./configure || die "configure iris failed"
	#emake -j1 || die "make iris failed"
	cd ..

	# disable growl as it is a mac osx extension only
	local myconf="--prefix=/usr --qtdir=/usr"
	myconf="${myconf} --disable-growl --disable-bundled-qca"
	use spell || myconf="${myconf} --disable-aspell"
	use dbus || myconf="${myconf} --disable-qdbus"
	use xscreensaver || myconf="${myconf} --disable-xss"
	use debug && myconf="${myconf} --enable-debug"

	# cannot use econf because of non-standard configure script
	./configure ${myconf} || die "configure failed"
}

src_compile() {
	eqmake4 ${PN}.pro

	emake || die "emake failed"

	if use doc; then
		cd doc
		mkdir -p api # 259632
		make api_public || die "make api_public failed"
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"

	# this way the docs will be installed in the standard gentoo dir
	newdoc iconsets/roster/README README.roster || die
	newdoc iconsets/system/README README.system || die
	newdoc certs/README README.certs || die
	dodoc README || die

	if use doc; then
		cd doc
		dohtml -r api || die "dohtml failed"
	fi

	# install translations
	insinto /usr/share/${PN}/
	if use linguas_ru; then
		cd "${WORKDIR}"
		doins psi_ru.qm
		doins qt_ru.qm
	else
		cd "${WORKDIR}/${PN}-langs"
		for LNG in ${LANGS}; do
			if use linguas_${LNG}; then
				doins ${PN}_${LNG/ur_PK/ur_pk}.qm || die
			fi
		done
	fi

	dodir /usr/share/psi/iconsets/clients
	dodir /usr/share/psi/iconsets/moods
	insinto /usr/share/psi/iconsets/clients/
	doins "${PORTAGE_ACTUAL_DISTDIR}"/fingerprint.jisp
	insinto /usr/share/psi/iconsets/moods/
	doins "${PORTAGE_ACTUAL_DISTDIR}"/silk.jisp
}

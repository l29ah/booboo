# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

[[ ${PV} = *9999* ]] && VCS_ECLASS="subversion" || VCS_ECLASS=""

inherit ${VCS_ECLASS} git-r3

DESCRIPTION="Multimedia communication libraries written in C language
for building VoIP applications."
HOMEPAGE="http://www.pjsip.org/"
if [[ ${PV} == *9999* ]]; then
	ESVN_REPO_URI="http://svn.pjsip.org/repos/pjproject/trunk"
	KEYWORDS=""
else
	SRC_URI="http://www.pjsip.org/release/${PV}/pjproject-${PV}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="alsa doc epoll examples ext-sound g711 g722 g7221 gsm ilbc l16
oss python ring speex ssl"
#small-filter large-filter speex-aec

DEPEND="alsa? ( media-libs/alsa-lib )
	gsm? ( media-sound/gsm )
	ilbc? ( dev-libs/ilbc-rfc3951 )
	speex? ( media-libs/speex )
	ring? ( ssl? ( net-libs/gnutls ) )
	!ring? ( ssl? ( dev-libs/openssl ) )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/pjproject-${PV}"

src_unpack() {
[[ ${PV} = *9999* ]] && subversion_src_unpack || default

	if use ring; then
		EGIT_REPO_URI="https://gerrit-ring.savoirfairelinux.com/ring-daemon"
		EGIT_CHECKOUT_DIR=$WORKDIR/ring
		git-r3_src_unpack
	fi
}

src_prepare() {
	# Fix hardcoded prefix and flags
	sed -i \
		-e 's/poll@/poll@\nexport PREFIX := @prefix@\n/g' \
		-e 's!prefix = /usr/local!prefix = $(PREFIX)!' \
		Makefile \
		build.mak.in || die "sed failed."

	# apply -fPIC globally
	cp ${FILESDIR}/user.mak ${S}

	# TODO: remove deps to shipped codecs and libs, use system ones
	# rm -r third_party
	# libresample: https://ccrma.stanford.edu/~jos/resample/Free_Resampling_Software.html

	use ring && {
		eapply $WORKDIR/ring/contrib/src/pjproject/*.patch $FILESDIR/pjsip-ring-intptr_t.patch
		sed -i -e 's#/usr/local#/usr#' aconfigure
	}
	default
}

src_configure() {
	# Disable through portage available codecs
	ssl=''
	if use ring; then
		use ssl && ssl=--enable-ssl=gnutls
		conf=./aconfigure
	else
		use ssl && ssl=$(use_enable ssl)
		conf=econf
	fi
	$conf --disable-gsm-codec \
		--disable-speex-codec \
		--disable-ilbc-codec \
		--disable-speex-aec \
		$ssl \
		$(use_enable epoll) \
		$(use_enable alsa sound) \
		$(use_enable oss) \
		$(use_enable ext-sound) \
		$(use_enable g711 g711-codec) \
		$(use_enable l16 l16-codec) \
		$(use_enable g722 g722-codec) \
		$(use_enable g7221 g7221-codec) || die "econf failed."
		#$(use_enable small-filter) \
		#$(use_enable large-filter) \
		#$(use_enable speex-aec) \
}

src_compile() {
	emake dep || die "emake dep failed."
	emake -j1 || die "emake failed."
}

src_install() {
	DESTDIR="${D}" emake install || die "emake install failed."

	if use python; then
		pushd pjsip-apps/src/python
		python setup.py install --prefix="${D}/usr/"
		popd
	fi

	if use doc; then
		dodoc README.txt README-RTEMS
	fi

	if use examples; then
		insinto "/usr/share/doc/${P}/examples"
		doins "${S}/pjsip-apps/src/samples/"*
	fi

	# Remove files that pjproject should not install
	rm -r "${D}/usr/lib/libportaudio.a" \
		"${D}/usr/lib/libsrtp.a"
}

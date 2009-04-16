# I WANT TO KILL TEH AUTHOR!

inherit eutils

DESCRIPTION="mplayer with extra performance"
HOMEPAGE="http://mplayerxp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	sys-libs/glibc
	media-libs/tiff
	media-libs/schroedinger
	media-video/ffmpeg
"
RDEPEND=$DEPEND

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/mplayerxp-0.7.2-limits.patch
}

src_compile() {
	# We have funny install during compile'
	true
}

src_install() {
	# Kludging around homemade configure script
	CSI=$(pkg-config --cflags dirac schroedinger-1.0)
	LIBS="$LIBS -ltiff"
	CC="${CC} ${CFLAGS} $CSI"
	./configure --prefix="${D}"
	for pkg in dirac schroedinger-1.0
		do cp -r `pkg-config --cflags $pkg | 
			sed 's/ /\n/g' | 
			grep $pkg | 
			sed 's/^-I//'`/* codecs/
	done
	emake || die 'emake failed'
	make install || die 'make install failed'
}


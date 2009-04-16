# I WANT TO KILL TEH AUTHOR!

inherit eutils

EAPI="2"
DESCRIPTION="mplayer with extra performance"
HOMEPAGE="http://mplayerxp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="openmp"

DEPEND="
	sys-libs/glibc
	media-libs/tiff
	media-libs/schroedinger
	media-video/ffmpeg
	media-video/dirac
	x11-base/xorg-server
	openmp? ( >=sys-devel/gcc-4.3.0 )
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
	CFLAGS="$CFLAGS $CSI"
	myconf="--prefix=/usr \
			--datadir=/usr/share/mplayerxp \
			--libdir=/usr/lib \
			--confdir=/etc/mplayerxp"
	./configure ${myconf} || die "configure failed"

	for pkg in dirac schroedinger-1.0
		do cp -r `pkg-config --cflags $pkg | 
			sed 's/ /\n/g' | 
			grep $pkg | 
			sed 's/^-I//'`/* codecs/
	done
	sed -i -e 's/^SHCFLAGS.*//' codecs/config.mak
	mymake="prefix=${D}/usr \
			BINDIR=${D}/usr/bin \
			CONFDIR=${D}/etc/mplayer \
			DATADIR=${D}/usr/share/mplayer \
			MANDIR=${D}/usr/share/man \
			LIBDIR=${D}/usr/lib/ \
			CODECDIR=${D}/usr/lib/mplayerxp/codecs \
			INSTALLSTRIP= "
	maks=$(find -name config.mak)
	for vn in prefix BINDIR CONFDIR DATADIR MANDIR LIBDIR CODECDIR
		do xargs -n1 sed -i -e "s/^$vn.*//" <<< $maks
	done
	make $mymake || die 'make failed'
	make $mymake install || die 'make install failed'
	mv "${D}"/usr/bin/*.so "${D}/usr/lib/mplayerxp/codecs/"
}


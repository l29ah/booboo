# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/netpbm/netpbm-10.51.00.ebuild,v 1.2 2010/09/19 22:04:41 vapier Exp $

EAPI="3"

inherit toolchain-funcs eutils multilib subversion

DESCRIPTION="A set of utilities for converting to/from the netpbm (and related) formats"
HOMEPAGE="http://netpbm.sourceforge.net/"
ESVN_REPO_URI='http://netpbm.svn.sourceforge.net/svnroot/netpbm/advanced'

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="jbig jpeg jpeg2k png rle svga tiff X xml zlib +doc"

RDEPEND="jpeg? ( virtual/jpeg )
	jpeg2k? ( media-libs/jasper )
	tiff? ( >=media-libs/tiff-3.5.5 )
	png? ( >=media-libs/libpng-1.4 )
	xml? ( dev-libs/libxml2 )
	zlib? ( sys-libs/zlib )
	svga? ( media-libs/svgalib )
	jbig? ( media-libs/jbigkit )
	rle? ( media-libs/urt )
	X? ( x11-libs/libX11 )"
DEPEND="${RDEPEND}
	sys-devel/flex
	app-arch/xz-utils"

netpbm_libtype() {
	case ${CHOST} in
		*-darwin*) echo dylib;;
		*)         echo unixshared;;
	esac
}
netpbm_libsuffix() {
	local suffix=$(get_libname)
	echo ${suffix//\.}
}
netpbm_ldshlib() {
	case ${CHOST} in
		*-darwin*) echo '$(LDFLAGS) -dynamiclib -install_name $(SONAME)';;
		*)         echo '$(LDFLAGS) -shared -Wl,-soname,$(SONAME)';;
	esac
}
netpbm_config() {
	if use $1 ; then
		[[ $2 != "!" ]] && echo -l${2:-$1}
	else
		echo NONE
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/netpbm-10.31-build.patch

	# make sure we use system urt
	sed -i '/SUPPORT_SUBDIRS/s:urt::' GNUmakefile || die
	rm -rf urt

	# take care of the importinc stuff ourselves by only doing it once
	# at the top level and having all subdirs use that one set #149843
	sed -i \
		-e '/^importinc:/s|^|importinc:\nmanual_|' \
		-e '/-Iimportinc/s|-Iimp|-I"$(BUILDDIR)"/imp|g'\
		common.mk || die
	sed -i \
		-e '/%.c/s: importinc$::' \
		common.mk lib/Makefile lib/util/Makefile || die

	# avoid ugly depend.mk warnings
	touch $(find . -name Makefile | sed s:Makefile:depend.mk:g)
}

src_configure() {
	cat config.mk.in /dev/stdin >> config.mk <<-EOF
	# Misc crap
	BUILD_FIASCO = N
	SYMLINK = ln -sf

	# Toolchain options
	CC = $(tc-getCC) -Wall
	LD = \$(CC)
	CC_FOR_BUILD = $(tc-getBUILD_CC)
	LD_FOR_BUILD = \$(CC_FOR_BUILD)
	AR = $(tc-getAR)
	RANLIB = $(tc-getRANLIB)

	STRIPFLAG =
	CFLAGS_SHLIB = -fPIC

	LDRELOC = \$(LD) -r
	LDSHLIB = $(netpbm_ldshlib)
	LINKER_CAN_DO_EXPLICIT_LIBRARY = N # we can, but dont want to
	LINKERISCOMPILER = Y
	NETPBMLIBSUFFIX = $(netpbm_libsuffix)
	NETPBMLIBTYPE = $(netpbm_libtype)

	# Gentoo build options
	TIFFLIB = $(netpbm_config tiff)
	JPEGLIB = $(netpbm_config jpeg)
	PNGLIB = $(netpbm_config png)
	ZLIB = $(netpbm_config zlib z)
	LINUXSVGALIB = $(netpbm_config svga vga)
	XML2_LIBS = $(netpbm_config xml xml2)
	JBIGLIB = -ljbig
	JBIGHDR_DIR = $(netpbm_config jbig "!")
	JASPERLIB = -ljasper
	JASPERHDR_DIR = $(netpbm_config jpeg2k "!")
	URTLIB = $(netpbm_config rle)
	URTHDR_DIR =
	X11LIB = $(netpbm_config X X11)
	X11HDR_DIR =
	EOF
	# cannot chain the die with the heredoc above as bash-3
	# has a parser bug in that setup #282902
	[ $? -eq 0 ] || die "writing config.mk failed"
}

src_compile() {
	emake -j1 pm_config.h version.h manual_importinc || die #149843
	emake || die
	r="$PWD"
	use doc && {
		einfo Downloading man pages
		mkdir netpbmdoc
		cd netpbmdoc
		# FIXME
		wget --recursive --relative http://netpbm.sourceforge.net/doc/
		cd netpbm.sourceforge.net/doc
		emake USERGUIDE=. MAKEMAN="$r/buildtools/makeman" \
			-f "$r/buildtools/manpage.mk" manpages
	}
}

src_install() {
	emake package pkgdir="${D}"/usr || die "make package failed"

	[[ $(get_libdir) != "lib" ]] && mv "${D}"/usr/lib "${D}"/usr/$(get_libdir)

	# Remove cruft that we don't need, and move around stuff we want
	rm "${D}"/usr/bin/{doc.url,manweb} || die
	rm -r "${D}"/usr/man/web || die
	rm -r "${D}"/usr/link || die
	rm "${D}"/usr/{README,VERSION,config_template,pkginfo} || die
	dodir /usr/share
	mv "${D}"/usr/man "${D}"/usr/share/ || die
	mv "${D}"/usr/misc "${D}"/usr/share/netpbm || die

	use doc && {
		dodoc README
		cd doc
		GLOBIGNORE='*.html:.*' dodoc *
		dohtml -r .

		cd ../netpbmdoc/netpbm.sourceforge.net/doc
		sed -i -e 's#\.gz##;s/gzip/cat/' "$r/buildtools/manpage.mk"
		emake MANDIR="${ED}"/usr/share/man -f "$r/buildtools/manpage.mk" installman
	}
}

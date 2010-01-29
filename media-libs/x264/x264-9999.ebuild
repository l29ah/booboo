# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git multilib toolchain-funcs

EGIT_REPO_URI="git://git.videolan.org/x264.git"

DESCRIPTION="A free library for encoding H264/AVC video streams"
HOMEPAGE="http://www.videolan.org/developers/x264.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug gtk mp4 threads X"

RDEPEND="gtk? ( >=x11-libs/gtk+-2.6.10
        >=dev-libs/glib-2.10.3 )
    mp4? ( media-video/gpac )
    X? ( x11-libs/libX11 )"

DEPEND="${RDEPEND}
    amd64? ( >=dev-lang/yasm-0.6.2 )
    x86? ( >=dev-lang/yasm-0.7.0 )
    x86-fbsd? ( >=dev-lang/yasm-0.6.2 )
    dev-util/pkgconfig
    !media-video/x264-encoder"

src_unpack() {
    git_src_unpack
    cd "${S}"
    epatch "${FILESDIR}/${PN}-nostrip.patch"
}

src_compile() {
    local myconf=""
    use debug && myconf="${myconf} --enable-debug"
    ./configure --prefix=/usr \
        --libdir=/usr/$(get_libdir) \
        --enable-pic --enable-shared \
        "--extra-cflags=${CFLAGS}" \
        "--extra-ldflags=${LDFLAGS}" \
        "--extra-asflags=${ASFLAGS}" \
        $(use_enable X visualize) \
        $(use_enable threads pthread) \
        $(use_enable debug) \
        $(use_enable mp4 mp4-output) \
        $(use_enable gtk) \
        ${myconf} \
        || die "configure failed"
    emake CC="$(tc-getCC)" || die "make failed"
}

src_install() {
    make DESTDIR="${D}" install || die
    dodoc AUTHORS doc/*txt
}

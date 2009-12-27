# Copyright 1999-2008 Gentoo Foundation                                              
# Distributed under the terms of the GNU General Public License v2                   
EAPI="2"
inherit eutils multilib toolchain-funcs
EGIT_REPO_URI="git://git.videolan.org/x264.git"                                      
DESCRIPTION="A free library for encoding H264/AVC video streams"                     
HOMEPAGE="http://www.videolan.org/developers/x264.html"                              
LICENSE="GPL-2"                                                                      
SLOT="0"                                                                             
KEYWORDS="~amd64"                                                                    
IUSE="debug gtk mp4 threads X"                                                       
RDEPEND="gtk? ( >=x11-libs/gtk+-2.6.10                                               
        >=dev-libs/glib-2.10.3 )                                                     
    mp4? ( media-video/gpac )                                                        
    X? ( x11-libs/libX11 )"                                                          
DEPEND="${RDEPEND}                                                                   
    dev-lang/yasm                                                                    
    dev-util/pkgconfig"                                                              

src_unpack() {                                                                       
	git_src_unpack                                                                   
	cd "${S}"                                                                        
	EPATCH_OPTS="-l"
	epatch "${FILESDIR}/${PN}-nostrip.patch"
	sed -i -e "s:git-rev-list:git rev-list:g" \
	        -e "s:git-status:git status:" \
	        "${S}"/version.sh
}
src_compile() {
	local myconf=""
	use debug && myconf="${myconf} --enable-debug"
	./configure --prefix=/usr \
	    --libdir=/usr/$(get_libdir) \
	    --enable-pic --enable-shared \
	    "--extra-cflags=${CFLAGS} -O3" \
	    "--extra-ldflags=${LDFLAGS}" \
	    "--extra-asflags=${ASFLAGS}" \
	    $(use_enable X visualize) \
	    $(use_enable threads pthread) \
	    ${myconf} \
	    || die "configure failed"
	emake CC="$(tc-getCC)" || die "make failed"
}
src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS doc/*txt
}

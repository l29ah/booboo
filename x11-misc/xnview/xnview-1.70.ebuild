# Distributed under the terms of the GNU General Public License v2 
#12.09.2005 xnview-1.70.ebuild 

inherit rpm 

MY_PN=XnView-static 
MY_P="${MY_PN}-${PV}" 

DESCRIPTION="XnView image viewer/converter" 
HOMEPAGE="http://www.xnview.com/" 
SRC_URI="http://download.xnview.com/XnView-static-fc4.i386.rpm" 

SLOT="0" 
LICENSE="free-noncomm as-is" 
KEYWORDS="x86 -*" 
IUSE="" 

DEPEND="app-arch/rpm2targz 
>=sys-devel/gcc-3.4.4-r1 
>=sys-libs/glibc-2.3.5-r1" 

S="${WORKDIR}/usr" 

src_install() { 
BASE_DIR=/opt/XnView 

into /opt 
dobin bin/{xnview,nview,nconvert} 

insinto /etc/env.d 
doins ${FILESDIR}/99XnView 

insinto /usr/lib/X11/app-defaults/XnView 
doins X11R6/lib/X11/app-defaults/XnView 
fperms 444 /usr/lib/X11/app-defaults/XnView 

doman share/man/man1/*.1 

dodoc share/doc/XnView-${PV}/*.txt 

insinto ${BASE_DIR}/Filters/ 
doins share/XnView/Filters/*.dat 
}

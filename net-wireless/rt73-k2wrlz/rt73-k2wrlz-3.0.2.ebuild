inherit multilib

DESCRIPTION="rt73 ieee80211 driver (module rt73)"
HOMEPAGE="http://www.ralinktech.com/ralink/Home/Support/Linux.html"
SRC_URI="http://homepages.tu-darmstadt.de/~p_larbig/wlan/rt73-k2wrlz-3.0.2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="|| ( sys-fs/udev
		sys-apps/hotplug )"


src_unpack()
{
	unpack "rt73-k2wrlz-3.0.2.tar.bz2"
}

src_compile()
{
	cd Module
	emake || die "make failed"
}

src_install() 
{	
	emake install || die "make install failed"
}
pkg_postinst()
{
	einfo "If you have a new kernel that supports mac80211 and includes the new
	rt73usb driver then you MUST blacklist it otherwise the ieee80211 version of the module below will not work."
	einfo "Edit /etc/modprobe.d/blacklist and add “blacklist rt73usb” as a new
	line."
	einfo "or use 'rmmod rt73usb' and 'modprobe rt73'"
	einfo "For more information visit http://www.aircrack-ng.org/doku.php?id=rt73"
}

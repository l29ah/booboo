# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hamachi/hamachi-0.9.9.9_p20.ebuild,v 1.1 2006/06/25$

inherit eutils linux-info 

# gHamachi GUI
GTK_VER="0.7.2"
GTK2_VER="0.7.2"

MY_PV=${PV/_p/-}
MY_P=${PN}-${MY_PV}-lnx

DESCRIPTION="Hamachi is a secure mediated peer to peer."
HOMEPAGE="http://hamachi.cc"
LICENSE="as-is"
SRC_URI=" !pentium? ( http://files.hamachi.cc/linux/${MY_P}.tar.gz )
	  pentium? ( http://files.hamachi.cc/linux/${MY_P}-pentium.tar.gz )
	  gtk?	   ( gtk2? ( http://purebasic.myftp.org/files/3/projects/${PN}/v.${GTK_VER}/gHamachi_gtk2.tar.gz )
	  	     !gtk2? ( http://purebasic.myftp.org/files/3/projects/${PN}/v.${GTK2_VER}/gHamachi_gtk1.2.tar.gz ) )
	  !gtk?	   ( gtk2? ( http://purebasic.myftp.org/files/3/projects/${PN}/v.${GTK_VER}/gHamachi_gtk2.tar.gz ) )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk gtk2 pentium"
RESTRICT="nostrip nomirror"
DEPEND="gtk? ( gtk2? ( >=x11-libs/gtk+-2* )
	      !gtk2? ( =x11-libs/gtk+-1.2* ) )
	!gtk? ( gtk2? ( >=x11-libs/gtk+-2* ) )"

# Set workdir for both hamachi versions
if use pentium; then
  S=${WORKDIR}/${MY_P}-pentium
else
  S=${WORKDIR}/${MY_P}
fi

pkg_preinst() {
	# Add group "hamachi" & user "hamachi"
        enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}

}


pkg_setup() { 
	einfo "Checking your kernel configuration for TUN/TAP support."
	CONFIG_CHECK="TUN"
	check_extra_config
}

src_unpack() {
	# Unpack the correct Hamachi version
	if use !pentium; then
	  unpack ${MY_P}.tar.gz
	else
	  unpack ${MY_P}-pentium.tar.gz 
	fi
	
	# Installing gHamachi readme
        if use gtk && use gtk2; then
          unpack gHamachi_gtk2.tar.gz
          mv ${WORKDIR}/README ${WORKDIR}/README.gHamachi
	elif use gtk; then
	  unpack gHamachi_gtk1.2.tar.gz
	  mv ${WORKDIR}/README ${WORKDIR}/README.gHamachi
	elif use gtk2; then
          unpack gHamachi_gtk2.tar.gz
          mv ${WORKDIR}/README ${WORKDIR}/README.gHamachi
	fi
}

src_compile() { 
	# Compile Tuncfg
	make -sC ${S}/tuncfg || die "Compiling of tunecfg failed"
}

src_install() {
	
	# Hamachi
	einfo "Installing Hamachi"
	insinto /usr/bin
	insopts -m0755
	doins hamachi
	dosym /usr/bin/hamachi /usr/bin/hamachi-init
	
	# Tuncfg
	einfo "Installing Tuncfg"
	insinto /sbin
	insopts -m0700
	doins tuncfg/tuncfg
	
	# Create log directory
	dodir /var/log/${PN}
	
	# Config files
	einfo "Installing config files"
	exeinto /etc/init.d; newexe ${FILESDIR}/tuncfg.initd tuncfg
	insinto /etc/conf.d; newins ${FILESDIR}/hamachi.confd hamachi
	exeinto /etc/init.d; newexe ${FILESDIR}/hamachi.initd hamachi

	# Docs
	dodoc CHANGES README LICENSE LICENSE.openssh LICENSE.openssl LICENSE.tuncfg

	# GTK 1.2 GUI / GTK2 GUI
	if use gtk || use gtk2; then
	  einfo "Installing GUI"	  
	  insinto /usr/bin
          insopts -m0755
          doins ${WORKDIR}/ghamachi
	  dodoc ${WORKDIR}/README.gHamachi
	fi
}

pkg_postinst() {
	if use pentium; then
	einfo "Remember, you set the pentium USE flag!"
	einfo So, you installed the version for older x86 systems!
	einfo If your CPU is greater than Intel Pentium / AMD K6,
	einfo remove the pentium USE flag and try this version!
	fi

	if use !pentium; then
	ewarn "If you are seeing 'illegal instruction' error when trying"
	ewarn "to run Hamachi client, set the pentium USE flag!"
	ewarn "It enables binaries built specifically for older" 
	ewarn "x86 platforms, like Intel Pentium or AMD K6,"
	ewarn "with all optimizations turned off."
	fi
	
	if use !gtk && use !gtk2; then
	einfo "You do not set USE flag gtk or gtk2!"
	einfo "So, you don' have any GUI!"
	einfo "Set gtk for GTK 1.2 GUI!"
	einfo "Set gtk2 for GTK2 GUI!"
	fi

	if use gtk && use !gtk2; then
        einfo "You set gtk as USE flag."
        einfo "Installed GTK 1.2 GUI!"
	einfo "If you want the GTK2 GUI,"
	einfo "set the gtk2 USE flag!"
	fi

        if use gtk2 && use !gtk; then
        einfo "You set gtk2 as USE flag."
        einfo "Installed GTK2 GUI!"
	einfo "If you want the GTK 1.2 GUI,"
	einfo "remove gtk2 USE flag and set gtk USE flag!"
        fi
	
	if use gtk && use gtk2; then
	einfo "You set gtk and gtk2 as USE flag."
	einfo "Installed GTK2 GUI!"
	fi
	
	einfo "To start Hamachi just type:"
	einfo "/etc/init.d/hamachi start"
}

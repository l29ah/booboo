# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-driver/alsa-driver-1.0.15.ebuild,v 1.4 2007/10/22 20:31:01 armin76 Exp $

inherit autotools linux-mod flag-o-matic eutils multilib linux-info

MY_P="${P/_rc/rc}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Advanced Linux Sound Architecture kernel modules"
HOMEPAGE="http://www.alsa-project.org/"

if [[ ${MY_P} == ${MY_P/_p*/} ]]; then
	SRC_URI="mirror://alsaproject/driver/${MY_P}.tar.bz2"
else # Gentoo snapshots
	SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
fi

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~x86"
IUSE="oss debug midi"

IUSE_CARDS="seq-dummy dummy virmidi mtpav mts64 serial-u16550 mpu401
loopback portman2x4 pcsp ad1848-lib cs4231-lib adlib ad1816a ad1848
als100 azt2320 cmi8330 cs4231 cs4232 cs4236 dt019x es968 es1688 es18xx
gusclassic gusextreme gusmax interwave interwave-stb opl3sa2
opti92x-ad1848 opti92x-cs4231 opti93x miro sb8 sb16 sbawe sgalaxy
sscape wavefront pc98-cs4232 msnd-pinnacle ad1889 als300 als4000
ali5451 atiixp atiixp-modem au8810 au8820 au8830 azt3328 bt87x ca0106
cmipci cs4281 cs46xx cs5535audio darla20 gina20 layla20 darla24 gina24
layla24 mona mia echo3g indigo indigoio indigodj emu10k1 emu10k1x
ens1370 ens1371 es1938 es1968 fm801 fm801-tea575x hda-intel hdsp hdspm
ice1712 ice1724 intel8x0 intel8x0m korg1212 maestro3 mixart nm256
pcxhr riptide rme32 rme96 rme9652 sonicvibes trident via82xx
via82xx-modem vx222 ymfpci pdplus asihpi powermac aoa
aoa-fabric-layout aoa-onyx aoa-tas aoa-toonie aoa-soundbus
aoa-soundbus-i2s sa11xx-uda1341 armaaci s3c2410 pxa2xx-i2sound au1x00
usb-audio usb-usx2y vxpocket pdaudiocf sun-amd7930 sun-cs4231 sun-dbri
harmony soc at91-soc at91-soc-eti-b1-wm8731 pxa2xx-soc
pxa2xx-soc-corgi pxa2xx-soc-spitz pxa2xx-soc-poodle pxa2xx-soc-tosa"

for iuse_card in ${IUSE_CARDS}; do
	IUSE="${IUSE} alsa_cards_${iuse_card}"
done

RDEPEND="virtual/modutils
	 !media-sound/snd-aoa"
DEPEND="${RDEPEND}
	>=media-sound/alsa-headers-1.0.14
	virtual/linux-sources
	sys-apps/debianutils"

PROVIDE="virtual/alsa"

pkg_setup() {
	# By default, drivers for all supported cards will be compiled.
	# If you want to only compile for specific card(s), set ALSA_CARDS
	# environment to a space-separated list of drivers that you want to build.
	# For example:
	#
	#	env ALSA_CARDS='emu10k1 intel8x0 ens1370' emerge alsa-driver
	#
	ALSA_CARDS=${ALSA_CARDS:-${IUSE_ALSA_CARDS}}

	local PNP_DRIVERS="interwave interwave-stb"
	local PNP_ERROR="Some of the drivers you selected require PnP support in your kernel (${PNP_DRIVERS}). Either enable PnP in your kernel or trim which drivers get compiled using ALSA_CARDS in /etc/make.conf."

	local ISA_DRIVERS="cs4232 msnd-pinnacle cs4231-lib adlib ad1816a ad1848 als100 azt2320
		cmi8330 cs4231 cs4236 dt019x  es968 es1688 es18xx gusclassic gusextreme gusmax
		interwave interwave-stb opl3sa2 opti92x-ad1848 opti92x-cs4231 opti93x miro sb8
		sb16 sbawe sb16_csp sgalaxy sscape wavefront"
	local ISA_ERROR="Some of the drivers you selected require ISA support in your kernel ($(echo $ISA_DRIVERS)). Either enable ISA in your kernel or trim which drivers get compiled using ALSA_CARDS in /etc/make.conf."

	local FW_DRIVERS="darla20 gina20 layla20 darla24 gina24 layla24 mona mia echo3g indigo
		indigoio indigodj emu10k1 korg1212 maestro3 riptide ymfpci asihpi"
	local FW_LOADER_ERROR="Some of the drivers you selected require 'Userspace firmware loading support' in your kernel (${FW_DRIVERS}). Either enable that feature or trim which drivers get compiled using ALSA_CARDS in /etc/make.conf."

	local PARPORT_DRIVERS="portman2x4"
	local PARPORT_ERROR="Some if the drivers you selected require Parallel Port support (${PARPORT_DRIVERS}). Either enable that feature or trim which drivers get compiled using ALSA_CARDS in /etc/make.conf."

	local TMP_ALSA_CARDS
	local CHECK_PNP
	local CHECK_ISA
	local CHECK_FW
	local CHECK_PARPORT
	for card in ${ALSA_CARDS}; do
		if has alsa_cards_${card} ${IUSE} && use alsa_cards_${card}; then
			TMP_ALSA_CARDS="${TMP_ALSA_CARDS} ${card}"
			has ${card} ${PNP_DRIVERS} && CHECK_PNP="PNP"
			has ${card} ${ISA_DRIVERS} && CHECK_ISA="ISA"
			has ${card} ${FW_DRIVERS} && CHECK_FW="FW_LOADER"
			has ${card} ${PARPORT_DRIVERS} && CHECK_PARPORT="PARPORT"
		fi
	done
	ALSA_CARDS="${TMP_ALSA_CARDS}"

	local CONFIG_CHECK="!SND SOUND ${CHECK_PNP} ${CHECK_ISA} ${CHECK_FW} ${CHECK_PARPORT}"
	local SND_ERROR="ALSA is already compiled into the kernel. This is the recommended configuration, don't emerge alsa-driver."
	local SOUND_ERROR="Your kernel doesn't have sound support enabled."
	local SOUND_PRIME_ERROR="Your kernel is configured to use the deprecated OSS drivers.	 Please disable them and re-emerge alsa-driver."

	linux-mod_pkg_setup

	if [[ ${PROFILE_ARCH} == "sparc64" ]] ; then
		export CBUILD=${CBUILD-${CHOST}}
		export CHOST="sparc64-unknown-linux-gnu"
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"

	#kernel_is 2 4 && epatch "${FILESDIR}"/alsa-driver-1.0.15-linux-2.4.patch

	convert_to_m "${S}/Makefile"
	sed -i -e 's:\(.*depmod\):#\1:' "${S}/Makefile"
	eautoconf
}

src_compile() {
	local myABI=${ABI:-${DEFAULT_ABI}}

	# Should fix bug #46901
	is-flag "-malign-double" && filter-flags "-fomit-frame-pointer"
	append-flags "-I${KV_DIR}/arch/$(tc-arch-kernel)/include"

	econf $(use_with oss) \
		$(use_with debug debug full) \
		--with-kernel="${KV_DIR}" \
		--with-build="${KV_OUT_DIR}" \
		--with-isapnp=yes \
		$(use_with midi sequencer) \
		--with-cards="${ALSA_CARDS}" || die "econf failed"

	# linux-mod_src_compile doesn't work well with alsa

	ARCH=$(tc-arch-kernel)
	ABI=${KERNEL_ABI}
	emake LDFLAGS="$(raw-ldflags)" HOSTCC="$(tc-getBUILD_CC)" CC="$(tc-getCC)" || die "Make Failed"
	ARCH=$(tc-arch)
	ABI=${myABI}
}

src_install() {
	emake DESTDIR="${D}" install-modules || die "make install failed"

	dodoc CARDS-STATUS FAQ README WARNING TODO

	if kernel_is 2 6; then
		# mv the drivers somewhere they won't be killed by the kernel's make modules_install
		mv "${D}/lib/modules/${KV_FULL}/kernel/sound" "${D}/lib/modules/${KV_FULL}/${PN}"
		rmdir "${D}/lib/modules/${KV_FULL}/kernel" &> /dev/null
	fi
}

pkg_postinst() {
	elog
	elog "Remember that all mixer channels will be MUTED by default."
	elog "Use the 'alsamixer' program to unmute them, then save your"
	elog "mixer settings with /etc/init.d/alsasound save"
	elog
	elog "If you experience problems, please try building the in-kernel"
	elog "ALSA drivers instead. This ebuild is not recommended and is"
	elog "likely to be removed from portage at a later date."
	elog

	linux-mod_pkg_postinst

	if kernel_is 2 6 && [ -e "${ROOT}/lib/modules/${KV_FULL}/kernel/sound" ]; then
		# Cleanup if they had older alsa installed
		for file in $(find "${ROOT}/lib/modules/${KV_FULL}/${PN}" -type f); do
			rm -f ${file//${KV_FULL}\/${PN}/${KV_FULL}\/kernel\/sound}
		done

		find "${ROOT}/lib/modules/${KV_FULL}/kernel/sound" -type d -print0 | xargs --null rmdir
	fi
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit eutils versionator
MY_PV1=${PV%.*.*}

DESCRIPTION="Collection of Lingvo dicts for stardict. Russian to English"
HOMEPAGE="http://seclorum.msk.ru"

SRC_URI="ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_Auto.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_Biology.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_Building.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_Computers.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_Engineering.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_Law.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_LingvoComputer.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_LingvoEconomics.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_LingvoScience.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_MechanicalEngineering.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_Medical.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_OilAndGas.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_Patents.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_PhraseBook.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_Physics.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_Politics.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_Psychology.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_RadioElectronics.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_Religion.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_Telecoms.tar.bz2
	 ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_RU_EN_Universal.tar.bz2"

LICENSE="Lingvo"
KEYWORDS="~x86 ~amd64"
SLOT="0"

IUSE="+Auto                                                             
      +Biology                                                          
      +Building                                                         
      +Computers                                                        
      +Engineering                                                      
      +Law                                                              
      +LingvoComputer                                                   
      +LingvoEconomics                                                  
      +LingvoScience                                                    
      +MechanicalEngineering                                            
      +Medical                                                          
      +OilAndGas                                                        
      +Patents
      +PhraseBook
      +Physics
      +Politics
      +Psychology
      +RadioElectronics
      +Religion
      +Telecoms
      +Universal"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	local i
	
	mkdir -p ${D}/usr/share/stardict/dic

	for i in ${USE};
	do
	  if use $i; then
		cp -R ${WORKDIR}/${i}RuEn.* ${D}/usr/share/stardict/dic/
	  fi
	done
}

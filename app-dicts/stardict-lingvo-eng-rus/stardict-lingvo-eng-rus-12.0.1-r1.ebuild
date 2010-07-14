# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit eutils versionator

MY_PV1=${PV%.*.*}

DESCRIPTION="Collection of Lingvo dicts for stardict. English to Russian"
HOMEPAGE="http://seclorum.msk.ru"

SRC_URI="ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Accounting.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Americana.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Auto.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Biology.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Building.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Computers.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Engineering.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_FinancialManagement.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_FinancialMarkets.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_GreatBritain.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Idioms.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Informal.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Law.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_LingvoComputer.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_LingvoEconomics.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_LingvoGrammar.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_LingvoScience.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_LingvoUniversal.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Management.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Marketing.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_MechanicalEngineering.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Medical.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_OilAndGas.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Patents.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Physics.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Politics.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Psychology.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_RadioElectronics.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Telecoms.tar.bz2
ftp://seclorum.msk.ru/etc/gentoo/portage/distfiles/LS${MY_PV1}_EN_RU_Wine.tar.bz2
"

LICENSE="Lingvo"
KEYWORDS="~x86 ~amd64"
SLOT="0"

IUSE="+Accounting                                                              
      +Americana                                                               
      +Auto                                                                    
      +Biology                                                                 
      +Building                                                                
      +Computers                                                               
      +Engineering                                                             
      +FinancialManagement                                                     
      +FinancialMarkets                                                        
      +GreatBritain                                                            
      +Idioms                                                                  
      +Informal                                                                
      +Law                                                                     
      +LingvoComputer                                                          
      +LingvoEconomics                                                         
      +LingvoGrammar                                                           
      +LingvoScience                                                           
      +LingvoUniversal                                                         
      +Management                                                              
      +Marketing                                                               
      +MechanicalEngineering                                                   
      +Medical
      +OilAndGas
      +Patents
      +Physics
      +Politics
      +Psychology
      +RadioElectronics
      +Telecoms
      +Wine"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	mkdir -p ${D}/usr/share/stardict/dic
	
	if use Accounting; then
		cp -R ${WORKDIR}/AccountingEnRu_new.* ${D}/usr/share/stardict/dic/
	fi

	if use Americana; then
		cp -R ${WORKDIR}/AmericanaEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use Auto; then
		cp -R ${WORKDIR}/AutoEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use Biology; then
		cp -R ${WORKDIR}/BiologyEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use Building; then
		cp -R ${WORKDIR}/BuildingEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use Computers; then
		cp -R ${WORKDIR}/ComputersEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use Engineering; then
		cp -R ${WORKDIR}/EngineeringEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use FinancialManagement; then
		cp -R ${WORKDIR}/FinancialManagementEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use FinancialMarkets; then
		cp -R ${WORKDIR}/FinancialMarketsEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use GreatBritain; then
		cp -R ${WORKDIR}/GreatBritainEnRu.* ${D}/usr/share/stardict/dic/
	fi
	
	if use Idioms; then
		cp -R ${WORKDIR}/IdiomsEnRu.* ${D}/usr/share/stardict/dic/
	fi
	
	if use Informal; then
		cp -R ${WORKDIR}/InformalEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use Law; then
		cp -R ${WORKDIR}/LawEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use LingvoComputer; then
		cp -R ${WORKDIR}/LingvoComputerEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use LingvoEconomics; then
		cp -R ${WORKDIR}/LingvoEconomicsEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use LingvoGrammar; then
		cp -R ${WORKDIR}/LingvoGrammarEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use LingvoScience; then
		cp -R ${WORKDIR}/LingvoScienceEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use LingvoUniversal; then
		cp -R ${WORKDIR}/LingvoUniversalEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use Management; then
		cp -R ${WORKDIR}/ManagementEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use Marketing; then
		cp -R ${WORKDIR}/MarketingEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use MechanicalEngineering; then
		cp -R ${WORKDIR}/MechanicalEngineeringEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use Medical; then
		cp -R ${WORKDIR}/MedicalEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use OilAndGas; then
		cp -R ${WORKDIR}/OilAndGasEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use Patents; then
		cp -R ${WORKDIR}/PatentsEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use Physics; then
		cp -R ${WORKDIR}/PhysicsEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use Politics; then
		cp -R ${WORKDIR}/PoliticsEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use Psychology; then
		cp -R ${WORKDIR}/PsychologyEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use RadioElectronics; then
		cp -R ${WORKDIR}/RadioElectronicsEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use Telecoms; then
		cp -R ${WORKDIR}/TelecomsEnRu.* ${D}/usr/share/stardict/dic/
	fi

	if use Wine; then
		cp -R ${WORKDIR}/WineEnRu.* ${D}/usr/share/stardict/dic/
	fi

}

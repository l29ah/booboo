# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg qmake-utils wrapper #git-r3

DESCRIPTION="Open Source 2D CAD"
HOMEPAGE="http://www.qcad.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

L10N=( ar bg ca cs da de el en es et fa fi fr gl he hr hu id it ja ko lt lv nl pl pt ro ru sk sl sv th tr uk zh_CN zh_TW )

IUSE=""

for lingua in ${L10N[*]}; do
	IUSE+=" l10n_${lingua}"
done

DEPEND="
	dev-libs/glib
	media-libs/glu
	media-libs/mesa
	dev-qt/designer:5=
	dev-qt/qtcore:5=
	dev-qt/qtgui:5=
	dev-qt/qthelp:5=
	dev-qt/qtopengl:5=
	dev-qt/qtscript:5=[scripttools]
	dev-qt/qtsql:5=
	dev-qt/qtsvg:5=
	dev-qt/qtxmlpatterns:5=
	dev-qt/qtwebengine:5=
"
RDEPEND="${DEPEND}"

src_prepare() {
	# This is the latest known src/3rdparty/qt-labs-qtscriptgenerator-<qtversion>
	local myqtvsrc="5.15.3"	# available since 3.27.6.10

	local myqt=$(best_version dev-qt/qtcore:5)
	local myqtv=${myqt#dev-qt/qtcore-}
	local myqtv=${myqtv%-r*}

	if ! test -d "${S}/src/3rdparty/qt-labs-qtscriptgenerator-${myqtv}"
	then
		einfo "Creating QT configuration for QT ${myqtv}"
		mkdir "${S}/src/3rdparty/qt-labs-qtscriptgenerator-${myqtv}"
		ln "${S}/src/3rdparty/qt-labs-qtscriptgenerator-${myqtvsrc}/qt-labs-qtscriptgenerator-${myqtvsrc}.pro" "${S}/src/3rdparty/qt-labs-qtscriptgenerator-${myqtv}/qt-labs-qtscriptgenerator-${myqtv}.pro"
	fi

	default

	cd "${S}"
	for lingua in "${L10N[@]}"
	do
		if ! use l10n_${lingua}
		then
			find -type f -name "*_${lingua}.*" -delete
			# drop translation but leave the line continuation mark at the end of each line
			sed -i "s|\$\$.*/\$\${NAME}_${lingua}\.ts||" shared_ts.pri scripts/Misc/translations.pri
		fi
	done

	# we call qmake in src_configure
	sed -i '/qmake/d' src/scripts/update_qrc.sh
	src/scripts/update_qrc.sh || die
}

src_configure() {
	eqmake5 -r || die
}

src_install() {
	# Create Wayland desktop entry
	cp qcad.desktop qcad-wayland.desktop
	sed -i 's/Exec=qcad/Exec=qcad -platform xcb/g' qcad-wayland.desktop
	sed -i 's/Name=QCAD/Name=QCAD (Wayland)/g' qcad-wayland.desktop

	domenu "${S}"/*.desktop
	doicon "${S}/scripts/${PN}_icon.svg"
	doicon --size 256 "${S}/scripts/${PN}_icon.png"

	cd "${S}"
	rm -f ts/*.pro

	insinto /usr/lib/${PN}/
	doins -r scripts fonts patterns linetypes themes ts
	insopts -m0755
	doins release/*
	make_wrapper ${PN} /usr/lib/${PN}/qcad-bin "" /usr/lib/${PN}:/usr/lib/${PN}/plugins || die
	doins -r plugins

	docinto examples
	dodoc -r examples/*
	docompress -x /usr/share/doc/${PF}/examples
}

pkg_postinst() {
	xdg_pkg_postinst
}

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

	# drop readme files that do not need to be installed
	find plugins platform* xcb* -type f -name readme.txt -delete

	# qcad cannot load plugins from the system QT plugins dir, as described
	# in this comment from qcad's src/run/main.cpp:
	#   // disable Qt library paths to avoid plugins for Qt designer from being found:
	# By default qcad copies the QT libs and plugins. We symlink them instead.
	sed -i -e 's/system(cp \(-r \)\?/system(ln -s /' -e 's/copying file/symlinking file/' src/run/run.pri
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

	local qcad_dir=$(qt5_get_libdir)/${PN}

	insinto ${qcad_dir}/
	doins -r fonts libraries linetypes patterns themes ts

	# do not install build files under scripts/
	find scripts -type f -name '.gitignore' -or -name '*.pro' -or -name '*.pri' -delete
	# scripts get compiled into plugins/libqcadscripts.so (which is faster)
	# we also install them as documentation and to allow modification if desired
	keepdir ${qcad_dir}/scripts
	docinto scripts
	dodoc -r scripts/*
	docompress -x /usr/share/doc/${PF}/scripts

	insopts -m0755
	doins release/*

	# qcad plugins can only be installed in ${qcad_dir}/plugin.
	# Setting ldpath allows qcad to find/load any libs required by those plugins.
	make_wrapper ${PN} ${qcad_dir}/qcad-bin "" ${qcad_dir}:${qcad_dir}/plugins || die

	# this mirrors src/run/run.pri
	doins -r plugins platform* xcb* wayland-*

	docinto examples
	dodoc -r examples/*
	docompress -x /usr/share/doc/${PF}/examples

	doman ${PN}.1
}

pkg_postinst() {
	xdg_pkg_postinst
}

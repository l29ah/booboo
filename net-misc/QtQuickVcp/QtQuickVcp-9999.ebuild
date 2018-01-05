# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 qmake-utils

DESCRIPTION="A Virtual Control Panel for Machinekit written in Qt/C++/QML"
HOMEPAGE="https://github.com/qtquickvcp/QtQuickVcp"
EGIT_REPO_URI="https://github.com/qtquickvcp/QtQuickVcp"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtquickcontrols:5
	dev-qt/qtwidgets:5
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtdeclarative:5[xml]
"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake5
}

src_install() {
	# QQmlComponent: Component is not ready
	export LD_LIBRARY_PATH="$PWD/3rdparty/machinetalk-protobuf-qt/:$LD_LIBRARY_PATH"
	emake INSTALL_ROOT="${D}" install || die
}

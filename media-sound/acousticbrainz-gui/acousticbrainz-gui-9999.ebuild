# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="This client lets you submit your own audio features to the AcousticBrainz project."
HOMEPAGE="https://github.com/MTG/acousticbrainz-gui/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/MTG/acousticbrainz-gui.git"
EGIT_COMMIT="c70a6dcd0f8574e94692ed5cf745d3612436b107" # before they switch to Qt5

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtgui
	dev-libs/qjson"
RDEPEND="${DEPEND}"

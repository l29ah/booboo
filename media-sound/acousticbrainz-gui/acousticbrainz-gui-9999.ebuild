# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8

inherit cmake git-r3

DESCRIPTION="This client lets you submit your own audio features to the AcousticBrainz project."
HOMEPAGE="https://github.com/MTG/acousticbrainz-gui/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/MTG/acousticbrainz-gui.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtgui:5"
RDEPEND="${DEPEND}"

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools eutils git-r3 cmake-utils

DESCRIPTION="(Louiz's fork of the) Integrates C++ objects tightly to relational database and thus provides an object persistence layer."
HOMEPAGE="https://lab.louiz.org/louiz/litesql"
EGIT_REPO_URI="https://lab.louiz.org/louiz/litesql"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="doc examples mysql postgres sqlite"

RDEPEND="mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql )
	sqlite? ( =dev-db/sqlite-3* )
	!mysql? ( !postgres? ( !sqlite? ( =dev-db/sqlite-3* ) ) )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

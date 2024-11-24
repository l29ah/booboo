# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit meson python-single-r1 git-r3

EGIT_REPO_URI="https://github.com/igo95862/bubblejail.git"
KEYWORDS=""

DESCRIPTION="Bubblejail is a bubblewrap-based alternative to Firejail."
HOMEPAGE="https://github.com/igo95862/bubblejail"

LICENSE="GPL-3"
SLOT="0"

IUSE="doc gui fish-completion bash-completion"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="
	>=dev-python/jinja-2
	doc? ( app-text/scdoc )
"

DEPEND="
	${PYTHON_DEPS}
	sys-apps/bubblewrap
	$(python_gen_cond_dep '
		dev-python/pyxdg[${PYTHON_USEDEP}]
		dev-python/tomli[${PYTHON_USEDEP}]
		dev-python/tomli-w[${PYTHON_USEDEP}]
		sys-libs/libseccomp[${PYTHON_USEDEP}]
		gui? ( dev-python/pyqt6[${PYTHON_USEDEP}] )
	')
"

RDEPEND="${DEPEND}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	emesonargs+=(
		$(meson_use doc man)
	)

	meson_src_configure
}

src_install() {
	INSTALL_TAGS="runtime"
	use doc && INSTALL_TAGS+=",man"
	use gui && INSTALL_TAGS+=",bubblejail-gui"
	use fish-completion && INSTALL_TAGS+=",fish-completion"
	use bash-completion && INSTALL_TAGS+=",bash-completion"
	meson_src_install --tags ${INSTALL_TAGS}
}

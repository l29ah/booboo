# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit multilib-minimal

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PortAudio/portaudio"
else
	SRC_URI="http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz"
	KEYWORDS="alpha amd64 ~arm ~arm64 ~hppa ia64 ~mips ppc ppc64 ~sh sparc x86 ~amd64-fbsd ~amd64-linux ~x86-linux"
	S=${WORKDIR}/${PN}
fi

DESCRIPTION="A free, cross-platform, open-source, audio I/O library"
HOMEPAGE="http://www.portaudio.com/"

LICENSE="MIT"
SLOT="0"
IUSE="alsa +cxx debug doc examples jack oss static-libs"

RDEPEND="alsa? ( >=media-libs/alsa-lib-1.0.27.2[${MULTILIB_USEDEP}] )
	jack? ( virtual/jack[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	virtual/pkgconfig"

DOCS=( README.md )

multilib_src_configure() {
	local myeconfargs=(
		$(use_enable debug debug-output)
		$(use_enable cxx)
		$(use_enable static-libs static)
		$(use_with alsa)
		$(use_with jack)
		$(use_with oss)
	)

	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

multilib_src_compile() {
	# workaround parallel build issue
	emake lib/libportaudio.la
	emake
}

src_compile() {
	multilib-minimal_src_compile

	if use doc; then
		doxygen -u Doxyfile || die
		doxygen Doxyfile || die
	fi
}

multilib_src_install() {
	emake DESTDIR="${D}" install

	if multilib_is_native_abi; then
		use examples && dobin bin/.libs/*
	fi
}

multilib_src_install() {
	emake DESTDIR="${D}" install

	if multilib_is_native_abi; then
		use examples && dobin bin/.libs/*
	fi
}

multilib_src_install_all() {
	einstalldocs
	use doc && dodoc -r doc/html
	find "${ED}" -name "*.la" -delete || die
}

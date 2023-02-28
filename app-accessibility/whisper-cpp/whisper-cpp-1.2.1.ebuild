# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="High-performance automatic speech recognition (ASR) using inference"
HOMEPAGE="https://github.com/ggerganov/whisper.cpp"
LICENSE="MIT"

SRC_URI="https://github.com/ggerganov/whisper.cpp/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

S="${WORKDIR}/${PN/-/.}-${PV}"

IUSE="+command +models +stream"

DEPEND="
	command? ( media-libs/libsdl2 )
	stream? ( media-libs/libsdl2 )
"
RDEPEND="${DEPEND}
	models? ( app-accessibility/whisper-ggml-models )
"
BDEPEND=""

# FIXME: libtoolise libwhisper.so
# FIXME: make commands use libwhisper.so
# TODO: add 'talk' example (uses a shell script; check system call for security and fix paths)

src_prepare() {
	sed 's/^[[:space:]]\+.\/main -h$//' -i Makefile || die

	local target
	for target in main "${target_list[@]}"; do
		sed 's~"models/~"/usr/share/whisper/ggml-models/~' -i "examples/$target/$target.cpp"
	done

	default
}

src_configure() {
	if use ppc64; then
		sed 's/#include <immintrin.h>//' -i ggml.c || die
	fi
}

target_list=(
	command
	stream
)

src_compile() {
	local common_cflags=(
		-I.
		-fPIC
		-pthread
	)
	local my_makeopts=(
		CFLAGS="-std=c11 ${common_cflags[*]} ${CFLAGS}"
		CXXFLAGS="-std=c++11 ${common_cflags[*]} -I./examples ${CXXFLAGS}"
		LDFLAGS="${LDFLAGS}"
	)
	local my_targets=(
		main
		libwhisper.so
	)
	local target
	for target in "${target_list[@]}"; do
		use "$target" || continue

		my_targets+=( "$target" )
	done
	emake "${my_makeopts[@]}" "${my_targets[@]}"
}

src_install() {
	newbin main whisper-cpp
	dolib.so libwhisper.so
	for target in "${target_list[@]}"; do
		newbin "$target" "whisper-cpp_$target"
	done
}

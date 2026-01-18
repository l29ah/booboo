# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ROCM_VERSION="6.3"

inherit cmake cuda rocm linux-info

MY_PN=stable-diffusion.cpp
if [[ "${PV}" != "9999" ]]; then
	KEYWORDS="~amd64"
	MY_PV="b${PV#0_pre}"
	S="${WORKDIR}/${MY_PN}-${MY_PV}"
	SRC_URI="https://github.com/leejet/stable-diffusion.cpp/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/leejet/stable-diffusion.cpp"
fi

DESCRIPTION="Diffusion model(SD,Flux,Wan,Qwen Image,Z-Image,...) inference in pure C/C++"
HOMEPAGE="https://github.com/leejet/stable-diffusion.cpp"

LICENSE="MIT"
SLOT="0"
CPU_FLAGS_X86=( avx avx2 f16c )
IUSE="openblas blis hip cuda opencl vulkan flexiblas"
REQUIRED_USE="?? ( openblas blis flexiblas )"

# numpy is used by convert_hf_to_gguf.py
CDEPEND="
	openblas? ( sci-libs/openblas:= )
	blis? ( sci-libs/blis:= )
	flexiblas? ( sci-libs/flexiblas:= )
	hip? ( >=dev-util/hip-6.3:=
		>=sci-libs/hipBLAS-6.3:=
	)
	cuda? ( dev-util/nvidia-cuda-toolkit:= )
"
DEPEND="${CDEPEND}
	opencl? ( dev-util/opencl-headers )
	vulkan? ( dev-util/vulkan-headers )
"
RDEPEND="${CDEPEND}
	dev-python/numpy
	opencl? ( dev-libs/opencl-icd-loader )
	vulkan? ( media-libs/vulkan-loader )
"
BDEPEND="media-libs/shaderc"

pkg_setup() {
	if use hip; then
		linux-info_pkg_setup
		if linux-info_get_any_version && linux_config_exists; then
			if ! linux_chkconfig_present HSA_AMD_SVM; then
				ewarn "To use ROCm/HIP, you need to have HSA_AMD_SVM option enabled in your kernel."
			fi
		fi

	fi
}

src_prepare() {
	use cuda && cuda_src_prepare

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_BUILD_RPATH=ON
		-DGGML_NATIVE=0	# don't set march
		-DSD_CUDA=$(usex cuda ON OFF)
		-DSD_OPENCL=$(usex opencl ON OFF)
		-DSD_VULKAN=$(usex vulkan ON OFF)

		# avoid clashing with whisper.cpp
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)/${MY_PN}"
		-DCMAKE_INSTALL_RPATH="${EPREFIX}/usr/$(get_libdir)/${MY_PN}"
	)

	if use openblas ; then
		mycmakeargs+=(
			-DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS
		)
	fi

	if use blis ; then
		mycmakeargs+=(
			-DGGML_BLAS=ON -DGGML_BLAS_VENDOR=FLAME
		)
	fi

	if use flexiblas; then
		mycmakeargs+=(
			-DGGML_BLAS=ON -DGGML_BLAS_VENDOR=FlexiBLAS
		)
	fi

	if use cuda; then
		local -x CUDAHOSTCXX="$(cuda_gccdir)"
		# tries to recreate dev symlinks
		cuda_add_sandbox
		addpredict "/dev/char/"
	fi

	if use hip; then
		rocm_use_hipcc
		mycmakeargs+=(
			-DGGML_HIP=ON -DAMDGPU_TARGETS=$(get_amdgpu_flags)
		)
	fi

	cmake_src_configure
}

src_install() {
	cmake_src_install

	# avoid clashing with whisper.cpp
	rm -rf "${ED}/usr/include"
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

CMAKE_MAKEFILE_GENERATOR=emake

inherit python-single-r1 cmake git-r3

EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

EGIT_BLASFEO_REPO_URI="https://github.com/giaf/blasfeo.git"
EGIT_BLASFEO_COMMIT="edf92b396adddd9e548b9786f87ad290a0971329"
EGIT_HPIPM_REPO_URI="https://github.com/jgillis/hpipm.git"
EGIT_HPIPM_COMMIT="0e0c9f4e0d4081dceafa9b37c396db50bce0e81a"
EGIT_FATROP_REPO_URI="https://github.com/jgillis/fatrop.git"
EGIT_FATROP_COMMIT="1d5a830f3926a8a07cdf78d33115c4b30ced0e4e"
EGIT_FATROP_BRANCH="ocp_c_interface2"
EGIT_SUPERSCS_REPO_URI="https://github.com/jgillis/scs.git"
EGIT_SUPERSCS_COMMIT="4d2d1bd03ed4cf93e684a880b233760ce34ca69c"
EGIT_SUPERSCS_BRANCH="main"
EGIT_OSQP_REPO_URI="https://github.com/osqp/osqp.git"
EGIT_OSQP_COMMIT="v0.6.2"
EGIT_EIGEN3_REPO_URI="https://gitlab.com/libeigen/eigen.git"
EGIT_EIGEN3_COMMIT="3.4.0"
EGIT_SIMDE_REPO_URI="https://github.com/simd-everywhere/simde.git"
EGIT_SIMDE_COMMIT="v0.7.2"
EGIT_PROXQP_REPO_URI="https://github.com/Simple-Robotics/proxsuite.git"
EGIT_PROXQP_COMMIT="v0.3.2"
EGIT_LAPACK_REPO_URI="https://github.com/xianyi/OpenBLAS.git"
EGIT_LAPACK_COMMIT="v0.3.21"
EGIT_TRLIB_REPO_URI="https://github.com/jgillis/trlib.git"
EGIT_TRLIB_COMMIT="c7632b8b14152e78bc21721a3bd1a2432586b824"
EGIT_SLEQP_REPO_URI="https://github.com/jgillis/sleqp.git"
EGIT_SLEQP_BRANCH="patch-1"
EGIT_IPOPT_REPO_URI="https://github.com/jgillis/Ipopt-1.git"
EGIT_IPOPT_COMMIT="3.14.11.mod"
EGIT_BONMIN_REPO_URI="https://github.com/coin-or/Bonmin.git"
EGIT_BONMIN_COMMIT="releases/1.8.9"
EGIT_CBC_REPO_URI="https://github.com/coin-or/Cbc.git"
EGIT_CBC_COMMIT="releases/2.10.11"
EGIT_CLP_REPO_URI="https://github.com/coin-or/Clp.git"
EGIT_CLP_COMMIT="releases/1.17.9"
EGIT_COINUTILS_REPO_URI="https://github.com/coin-or/CoinUtils.git"
EGIT_COINUTILS_COMMIT="releases/2.11.10"
EGIT_CGL_REPO_URI="https://github.com/coin-or/Cgl.git"
EGIT_CGL_COMMIT="releases/0.60.8"
EGIT_OSI_REPO_URI="https://github.com/coin-or/Osi.git"
EGIT_OSI_COMMIT="releases/0.108.9"
EGIT_MUMPS_REPO_URI="https://github.com/coin-or-tools/ThirdParty-Mumps.git"
EGIT_MUMPS_COMMIT="releases/3.0.2"
EGIT_METIS_REPO_URI="https://github.com/coin-or-tools/ThirdParty-Metis.git"
EGIT_METIS_COMMIT="releases/2.0.0"
EGIT_SPRAL_REPO_URI="https://github.com/ralna/spral.git"
EGIT_SPRAL_COMMIT="d385d2c9e858366d257cafaaf05760ffa6543e26"
EGIT_SPRAL_BRANCH="master"
EGIT_HIGHS_REPO_URI="https://github.com/ERGO-Code/HiGHS"
EGIT_HIGHS_COMMIT="v1.6.0"
EGIT_DAQP_REPO_URI="https://github.com/jgillis/daqp.git"
EGIT_DAQP_BRANCH="master"
EGIT_ALPAQA_REPO_URI="https://github.com/jgillis/alpaqa"
EGIT_ALPAQA_BRANCH="develop"

EGIT_EXTERNAL_REPOS=( alpaqa blasfeo bonmin cbc clp daqp eigen3 fatrop highs hpipm ipopt lapack mumps osqp proxqp simde sleqp spral superscs trlib )

DESCRIPTION="CasADi is a symbolic framework for numeric optimization implementing automatic differentiation in forward and reverse modes on sparse matrix-valued computational graphs."
HOMEPAGE="https://casadi.org"

LICENSE="LGPL-3"
SLOT="0"
IUSE="alpaqa ampl blasfeo blocksqp bonmin cbc clp cplex csparse daqp dsdp gurobi eigen3 fatrop highs hpipm hsl +ipopt knitro +lapack +mumps octave osqp proxqp +python qpoases simde sleqp snopt spral sundials superscs system-csparse +system-eigen3 +system-ipopt +system-lapack +system-metis +system-mumps system-sundials +system-xml trlib +xml worhp"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	system-csparse? ( sci-libs/csparse )
	system-eigen3? ( dev-cpp/eigen )
	system-ipopt? ( sci-libs/ipopt )
	system-lapack? ( virtual/lapack virtual/blas )
	system-metis? ( sci-libs/metis )
	system-mumps? ( sci-libs/mumps[metis,-mpi] )
	octave? ( >=sci-mathematics/octave-6 )
	python? (
		${PYTHON_DEPS}
	)
	system-sundials? ( sci-libs/sundials[lapack?] )
	system-xml? ( dev-libs/tinyxml2 )
	"
DEPEND="${RDEPEND}"
BDEPEND="python? ( dev-lang/swig )"

REQUIRED_USE="
    hpipm? ( blasfeo )
    fatrop? ( blasfeo )
    proxqp? ( eigen3 simde )
    ipopt? ( mumps )
    bonmin? ( ipopt cbc )
    cbc? ( clp )
    clp? ( mumps lapack )
	mumps? ( lapack )
    spral? ( lapack )
    hsl? ( lapack )
    alpaqa? ( eigen3 )
	system-mumps? ( system-metis )
"

pkg_setup() {
    use python && python-single-r1_pkg_setup
}

src_unpack() {
	git-r3_src_unpack

	for proj in "${EGIT_EXTERNAL_REPOS[@]}"; do
		if use ${proj} && ( ! in_iuse system-${proj} || ( in_iuse system-${proj} && ! use system-${proj} ) ); then
			(
				unset EGIT_COMMIT EGIT_BRANCH EGIT_REPO_URI EGIT_CHECKOUT_DIR
				eval EGIT_REPO_URI=\${EGIT_${proj^^}_REPO_URI}
				eval EGIT_BRANCH=\${EGIT_${proj^^}_BRANCH}
				[[ -z ${EGIT_BRANCH} ]] && unset EGIT_BRANCH
				eval EGIT_COMMIT=\${EGIT_${proj^^}_COMMIT}
				[[ -z ${EGIT_COMMIT} ]] && unset EGIT_COMMIT
				EGIT_CHECKOUT_DIR="${WORKDIR}/external_projects/${proj}"

				git-r3_src_unpack
			)
		fi
	done
	if use mumps && ! use system-metis ; then
		(
			unset EGIT_COMMIT EGIT_BRANCH EGIT_REPO_URI EGIT_CHECKOUT_DIR
			EGIT_REPO_URI=${EGIT_METIS_REPO_URI}
			EGIT_COMMIT=${EGIT_METIS_COMMIT}
			EGIT_CHECKOUT_DIR="${WORKDIR}/external_projects/metis"

			git-r3_src_unpack
		)
	fi

	if use clp || use cbc; then
		(
			unset EGIT_COMMIT EGIT_BRANCH EGIT_REPO_URI EGIT_CHECKOUT_DIR
			EGIT_REPO_URI=${EGIT_COINUTILS_REPO_URI}
			EGIT_COMMIT=${EGIT_COINUTILS_COMMIT}
			EGIT_CHECKOUT_DIR="${WORKDIR}/external_projects/coinutils"

			git-r3_src_unpack
		)
	fi
}

src_prepare() {
	sed -i 's/dmumps_seq/dmumps/' cmake/FindMUMPS.cmake

	if use system-mumps ; then
		eapply "${FILESDIR}"/${P}-mumps-no-mpi-fix.patch
	fi

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		# Author does not know how to use LIB_PREFIX/LIB_SUFFIX pair in cmake
		-DLIB_PREFIX=/usr/$(get_libdir)
		-DENABLE_EXPORT_ALL=ON
		-DWITH_OCTAVE=$(usex octave)
		-DWITH_MATLAB=OFF
		-DWITH_THREAD=ON
		-DWITH_PYTHON=$(usex python)
		-DWITH_PYTHON3=$(usex python)
		-DWITH_ALPAQA=$(usex alpaqa)
		-DWITH_AMPL=$(usex ampl)
		-DWITH_BUILD_ALPAQA=$(usex alpaqa)
		-DWITH_BLASFEO=$(usex blasfeo)
		-DWITH_BUILD_BLASFEO=$(usex blasfeo)
		-DWITH_BONMIN=$(usex bonmin)
		-DWITH_BUILD_BONMIN=$(usex bonmin)
		-DWITH_BLOCKSQP=$(usex blocksqp)
		-DWITH_CBC=$(usex cbc)
		-DWITH_BUILD_CBC=$(usex cbc)
		-DWITH_CLP=$(usex clp)
		-DWITH_BUILD_CLP=$(usex clp)
		-DWITH_CPLEX=$(usex cplex)
		-DWITH_CSPARSE=$(usex csparse)
		-DWITH_BUILD_CSPARSE=$(usex system-csparse OFF ON)
		-DWITH_DAQP=$(usex daqp)
		-DWITH_BUILD_DAQP=$(usex daqp)
		-DWITH_DSDP=$(usex dsdp)
		-DWITH_BUILD_DSDP=$(usex dsdp)
		-DWITH_EIGEN3=$(usex eigen3)
		-DWITH_BUILD_EIGEN3=$(usex system-eigen3 OFF ON)
		-DWITH_FATROP=$(usex fatrop)
		-DWITH_BUILD_FATROP=$(usex fatrop)
		-DWITH_HIGHS=$(usex highs)
		-DWITH_BUILD_HIGHS=$(usex highs)
		-DWITH_HPIPM=$(usex hpipm)
		-DWITH_BUILD_HPIPM=$(usex hpipm)
		-DWITH_HSL=$(usex hsl)
		-DWITH_BUILD_HSL=$(usex hsl)
		-DWITH_GUROBI=$(usex gurobi)
		-DWITH_IPOPT=$(usex ipopt)
		-DWITH_BUILD_IPOPT=$(usex system-ipopt OFF ON)
		-DWITH_KNITRO=$(usex knitro)
		-DWITH_LAPACK=$(usex lapack)
		-DWITH_BUILD_LAPACK=$(usex system-lapack OFF ON)
		-DWITH_BUILD_METIS=$(usex system-metis OFF ON)
		-DWITH_MUMPS=$(usex mumps)
		-DWITH_BUILD_MUMPS=$(usex system-mumps OFF ON)
		-DWITH_OSQP=$(usex osqp)
		-DWITH_BUILD_OSQP=$(usex osqp)
		-DWITH_PROXQP=$(usex proxqp)
		-DWITH_BUILD_PROXQP=$(usex proxqp)
		-DWITH_QPOASES=$(usex qpoases)
		-DWITH_SIMDE=$(usex simde)
		-DWITH_BUILD_SIMDE=$(usex simde)
		-DWITH_SLEQP=$(usex sleqp)
		-DWITH_BUILD_SLEQP=$(usex sleqp)
		-DWITH_SNOPT=$(usex snopt)
		-DWITH_SPRAL=$(usex spral)
		-DWITH_BUILD_SPRAL=$(usex spral)
		-DWITH_SUNDIALS=$(usex sundials)
		-DWITH_BUILD_SUNDIALS=$(usex system-sundials OFF ON)
		-DWITH_SUPERSCS=$(usex superscs)
		-DWITH_BUILD_SUPERSCS=$(usex superscs)
		-DWITH_TRLIB=$(usex trlib)
		-DWITH_BUILD_TRLIB=$(usex trlib)
		-DWITH_TINYXML=$(usex xml)
		-DWITH_WORHP=$(usex worhp)
		-DWITH_BUILD_TINYXML=$(usex system-xml OFF ON)
	)

	cmake_src_configure
}

src_install() {
    cmake_src_install

    use python && python_optimize
}

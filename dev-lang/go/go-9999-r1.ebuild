# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/go/go-9999.ebuild,v 1.19 2014/08/15 00:33:15 williamh Exp $

EAPI=5

export CTARGET=${CTARGET:-${CHOST}}

inherit eutils git-2

EGIT_REPO_URI="https://go.googlesource.com/go"
KEYWORDS=""

DESCRIPTION="A concurrent garbage collected and typesafe programming language"
HOMEPAGE="http://www.golang.org"

LICENSE="BSD"
SLOT="0"

targets="linux_arm linux_amd64 linux_x64 linux_x86"

IUSE_GO_TARGETS="$(printf ' go_targets_%s' ${targets})"
IUSE="${IUSE_GO_TARGETS}"
REQUIRED_USE="|| ( ${IUSE_GO_TARGETS} )"

DEPEND=">=dev-lang/go-bootstrap-1.4.1"
RDEPEND=""

# The tools in /usr/lib/go should not cause the multilib-strict check to fail.
#QA_MULTILIB_PATHS="usr/lib/go/pkg/tool/.*/.*"

# The go language uses *.a files which are _NOT_ libraries and should not be
# stripped.
STRIP_MASK="/usr/lib/go/pkg/linux*/*.a /usr/lib/go/pkg/freebsd*/*.a"


if [[ ${PV} != 9999 ]]; then
	S="${WORKDIR}"/go
fi

src_prepare()
{
	if [[ ${PV} != 9999 ]]; then
		epatch "${FILESDIR}"/${P}-no-Werror.patch
	fi
	epatch_user
}

src_compile()
{
	export GOROOT_BOOTSTRAP="${EPREFIX}"/usr/lib/go1.4
	export GOROOT_FINAL="${EPREFIX}"/usr/lib/go
	export GOROOT="$(pwd)"
	export GOBIN="${GOROOT}/bin"
	tc-export CC

	cd src
	# TODO: don't be so stupid and build everything manually
	# so the host stuff is not rebuilt from scratch for each target
	for t in ${IUSE_GO_TARGETS}; do
		if use "${t}"; then
			t="${t#go_targets_}"
			export GOOS="${t%_*}"
			arch="${t#*_}"
			case ${arch} in
				amd64)
					export GOARCH=amd64
					;;
				arm)
					export GOARCH=arm
					export GOARM=5
					;;
				x64)
					export GOARCH=amd64p32
					;;
				x86)
					export GOARCH=386
					;;
			esac
			./make.bash --no-clean || die "build failed"
		fi
	done
}

src_test()
{
	cd src
	PATH="${GOBIN}:${PATH}" \
		./run.bash --no-rebuild --banner || die "tests failed"
}

src_install()
{
	dobin $(find bin -type f -maxdepth 1)
	dodoc AUTHORS CONTRIBUTORS PATENTS README.md

	dodir /usr/lib/go
	insinto /usr/lib/go

	# There is a known issue which requires the source tree to be installed [1].
	# Once this is fixed, we can consider using the doc use flag to control
	# installing the doc and src directories.
	# [1] http://code.google.com/p/go/issues/detail?id=2775
	doins -r doc lib pkg src
	fperms -R +x /usr/lib/go/pkg/tool
}

pkg_postinst()
{
	# If the go tool sees a package file timestamped older than a dependancy it
	# will rebuild that file.  So, in order to stop go from rebuilding lots of
	# packages for every build we need to fix the timestamps.  The compiler and
	# linker are also checked - so we need to fix them too.
	ebegin "fixing timestamps to avoid unnecessary rebuilds"
	tref="usr/lib/go/pkg/*/runtime.a"
	find "${EROOT}"usr/lib/go -type f \
		-exec touch -r "${EROOT}"${tref} {} \;
	eend $?

	if [[ ${PV} != 9999 && -n ${REPLACING_VERSIONS} &&
		${REPLACING_VERSIONS} != ${PV} ]]; then
		elog "Release notes are located at http://golang.org/doc/go${PV}"
	fi
}

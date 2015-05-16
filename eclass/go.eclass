# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: go.eclass
# @AUTHOR:
# Emery Hemingway <emery@vfemail.net>
# @BLURB: Eclass for Go packages.
# @DESCRIPTION:
# Merges Go packages to /usr/lib/go/gentoo.
#
# @TODO:
# Installing pure Go is great, but I need to export functions
# to build and install objects and source that are included
# in the form of SWIG wrappers and the like.
#
# No optimization flags are passed to the Go compliers yet.

# Unknown EAPI requirements.

DEPEND="dev-lang/go"

# @ECLASS-VARIABLE: EGO_PACKAGE_PATH
# @DEFAULT_UNSET
# @DESCRIPTION:
# The path used to resolve import statments,
# see http://golang.org/doc/code.html#PackagePaths

# @ECLASS-VARIABLE: EGO_TAGS
# @DEFAULT_UNSET
# @DESCRIPTION:
# A list of build tags to consider satisfied during the build.

EXPORT_FUNCTIONS src_compile src_test src_install

DEPEND="dev-lang/go"

ego_build() {
	for x in * ; do
		if [ -d "${x}" -a "${x}" != "_example" ] ; then
			pushd "${x}"
			ego_build
			popd
		fi
	done

	gofiles=(*.go)
	if [ -e "${gofiles[0]}" ] ; then
		# go install is run rather than go build to avoid compiling libraries twice
		GOPATH="${WORKDIR}/gopath:/usr/lib/go/gentoo" \
			/usr/bin/go build ${gobuildargs[@]} \
			|| die "go build failed"
	fi
}

ego_install() {
	for x in * ; do
		if [ -d "${x}" -a "${x}" != "_example" ] ; then
			pushd "${x}"
			ego_build
			popd
		fi
	done

	gofiles=(*.go)
	if [ -e "${gofiles[0]}" ] ; then
		GOPATH="${WORKDIR}/gopath:/usr/lib/go/gentoo" \
			/usr/bin/go install ${gobuildargs[@]} \
			|| die "go install failed"
	fi
}

go_src_test() {
	ego_test
}

go_src_compile() {
	local GOPATH="${WORKDIR}/gopath"

	local gobuildargs=( -work -x )
	if [ -n "${EGO_TAGS}" ]; then
		gobuildargs=( ${gobuildargs[@]} -tags ${EGO_TAGS[@]} )
	fi

	if [ -n "${EGO_PACKAGE_PATH}" ] ; then
		EGO_S="${GOPATH}/src/${EGO_PACKAGE_PATH}"
		ebegin "Moving source to ${EGO_S}"
		mkdir -pv "${EGO_S%/*}"
		mv "${S}" "${EGO_S}"
		ln -s "${EGO_S}" "${S}"
		eend ${?}

		cd "${EGO_S}"
	fi
	ego_build
}

ego_test() {
	for x in * ; do
		if [ -d "${x}" ] ; then
			pushd "${x}"
			ego_test
			popd
		fi
	done

	gotestfiles=(*_test.go)
	if [ -e "${gotestfiles[0]}" ] ; then
		GOPATH="${WORKDIR}/gopath:/usr/lib/go/gentoo" \
			/usr/bin/go test -v || die "go test failed"
	fi
}

go_src_install() {
	ego_install
	local GOPATH="${WORKDIR}/gopath"

	if [ -e "${GOPATH}/bin" ] ; then
		dodir /usr/lib/go/gentoo/bin
		cp -pR "${GOPATH}/bin" "${ED}/usr/lib/go/gentoo" || die 'failed to install $GOPATH/bin'
	fi

	if [ -e "${GOPATH}/pkg" ] ; then
		dodir /usr/lib/go/gentoo/pkg
		cp -pR "${GOPATH}/pkg" "${ED}/usr/lib/go/gentoo" || die 'failed to install $GOPATH/pkg'
	fi

	# If ${EGO_PACKAGE_PATH} isn't set, then a standalone binary is probably
	# being built, and we don't need the source code for that anymore.
	if [ -n "${EGO_PACKAGE_PATH}" ] ; then
		local dest="/usr/lib/go/gentoo/src/${EGO_PACKAGE_PATH}"
		dodir "${dest}"
		cp -pRL "${GOPATH}/src/${EGO_PACKAGE_PATH}/"* "${ED}/${dest}" \
			|| die 'failed to install $GOPATH/src'
		# wildcard was to avoid installing .git/
	fi
}

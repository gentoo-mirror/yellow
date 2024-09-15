# SPDX-License-Identifier: GPL-2.0
# Copyright 2017-2024 Gentoo Authors
# Copyright 2024 Jason André Charles Gantner
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

MY_PV="${PV//_rc/-rc}"

inherit bash-completion-r1 cargo desktop

DESCRIPTION="GPU-accelerated terminal emulator"
HOMEPAGE="https://alacritty.org"

if [ ${PV} == "9999" ] ; then
	inherit git-r3
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}"
	KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"
fi

S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD-2 BSD Boost-1.0 CC0-1.0 ISC MIT MPL-2.0
	Unicode-DFS-2016
"

SLOT="0"

IUSE="+wayland X sixel doc"

REQUIRED_USE="|| ( wayland X )"

DEPEND="
	media-libs/fontconfig:=
	media-libs/freetype:2
	x11-libs/libxkbcommon
	X? ( x11-libs/libxcb:= )
"

RDEPEND="${DEPEND}
	media-libs/mesa[X?,wayland?]
	sys-libs/zlib
	sys-libs/ncurses:0
	wayland? ( dev-libs/wayland )
	X? (
		x11-libs/libXcursor
		x11-libs/libXi
		x11-libs/libXrandr
	)
"

BDEPEND="
	dev-build/cmake
	>=virtual/rust-1.70.0
	app-text/scdoc
"

QA_FLAGS_IGNORED="usr/bin/alacritty"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		if use sixel;then
			UPSTREAM=ayosec
			EGIT_BRANCH=graphics
		else
			UPSTREAM="${PN}"
		fi
		EGIT_REPO_URI="https://github.com/${UPSTREAM}/alacritty"
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_configure() {
	local myfeatures=(
		$(usex X x11 '')
		$(usev wayland)
	)
	cargo_src_configure --no-default-features
}

src_compile() {
	scdoc < ./extra/man/alacritty.1.scd > ./alacritty.1 || die
	scdoc < ./extra/man/alacritty.5.scd > ./alacritty.5 || die
	scdoc < ./extra/man/alacritty-msg.1.scd > ./alacritty-msg.1 || die
	scdoc < ./extra/man/alacritty-bindings.5.scd > ./alacritty-bindings.5 || die

	cd alacritty || die
	cargo_src_compile
}

src_install() {
	cargo_src_install --path alacritty

	doman alacritty.1 alacritty.5 alacritty-msg.1 alacritty-bindings.5

	newbashcomp extra/completions/alacritty.bash alacritty

	insinto /usr/share/fish/vendor_completions.d/
	doins extra/completions/alacritty.fish

	insinto /usr/share/zsh/site-functions
	doins extra/completions/_alacritty

	domenu extra/linux/Alacritty.desktop
	newicon extra/logo/compat/alacritty-term.svg Alacritty.svg

	insinto /usr/share/metainfo
	doins extra/linux/org.alacritty.Alacritty.appdata.xml

	insinto /usr/share/alacritty/scripts
	doins -r scripts/*

	if use doc; then
		local DOCS=(
			CHANGELOG.md
			README.md
		)
		einstalldocs
	fi
}

src_test() {
	cd alacritty || die
	cargo_src_test
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		einfo "Configuration files for ${CATEGORY}/${PN}"
		einfo "in \$HOME often need to be updated after a version change"
		einfo ""
		einfo "For information on how to configure ${PN}, see the manpage:"
		einfo "man 5 ${PN}"
	fi
}
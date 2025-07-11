# SPDX-License-Identifier: GPL-2.0
# Copyright 2017-2025 Gentoo Authors
# Copyright 2024-2025 Jason André Charles Gantner
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler2@2.0.0
	ahash@0.8.11
	aho-corasick@1.1.3
	android-activity@0.6.0
	android-properties@0.2.2
	anstream@0.6.18
	anstyle-parse@0.2.6
	anstyle-query@1.1.2
	anstyle-wincon@3.0.6
	anstyle@1.0.10
	arrayref@0.3.9
	arrayvec@0.7.6
	as-raw-xcb-connection@1.0.1
	atomic-waker@1.1.2
	autocfg@1.4.0
	base64@0.22.1
	bitflags@1.3.2
	bitflags@2.6.0
	block2@0.5.1
	block@0.1.6
	bumpalo@3.16.0
	bytemuck@1.20.0
	bytes@1.9.0
	calloop-wayland-source@0.3.0
	calloop@0.13.0
	cc@1.2.4
	cesu8@1.1.0
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	cgl@0.3.2
	clap@4.5.23
	clap_builder@4.5.23
	clap_complete@4.5.38
	clap_derive@4.5.18
	clap_lex@0.7.4
	clipboard-win@3.1.1
	cocoa-foundation@0.1.2
	cocoa@0.25.0
	colorchoice@1.0.3
	combine@4.6.7
	concurrent-queue@2.5.0
	copypasta@0.10.1
	core-foundation-sys@0.8.7
	core-foundation@0.9.4
	core-graphics-types@0.1.3
	core-graphics@0.23.2
	core-text@20.1.0
	crc32fast@1.4.2
	crossbeam-channel@0.5.13
	crossbeam-utils@0.8.20
	crossfont@0.8.0
	cstr@0.2.12
	cursor-icon@1.1.0
	dirs-sys@0.4.1
	dirs@5.0.1
	dispatch@0.2.0
	dlib@0.5.2
	downcast-rs@1.2.1
	dpi@0.1.1
	dwrote@0.11.2
	embed-resource@2.5.1
	equivalent@1.0.1
	errno@0.3.10
	fastrand@2.3.0
	fdeflate@0.3.7
	filetime@0.2.25
	flate2@1.0.35
	foreign-types-macros@0.2.3
	foreign-types-shared@0.3.1
	foreign-types@0.5.0
	freetype-rs@0.36.0
	freetype-sys@0.20.1
	fsevent-sys@4.1.0
	futures-io@0.3.31
	gethostname@0.4.3
	getrandom@0.2.15
	gl_generator@0.14.0
	glutin@0.32.2
	glutin_egl_sys@0.7.1
	glutin_glx_sys@0.6.1
	glutin_wgl_sys@0.6.1
	hashbrown@0.15.2
	heck@0.5.0
	hermit-abi@0.4.0
	home@0.5.9
	indexmap@2.7.0
	inotify-sys@0.1.5
	inotify@0.9.6
	is_terminal_polyfill@1.70.1
	itoa@1.0.14
	jni-sys@0.3.0
	jni@0.21.1
	jobserver@0.1.32
	js-sys@0.3.76
	khronos_api@3.1.0
	kqueue-sys@1.0.4
	kqueue@1.0.8
	lazy-bytes-cast@5.0.1
	lazy_static@1.5.0
	libc@0.2.168
	libloading@0.8.6
	libredox@0.1.3
	linux-raw-sys@0.4.14
	lock_api@0.4.12
	log@0.4.22
	malloc_buf@0.0.6
	memchr@2.7.4
	memmap2@0.9.5
	memoffset@0.9.0
	miniz_oxide@0.8.0
	mio@0.8.11
	miow@0.6.0
	ndk-context@0.1.1
	ndk-sys@0.6.0+11769913
	ndk@0.9.0
	notify@6.1.1
	num_enum@0.7.3
	num_enum_derive@0.7.3
	objc-foundation@0.1.1
	objc-sys@0.3.5
	objc2-app-kit@0.2.2
	objc2-cloud-kit@0.2.2
	objc2-contacts@0.2.2
	objc2-core-data@0.2.2
	objc2-core-image@0.2.2
	objc2-core-location@0.2.2
	objc2-encode@4.0.3
	objc2-foundation@0.2.2
	objc2-link-presentation@0.2.2
	objc2-metal@0.2.2
	objc2-quartz-core@0.2.2
	objc2-symbols@0.2.2
	objc2-ui-kit@0.2.2
	objc2-uniform-type-identifiers@0.2.2
	objc2-user-notifications@0.2.2
	objc2@0.5.2
	objc@0.2.7
	objc_id@0.1.1
	once_cell@1.20.2
	option-ext@0.2.0
	orbclient@0.3.48
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	percent-encoding@2.3.1
	pin-project-internal@1.1.7
	pin-project-lite@0.2.15
	pin-project@1.1.7
	piper@0.2.4
	pkg-config@0.3.31
	png@0.17.15
	polling@3.7.4
	proc-macro-crate@3.2.0
	proc-macro2@1.0.92
	quick-xml@0.36.2
	quote@1.0.37
	raw-window-handle@0.6.2
	redox_syscall@0.4.1
	redox_syscall@0.5.8
	redox_users@0.4.6
	regex-automata@0.4.9
	regex-syntax@0.8.5
	rustc_version@0.4.1
	rustix-openpty@0.1.1
	rustix@0.38.42
	ryu@1.0.18
	same-file@1.0.6
	scoped-tls@1.0.1
	scopeguard@1.2.0
	sctk-adwaita@0.10.1
	semver@1.0.24
	serde@1.0.216
	serde_derive@1.0.216
	serde_json@1.0.133
	serde_spanned@0.6.8
	serde_yaml@0.9.34+deprecated
	shlex@1.3.0
	signal-hook-registry@1.4.2
	signal-hook@0.3.17
	simd-adler32@0.3.7
	slab@0.4.9
	smallvec@1.13.2
	smithay-client-toolkit@0.19.2
	smithay-clipboard@0.7.2
	smol_str@0.2.2
	strict-num@0.1.1
	strsim@0.11.1
	syn@2.0.90
	tempfile@3.14.0
	thiserror-impl@1.0.69
	thiserror@1.0.69
	tiny-skia-path@0.11.4
	tiny-skia@0.11.4
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.22.22
	tracing-core@0.1.33
	tracing@0.1.41
	unicode-ident@1.0.14
	unicode-segmentation@1.12.0
	unicode-width@0.1.14
	unsafe-libyaml@0.2.11
	utf8parse@0.2.2
	version_check@0.9.5
	vswhom-sys@0.1.2
	vswhom@0.1.0
	vte-graphics@0.13.1
	vte_generate_state_changes@0.1.2
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.99
	wasm-bindgen-futures@0.4.49
	wasm-bindgen-macro-support@0.2.99
	wasm-bindgen-macro@0.2.99
	wasm-bindgen-shared@0.2.99
	wasm-bindgen@0.2.99
	wayland-backend@0.3.7
	wayland-client@0.31.7
	wayland-csd-frame@0.3.0
	wayland-cursor@0.31.7
	wayland-protocols-plasma@0.3.5
	wayland-protocols-wlr@0.3.5
	wayland-protocols@0.32.5
	wayland-scanner@0.31.5
	wayland-sys@0.31.5
	web-sys@0.3.76
	web-time@1.1.0
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.42.2
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	winit@0.30.9
	winnow@0.6.20
	winreg@0.52.0
	wio@0.2.2
	x11-clipboard@0.9.3
	x11-dl@2.21.0
	x11rb-protocol@0.13.1
	x11rb@0.13.1
	xcursor@0.3.8
	xdg@2.5.2
	xkbcommon-dl@0.4.2
	xkeysym@0.2.1
	xml-rs@0.8.24
	yeslogic-fontconfig-sys@5.0.0
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
"

RUST_MIN_VERSION="1.74.0"

inherit bash-completion-r1 cargo desktop

DESCRIPTION="GPU-accelerated terminal emulator with sixel support"
HOMEPAGE="https://alacritty.org"

if [ ${PV} == "9999" ] ; then
	inherit git-r3
else
	SRC_URI="https://github.com/ayosec/alacritty/archive/refs/tags/v${PV}-graphics.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}"
	KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv"
fi

S="${WORKDIR}/alacritty-${PV}-graphics"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD-2 BSD Boost-1.0 CC0-1.0 ISC MIT MPL-2.0
	Unicode-DFS-2016
"

SLOT="0"

IUSE="+wayland X doc"
REQUIRED_USE="|| ( wayland X )"

RESTRICT="mirror"

DEPEND="
	media-libs/fontconfig:=
	media-libs/freetype:2
	x11-libs/libxkbcommon
	X? ( x11-libs/libxcb:= )
"

RDEPEND="${DEPEND}
	!x11-terms/alacritty
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
	app-text/scdoc
	${RUST_DEPEND}
"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		EGIT_BRANCH=graphics
		EGIT_REPO_URI="https://github.com/ayosec/alacritty"
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

	doman alacritty.{1,5} alacritty-msg.1 alacritty-bindings.5

	newbashcomp extra/completions/alacritty.bash alacritty

	insinto /usr/share/fish/vendor_completions.d/
	doins extra/completions/alacritty.fish

	insinto /usr/share/zsh/site-functions
	doins extra/completions/_alacritty

	domenu extra/linux/Alacritty.desktop
	newicon -s scalable extra/logo/compat/alacritty-term+scanlines.svg Alacritty.svg
	newicon -s 512 extra/logo/compat/alacritty-term+scanlines.png Alacritty.png
	newicon -s 64 extra/logo/compat/alacritty-term.png Alacritty.png

	insinto /usr/share/metainfo
	doins extra/linux/org.alacritty.Alacritty.appdata.xml

	insinto /usr/share/alacritty
	doins -r scripts

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
		einfo "man 5 alacritty"
	fi
}

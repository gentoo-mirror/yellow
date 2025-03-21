# SPDX-License-Identifier: GPL-2.0 OR ISC
# Copyright 2024 Jason André Charles Gantner
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=(python3_{11..13} python3_13t)
inherit distutils-r1

DESCRIPTION="Pytest plugin to randomly order tests and control random.seed"
HOMEPAGE="https://github.com/pytest-dev/pytest-randomly/"
SRC_URI="https://github.com/pytest-dev/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"

DEPEND="
	dev-python/importlib-metadata
	${PYTHON_DEPS}
	dev-python/pytest
	test? (
		dev-python/faker
		dev-python/pytest-xdist
	)
	"
RDEPEND="${DEPEND}"
RESTRICT="test" # tests are buggy
#distutils_enable_tests pytest

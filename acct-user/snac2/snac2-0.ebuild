# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="A user for net-misc/snac2"
ACCT_USER_ID=901
ACCT_USER_GROUPS=( snac2 )
ACCT_USER_HOME="/var/lib/snac2"
ACCT_USER_SHELL=/bin/bash

acct-user_add_deps

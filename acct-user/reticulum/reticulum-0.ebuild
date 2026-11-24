# Copyright 2026 ReK2 - Chris F.N. <rek2@hispagatos.org>
# https://rek2.hispagatos.org
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit acct-user

DESCRIPTION="Reticulum Network Stack daemon user"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( reticulum )
ACCT_USER_HOME=/var/lib/reticulum

acct-user_add_deps

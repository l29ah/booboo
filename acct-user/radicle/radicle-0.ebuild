# Copyright 2024 Your Mom
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for the system-wide net-p2p/radicle-node server"
ACCT_USER_ID=801
ACCT_USER_HOME=/var/lib/radicle
ACCT_USER_HOME_PERMS=0770
ACCT_USER_GROUPS=( radicle )

acct-user_add_deps

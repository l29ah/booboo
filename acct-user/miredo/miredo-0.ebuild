# Copyright 2019 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

## provides everything
inherit acct-user

RDEPEND="
	acct-group/${PN}
"

declare -g -i ACCT_USER_ID=-1
declare -g -- ACCT_USER_HOME="/var/empty"
declare -g -a ACCT_USER_GROUPS=( "${PN}" )

# This must be called if ACCT_USER_GROUPS are set.
acct-user_add_deps

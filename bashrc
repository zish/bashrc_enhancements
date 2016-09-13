# Invocation for bashrc_enhancements files.
#
# Author: Jeremy Melanson
#
# Source-code, documentation and revision Git repository: https://github.com/zish/bashrc_enhancements
#
# $ git clone https://github.com/zish/bashrc_enhancements
#
#
# This file is part of bashrc_enhancements.
#
#    bashrc_enhancements is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    bashrc_enhancements is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with bashrc_enhancements.  If not, see <http://www.gnu.org/licenses/>.

export ENHANCEMENTS_ROOT="${HOME}/.bashrc_enhancements"
export ENHANCEMENTS_ENABLED=("addpath" "ssh" "sudo" "tar")

for F in ${ENHANCEMENTS_ENABLED[@]}; do
	[ -e ${ENHANCEMENTS_ROOT}/files/${F} ] && . ${ENHANCEMENTS_ROOT}/files/${F}
done

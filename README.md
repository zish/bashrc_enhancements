# bashrc_enhancements
Some useful functions, shortcuts, and enhancements to add to your .bashrc (or .bash_profile).

Current functions are called *addpath*, *sudo*, and *tar*.
*sudo* and *tar* are "intercept" functions, which are used to add functionality to existing commands of the same name.

## addpath - Keep your PATH clean.

This function will (intelligently) add a directory to your PATH, with conditions:
1. Item will only be added if it exists and is a directory (Handy when you want to use the same .bashrc across dissimilar systems).
2. If the item already exists in PATH, its location in PATH is changed or removed (Useful if required to reference the same .bashrc from nested bash shells).

__Available options:__
*The following arguments are optional:*
* first  - Add the entry before all other entries in PATH.
* remove - Remove any references to the entry from PATH.
* _If no options are specified, the entry is appended to the end of PATH._


### Syntax examples:
*SCENARIO:*
* The original value of PATH is "/bin:/usr/bin:/home/zish/bar" ("/home/zish" being the HOME directory).
```
addpath /usr/bin first
* _Value of PATH becomes "/usr/bin:/bin:/home/zish/bar"._
addpath /usr/local/sbin
* _Value of PATH becomes "/usr/bin:/bin:/home/zish/bar:/usr/local/sbin"._
addpath /usr/local/sbin
* _Value of PATH _remains_ "/usr/bin:/bin:/home/zish/bar:/usr/local/sbin"._
addpath ${HOME}/bar remove
* _Value of PATH becomes "/usr/bin:/bin:/usr/local/sbin"._
addpath ${HOME}/foo first
* _If "${HOME}/foo" exists, PATH becomes "/usr/bin:/bin:/usr/local/sbin:/home/zish/foo"._
* _If "${HOME}/foo" does not exist, PATH remains "/usr/bin:/bin:/usr/local/sbin"._
```

## sudo - SUDO interception command. This allows you to use available aliases with the sudo command.

This will intercept the "sudo" command. If the command executed by sudo matches a defined alias, it will execute the contents of the alias instead.

### Examples:

_In .bashrc:_

alias tlog='tail -100 /var/log/syslog'

Normally this alias would need to be defined in root's .bashrc file to be used. Even still, there may be security controls restricting what may be available from a sudo command, or tools that manage the integrity of root's .bashrc entirely. Thus running "sudo tlog" would fail with a "command not found" error.

The sudo intercept function instead will rewrite the sudo command appropriately. The command "sudo tlog" gets invoked as "sudo tail -100 /var/log/syslog".


## tar - Tar interception command. Suppresses annoying "SCHILY" messages when extracting a TAR archive originating from a MacOS system.

This is primarily intended for Linux systems, but can be used for any system with GNU/Tar.
This cuts down the amount of output echoed to your terminal or output log,
and is expecially useful when extracting a tar file from MacOS with a lot of files.


## Installation:

*Simple method:*

Copy the contents of this repo to ${HOME}/.bashrc_enhancements
Add the text ". ${HOME}/.bashrc_enhancements/bashrc" on a blank line in your .bashrc (or .bash_profile)
near the beginning of the file.


*Portable method:*

The simple method requires that ${HOME}/.bashrc_enhancements be made available on any system that you
wish to use it on. As an alternative, the contents of any file under ${HOME}/.bashrc_enhancements/files
can be added directly to your .bashrc file.


## License:

_bashrc_enhancements_ is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

_bashrc_enhancements_ is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

A copy of the GNU Affero General Public License should be provided along
with _bashrc_enhancements_. If not, see <http://www.gnu.org/licenses/>.


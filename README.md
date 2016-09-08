# bashrc_enhancements
Some useful functions, shortcuts, and enhancements to add to your .bashrc (or .bash_profile).

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
* Value of PATH becomes "/usr/bin:/bin:/home/zish/bar".
addpath /usr/local/sbin
* Value of PATH becomes "/usr/bin:/bin:/home/zish/bar:/usr/local/sbin".
addpath /usr/local/sbin
* Value of PATH _remains_ "/usr/bin:/bin:/home/zish/bar:/usr/local/sbin".
addpath ${HOME}/bar remove
* Value of PATH becomes "/usr/bin:/bin:/usr/local/sbin".
addpath ${HOME}/foo first
* If "${HOME}/foo" exists, PATH becomes "/usr/bin:/bin:/usr/local/sbin:/home/zish/foo".
* If "${HOME}/foo" does not exist, PATH remains "/usr/bin:/bin:/usr/local/sbin".
```

### Installation:

*Simple method:*
Copy the contents of this repo to ${HOME}/.bashrc_enhancements
Add the text ". ${HOME}/.bashrc_enhancements/bashrc" on a blank line in your .bashrc (or .bash_profile)
near the beginning of the file.

*Portable method:*
The simple method requires that ${HOME}/.bashrc_enhancements be made available on any system that you
wish to use it on. As an alternative, the contents of any file under ${HOME}/.bashrc_enhancements/files
can be added directly to your .bashrc file.


### License:

bashrc_enhancements is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

bashrc_enhancements is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

A copy of the GNU Affero General Public License should be provided along
with bashrc_enhancements. If not, see <http://www.gnu.org/licenses/>.


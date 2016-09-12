# SSH Intercept function README

This was written originally as a mechanism to bring my locally-defined PS1 prompt and  bash aliases with me, so I didn't need to copy them everywhere. It has since had a lot more functionality added to it.

### Features:
* Define PS1 locally, and have it appear in remote SSH sessions.
* Use locally-defined aliases in remote SSH sessions.
* Use locally-defined sunroutines in remote SSH sessions (must be explicity defined).
* Automaticallly log output from SSH sessions.
* _Ability to override these options for hosts._
..* _Overrides are specified as a comment at the end of a 'Host' line that matches the host, in your ~/.ssh/config file._

## Configuration Environment variables for ssh intercept function.
*Defining these variables in your .bashrc will override the default.*

### SSHI_ADD_SUBS - Specifies what locally-defined functions to include in a remote SSH session.
_Default:_
* SSHI_ADD_SUBS="sudo ssh sshiconf tar addpath"

### SSHI_RPS1 - Remote PS1 Prompt.
The default prepends the local PS1 with a red, bold SSH between parentheses., which identifies at a glance that the terminal window is an SSH session.
_Default:_
* SSHI_RPS1 = '\[\033[1;1m\](\[\033[1;31m\]SSH\[\033[0;1m\])\[\033[0;37m\]${PS1}'
To remotely use your local PS1 unmodified, use the following:
* SSHI_RPS1=${PS1}

### SSHI_SSH_UC - SSH Local user config file
_Default:_
* SSHI_SSH_UC=~/.ssh/config

### SSHI_SSH_MC - SSH system-wide (main) config file
_Default_:
* UNDEFINED

_Omitting SSHI_MC (main cnf) avoids the need to override "host *" in the user config, so you will probably not need to use it._

### SSHI_LOG_BY_DEF - Enable local logging of SSH sessions by default.
_Default:_
* SSHI_LOG_BY_DEF=1

Setting this to 0 or undefined will cause the function to skip local logging, unless the LOG option is matched to a Host in the ssh config file(s).

### SSHI_LOG_LOC - SSH local session log destination directory.
_Default:_
SSHI_LOG_LOC=~/ssh_logs

*The directory specified must exist for logging to occur.*

_Log file names in this directory will be formatted as 'HOST-YYYY-MM-DD_HH-MM-SS.log'._


## Defining SSH Host configuration options in the SSH config files.

_NOTE:_ To make use of the majority of features in the SSH intercept function, a remote SSH Host **_Must_** have a matching Host entry in the SSH config. *Session logging does not require a matching Host entry, if SSHI_LOG_BY_DEF is set.

### Examples:
*SSH intercept function only needs a "Host" line. Additional SSH Host options are ignored by the function itself.*

Host 10.20.30.40 www.cefncefh.com
* SSH sessions to IP address 10.20.30.40 and Hostname www.cefncefh.com will include local PS1, available functions, aliases. Sessions will be logged if SSHI_LOG_BY_DEF is set.

Host internal-*.jakakwpqs.net 192.168.*.*
* This illustrates that wildcards are supported.

Host argle.bargle.systemhalted.com #PROMPTONLY
* Only use the PS1 prompt on the remote host. Local aliases and functions will not be included.

Host foo.csopqcnaleicn.lan #NOLOG,PROMPTONLY
* Only use the PS1 prompt on the remote host. Local aliases and functions will not be included.
* Disable logging if SSHI_LOG_BY_DEF is set.

Host bar.csopqcnaleicn.lan # PROMPTONLY, LOG
_This illustrates multiple options can be used per host entry._
* Only use the PS1 prompt on the remote host. Local aliases and functions will not be included.
* Enable logging if SSHI_LOG_BY_DEF is NOT set.

Host firewall.internal-network.lan #NOPROMPT
Host *.internal-network.lan
* Disable use of local PS1, available functions, aliases for host firewall.internal-network.lan.
* ...but enable for all other hosts matching *.internal-network.lan.


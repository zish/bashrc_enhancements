# SSH Intercept function README

This was written originally as a mechanism to bring my locally\-defined PS1 prompt and  bash aliases with me, so I didn't need to copy them everywhere\. It has since had a lot more functionality added to it\.

### Features:
* Define PS1 locally, and have it appear in remote SSH sessions\.
* Use locally\-defined aliases in remote SSH sessions\.
* Use locally\-defined subroutines in remote SSH sessions \(must be explicity defined\)\.
* Automaticallly log output from SSH sessions\.
* Arbitrarily add sections of your local bashrc\.
* _Ability to override these options for hosts\._
 * _Overrides are specified as a comment at the end of a 'Host' line that matches the host, in your ~/\.ssh/config file\._

## Configuration Environment variables for ssh intercept function\.
*Defining these variables in your \.bashrc will override the default\.*

### SSHI\_ADD\_SUBS \- Specifies what locally\-defined functions to include in a remote SSH session\.
_Default:_
* SSHI\_ADD\_SUBS="sudo ssh tar addpath"

### SSHI\_INC\_FILES \- Associative array containing files to include with the shipped SSH Session\.
_Default:_
SSHI\_INC\_FILES=\(\)

How to declare files:

SSHI\_INC\_FILES=\("$\{HOME\}/\.vimrc" '$\{HOME\}/\.vimrc'\)
*Note the use of single versus double\-quotes\. Using single will avoid expanding the value of the local variable\.*

### SSHI\_RPS1 \- Remote PS1 Prompt\.
The default prepends the local PS1 with a red, bold SSH between parentheses\., which identifies at a glance that the terminal window is an SSH session\.
_Default:_
* SSHI\_RPS1='\\\[\\033\[1;1m\\\]\(\\\[\\033\[1;31m\\\]SSH\\\[\\033\[0;1m\\\]\)\\\[\\033\[0;37m\\\]$\{PS1\}'
To remotely use your local PS1 unmodified, use the following:
* SSHI\_RPS1=$\{PS1\}

### SSHI\_SSH\_UC \- SSH Local user config file
_Default:_
* SSHI\_SSH\_UC=$\{HOME\}/\.ssh/config

### SSHI\_SSH\_MC \- SSH system\-wide \(main\) config file
_Default:_
* UNDEFINED

_Omitting SSHI_MC \(main cnf\) avoids the need to override "host \*" in the user config, so you will probably not need to use it\._

### SSHI\_LOG\_BY\_DEF \- Enable local logging of SSH sessions by default\.
_Default:_
* SSHI\_LOG\_BY\_DEF=1

Setting this to 0 or undefined will cause the function to skip local logging, unless the LOG option is matched to a Host in the ssh config file\(s\)\.

### SSHI\_LOG\_LOC \- SSH local session log destination directory\.
_Default:_
SSHI\_LOG\_LOC=~/ssh\_logs

*The directory specified must exist for logging to occur\.*

_Log file names in this directory will be formatted as 'HOST\-YYYY\-MM\-DD_HH\-MM\-SS\.log'\._

### SSHI\_CREATE\_LOG\_LOC \- Create the log destination dir, if it doesn't exist\.
_Default:_
SSHI\_CREATE\_LOG\_LOC=1

If SSHI\_CREATE\_LOG\_LOC is nonzero, the log destination directory (SSHI\_LOG\_LOC) will be created if it does not exist\.

### SSHI\_NO\_LOG\_REMOTE \- Don't try to generate logs, when using ssh function in a remote SSH session\.
_Default:_
SSHI\_NO\_LOG\_REMOTE=1

No logging functions will be attempted, if SSHI\_NO\_LOG\_REMOTE is nonzero\.

SSHI\_LOG\_COMPRESS \- Compress SSH logs\.
_Default:_
SSHI\_LOG\_COMPRESS=1

If SSHI\_LOG\_COMPRESS is nonzero, any SSH logs older than SSHI\_LOG\_CMP\_AGE will be compressed\.

SSHI\_LOG\_CMP\_BIN \- SSH log compression tool to use\.
_Default:_
SSHI\_LOG\_CMP\_BIN=gzip

*The compresion tool specified by SSHI\_LOG\_CMP\_BIN must support reading from STDIN, and writing to STDOUT\.*

SSHI\_LOG\_CMP\_OPTS \- Command-line options for compression tool (specified by SSHI\_LOG\_CMP\_BIN)\.
_Default:_
SSHI\_LOG\_CMP\_OPTS=-9

SSHI\_LOG\_CMP\_AGE \- Set the minimum SSH log age (in days) for compression eligibility\.
_Default:_
SSHI\_LOG\_CMP\_AGE=3

SSHI\_LOG\_MIN\_SIZE \- Minimum size (in bytes) an SSH log must be to avoid being deleted\.
_Default:_
SSHI\_LOG\_MIN\_SIZE=512

SSHI\_LOG\_FILT \- Optional filters to apply to log file output\.
_Default:_
*NOT SET*

This can be used for "fixing" log output, such as masking passwords or omitting other items from the log\.
*It does not affect the terminal output\.*

When performing SSH log directory maintenance, delete old logs (see SSHI\_LOG\_CMP\_AGE) that a smaller than SSHI\_LOG\_MIN\_SIZE\.

### SSHI\_SSH\_BIN \- Location of SSH command\.
_Default:_
SSHI\_SSH\_BIN=/usr/bin/ssh

If the SSH command is in a different location, it can be defined using this option\.


## Using \[SSH\_INCLUDE\] in your local bashrc\.
*This gives you the ability to include parts of your bashrc that otherwise wouldn't be easily transferrable\.*
If, for example, an external tool or function required commented lines or encoded data from your local bashrc, these could be made available to the user on the remote system\.
This can also be used to include local environment variables on the remote system, but their definitions must be in the local \.bashrc\.

To include lines from your bashrc, add "\# \[SSH\_INCLUDE\] XX" \(where XX is the number of lines\) to the line above the section you want\.


# (TODO):
## SSHI\_LOG\_FILT examples\.
SSHI\_LOG\_FILT=(
'^(enable\ password\ )(\S+)//\1\*\*\*\*\*\*\*\*'
'^(enable\ secret\ )(\S+)//\1\*\*\*\*\*\*\*\*'
'^passwd\ )(\S+)$//\1\*\*\*\*\*\*\*\*'
'^(username\ \S+ password\ )(\S+)//\1\*\*\*\*\*\*\*\*'
'^(username\ \S+ privilege\ \d+\ (secret|password)\ \d+\ )(\S+)//\1\*\*\*\*\*\*\*\*'

'^( ikev1 pre-shared-key )(\S+)//\1\*\*\*\*\*\*\*\*'
'^( ikev2 remote-authentication pre-shared-key )(\S+)//\1\*\*\*\*\*\*\*\*'
'^( ikev2 local-authentication pre-shared-key )(\S+)//\1\*\*\*\*\*\*\*\*'
'^( ospf message-digest-key \d+ \S+ )(\S+)//\1\*\*\*\*\*\*\*\*'
'^( key \d+ )(\S+)//\1\*\*\*\*\*\*\*\*'
)

### Examples:

Export the local EDITOR env variable on the remote system\.
```
# [SSH_INCLUDE] 1
export EDITOR='vim'
```

Use 'addpath' function on remote session to manage PATH\.
```
# [SSH_INCLUDE] 6
#-- Android Dev Stuff...
addpath ${HOME}/bin/android-studio/bin first
addpath ${HOME}/bin/android-studio/sdk/tools first
addpath ${HOME}/bin/android-studio/sdk/platform-tools first
addpath ${HOME}/bin/android-studio/sdk/build-tools/android-4.4.2 first
export ANDROID_HOME=${HOME}/bin/android-studio/sdk
```

*Lines marked by "\[SSH\_INCLUDE\] XX" are made available in the "\.bashrc\_pushed\-\[user\]\.funcs" file on the remote system\.*


## Overriding settings for hosts in the SSH config file\.

_NOTE:_ To make use of the majority of features in the SSH intercept function, a remote SSH Host **_Must_** have a matching Host entry in the SSH config\. *Session logging does not require a matching Host entry, if SSHI\_LOG\_BY\_DEF is set\.*

### SSH config host entry examples:
*SSH intercept function only needs a "Host" line\. Additional SSH Host options are ignored by the function itself\.*

*Host 10\.20\.30\.40 www\.cefncefh\.com*
* SSH sessions to IP address 10\.20\.30\.40 and Hostname www\.cefncefh\.com will include local PS1, available functions, aliases\. Sessions will be logged if SSHI\_LOG\_BY\_DEF is set\.

*Host internal\-\*\.jakakwpqs\.net 192\.168\.\*\.\**
* This illustrates that wildcards are supported\.

*Host argle\.bargle\.systemhalted\.com \#PROMPTONLY*
* Only use the PS1 prompt on the remote host\. Local aliases and functions will not be included\.

*Host foo\.csopqcnaleicn\.lan \#NOLOG,PROMPTONLY*
* Only use the PS1 prompt on the remote host\. Local aliases and functions will not be included\.
* Disable logging if SSHI\_LOG\_BY\_DEF is set\.

*Host bar\.csopqcnaleicn\.lan \# PROMPTONLY, LOG*
_This illustrates multiple options can be used per host entry\._
* Only use the PS1 prompt on the remote host\. Local aliases and functions will not be included\.
* Enable logging if SSHI\_LOG\_BY\_DEF is NOT set\.

*Host firewall\.internal\-network\.lan \#NOPROMPT*
*Host \*\.internal\-network\.lan*
* Disable use of local PS1, available functions, aliases for host firewall\.internal\-network\.lan\.
* \.\.\.but enable for all other hosts matching \*\.internal\-network\.lan\.

### Roadmap:
* Get remote file shipping to work.
 1. Just copy the files for now. Do not copy if the files are pre-existing\.

* Additional functionality in file shipping:
 2. Generate checksums of each file to be included\.
  * Store these checksums on the remote host\. use them to compare local and remote copies\.
  * Only copy each file, if it either does not exist, or the checksums don't match\.
 3. New option "SSHI\_INC\_FILES\_ARCHIVE\_LOC"
  * Used when including local files to the remote host\. This specifies a location to archive pre-existing remote files, before they are replaced by the local version\. This functionality is disabled if SSHI\_INC\_FILES\_ARCHIVE\_LOC is not set, or the matching host entry in the SSH config includes the "NO\_ARCHIVE\_REMOTE\_FILES" option\.
 4. Add per-host override for SSHI\_INC\_FILES, allowing the ability to specify different files per-host.

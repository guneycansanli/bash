#!/bin/bash

printf "\nThe script starts now."

printf "\nHello" "$USER"

printf "\nConnected Users:\n$(w)"

COLOUR="black"
VALUE="9"

printf "\nVariables: $COLOUR $VALUE"

printf "\nEND.\n"

# Multi line comment
: <<'END_COMMENT'
Syntax highlighting in vim
In order to activate syntax highlighting in vim, use the command
:syntax enable
or
:sy enable
or
:syn enable
You can add this setting to your .vimrc file to make it permanent.
Put UNIX commands in the new empty file, like you would enter them on the command line. As discussed in the previous chapter (see Section 1.3), commands can be shell functions, shell built-ins, UNIX commands and other scripts.
Give your script a sensible name that gives a hint about what the script does. Make sure that your script name does not conflict with existing commands. In order to ensure that no confusion can rise, script names often end in .sh; even so, there might be other scripts on your system with the same name as the one you chose. Check using which, whereis and other commands for finding information about programs and files:
which -a script_name
whereis script_name
locate script_name

chmod u+x script1.sh

A script can also explicitly be executed by a given shell, but generally we only do this if we want to obtain special behavior, such as checking if the script works with another shell or printing traces for debugging:
rbash script_name.sh
sh script_name.sh
bash -x script_name.sh



set -x			# activate debugging from here
w
set +x			# stop debugging from here


Short notation	Long notation	Result
set -f	set -o noglob	Disable file name generation using metacharacters (globbing).
set -v	set -o verbose	Prints shell input lines as they are read.
set -x	set -o xtrace	Print command traces before executing command.

Alternatively, these modes can be specified in the script itself, by adding the desired options to the first line shell declaration. Options can be combined, as is usually the case with UNIX commands:
#!/bin/bash -xv

Special bash variables:
$*	Expands to the positional parameters, starting from one. When the expansion occurs within double quotes, it expands to a single word with the value of each parameter separated by the first character of the IFS special variable.
$@	Expands to the positional parameters, starting from one. When the expansion occurs within double quotes, each parameter expands to a separate word.
$#	Expands to the number of positional parameters in decimal.
$?	Expands to the exit status of the most recently executed foreground pipeline.
$-	A hyphen expands to the current option flags as specified upon invocation, by the set built-in command, or those set by the shell itself (such as the -i).
$$	Expands to the process ID of the shell.
$!	Expands to the process ID of the most recently executed background (asynchronous) command.
$0	Expands to the name of the shell or shell script.
$_	The underscore variable is set at shell startup and contains the absolute file name of the shell or script being executed as passed in the argument list. Subsequently, it expands to the last argument to the previous command, after expansion. It is also set to the full pathname of each command executed and placed in the environment exported to that command. When checking mail, this parameter holds the name of the mail file.

END_COMMENT

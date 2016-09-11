if [ "$(whoami)" == "root" ] ; then
	ROOT="- \[\033[01;91m\]root!\[\033[00m\]"
else
	ROOT=""
fi

#SHORTEN PWD
_PS1 ()
{
	ret="$?"
	local PRE= NAME="$1" LENGTH="$2";
	[[ "$NAME" != "${NAME#$HOME/}" || -z "${NAME#$HOME}" ]] &&
	PRE+='~' NAME="${NAME#$HOME}" LENGTH=$[LENGTH-1];
	((${#NAME}>$LENGTH)) && NAME="/...${NAME:$[${#NAME}-LENGTH+4]}";
	echo "$PRE$NAME"
	return $ret #save the returnvalue
}

lighten () {
    echo "$(LANG=C printf '%.0f' "$(calc "$1 + (255 - $1) * $2")")"
}

hash="$(hostname -f | sha512sum | cut -d" " -f1)"
threshold="80"
fac="0.1"
pos="0"
r1="0" g1="0" b1="0" r2="0" g2="0" b2="0"
while [ \( \( $r1 -le $threshold -a $g1 -le $threshold -a $b1 -le $threshold \) \
    -o \( $r2 -le $threshold -a $g2 -le $threshold -a $b2 -le $threshold \) \) \
    -a $pos -lt 120 ] ; do
    r1="$((16#${hash:$pos:2}))"
    r2="$((16#${hash:$((pos + 2)):2}))"
    g1="$((16#${hash:$((pos + 4)):2}))"
    g2="$((16#${hash:$((pos + 6)):2}))"
    b1="$((16#${hash:$((pos + 8)):2}))"
    b2="$((16#${hash:$((pos + 10)):2}))"

    r1=$(lighten $r1 $fac)
    r2=$(lighten $r2 $fac)
    g1=$(lighten $g1 $fac)
    g2=$(lighten $g2 $fac)
    b1=$(lighten $b1 $fac)
    b2=$(lighten $b2 $fac)
    pos=$((pos + 2))
done

#Command Number
CMDNR="\!"
#User
U="\[\033[38;2;$r1;$g1;${b1}m\]\u\[\033[00m\]"

#Host
H="\[\033[38;2;$r2;$g2;${b2}m\]\h\[\033[00m\]"

#Directory
DIR="\[\033[01;34m\]"'$(_PS1 "$PWD" 50)'"\[\033[00m\]"
#Date
DATE="\e[1m\t \d\[\033[00m\]"
#Current tty
TTY="\l"
#Return code
RETURN="\$(ret=\$?; if [[ \$ret = 0 ]];then echo \"\[\033[01;32m\]✓\";else echo \"\[\033[01;31m\]\$ret\";fi)\[\033[00m\]"
#

#the actual prompt with a colorised return code
PS1="$DATE - $DIR$ROOT\n$CMDNR $U@$H $RETURN \$ " #schnell

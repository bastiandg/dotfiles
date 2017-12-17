function dx () {
	docker exec -ti $1 /bin/bash
}

function dps () {
	if [ "$1" ] ; then
		docker ps | grep -i "$1"
	else
		docker ps
	fi
}

function di () {
	if [ "$1" ] ; then
		docker images | grep -i "$1"
	else
		docker images
	fi
}

alias dl="docker logs"
alias dlf="docker logs -f"
alias dps1='docker ps -q'
alias dpsa1='docker ps -aq'


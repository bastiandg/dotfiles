vl () {
    vagrant_state_file="$(__vagrantinvestigate)" || return 1
    if [ -d "$vagrant_state_file" ] ; then
        if [ "$1" ] ; then
            vm_list=$(find $vagrant_state_file/machines -mindepth 1 -maxdepth 1 -type d -iname "*${1}*")
        else
            vm_list=$(find $vagrant_state_file/machines -mindepth 1 -maxdepth 1 -type d)
        fi
        vmlist=""
        running=""
        stopped=""
        for vm in $vm_list ; do
            if [ "$(ls "$vm"/*/id 2> /dev/null)" ] ; then
                status="\033[01;32mrunning\033[00m"
            else
                status="not_running"
            fi
            vm="$(echo "$vm" | awk -F"/" '{print $(NF)}')"
            vmlist="$vmlist\n$vm $status"
         done
    fi
    echo -e "$vmlist" | sort -k2r | column -t
}

vda () {
    vagrant global-status
    echo "kill the all vagrant machines (y/N)?"
    read vkillall
    if [ "$vkillall" == "y" -o "$vkillall" == "Y" ] ; then
        vagrant global-status | grep "running\|poweroff" | cut -d " " -f 1 | xargs vagrant destroy -f
    fi
}

alias "vu"="vagrant up"
alias "vp"="vagrant provision"
alias "vs"="vagrant ssh --command 'sudo -i'"
alias "vd"="vagrant destroy"
alias "vgs"="vagrant global-status"

make-completion-wrapper _vagrant _vagrant_up vagrant up
complete -F _vagrant_up vu

make-completion-wrapper _vagrant _vagrant_destroy vagrant destroy
complete -F _vagrant_up vd

make-completion-wrapper _vagrant _vagrant_provision vagrant provision
complete -F _vagrant_provision vp

make-completion-wrapper _vagrant _vagrant_ssh vagrant ssh
complete -F _vagrant_ssh vs

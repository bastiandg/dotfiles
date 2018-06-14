alias k="kubectl"
alias kg="kubectl get"

pl() {
    if [ -z "$1" ] ; then
        kubectl get pods --all-namespaces
    else
        kubectl get pods --all-namespaces | grep -i "$1"
    fi
}

pd() {
    if [ -z "$1" ] ; then
        echo "pattern missing" >&2
        return 1
    fi
    pod_line="$(kubectl get pods --all-namespaces | grep -i "$1" -m 1)"
    pod_id="$(echo "$pod_line" | awk '{print $2}')"
    pod_ns="$(echo "$pod_line" | awk '{print $1}')"
    kubectl describe pod "$pod_id" --namespace "$pod_ns"
}

px() {
    if [ -z "$1" ] ; then
        echo "pattern missing" >&2
        return 1
    fi
    pod_line="$(kubectl get pods --all-namespaces | grep -i "$1" -m 1)"
    pod_id="$(echo "$pod_line" | awk '{print $2}')"
    pod_ns="$(echo "$pod_line" | awk '{print $1}')"
    kubectl exec -it "$pod_id" --namespace "$pod_ns" -- /bin/sh
}

kp() {
    token="$(kubectl config view -o jsonpath="{range .users[?(@.name == '$(kubectl config current-context)')]}{@.user.auth-provider.config.access-token}")"
    if [ -n "$(which xclip)" ] ; then
        printf "%s" "$token" | xclip -selection primary
    elif [[ "$OSTYPE" == "darwin"* ]] ; then
        printf "%s" "$token" | pbcopy
    else
        echo "kubectl token: $token"
    fi
    kubectl proxy &
    PID="$!"
    trap "kill $PID" SIGINT SIGTERM
    if [[ "$OSTYPE" == "linux-gnu" ]] ; then
        printf "%s" "$token" | xclip -selection primary
        xdg-open "http://localhost:8001/ui"
    elif [[ "$OSTYPE" == "darwin"* ]] ; then
        printf "%s" "$token" | pbcopy
        open "http://localhost:8001/ui"
    fi
    wait
}

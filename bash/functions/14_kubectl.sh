alias k="kubectl"
alias kg="kubectl get"
alias kd="kubectl describe"

if command -v kubectl &> /dev/null ; then
    source <(kubectl completion bash)
fi

complete -F _complete_alias k
complete -F _complete_alias kg
complete -F _complete_alias kd


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
    if [ -n "$(command -v jq 2> /dev/null)" ] ; then
        kubectl get pod "$pod_id" --namespace "$pod_ns" -o json | jq .
    else
        kubectl describe pod "$pod_id" --namespace "$pod_ns"
    fi
    echo -e '\n\033[01;34mLogs:\033[00m'
    kubectl logs --tail=20 -n "$pod_ns" "$pod_id"
}

ph() {
    if [ -z "$1" ] ; then
        echo "pattern missing" >&2
        return 1
    fi
    container_id="${2:-}"
    tail="${3:-200}"
    pod_line="$(kubectl get pods --all-namespaces | grep -i "$1" -m 1)"
    pod_id="$(echo "$pod_line" | awk '{print $2}')"
    pod_ns="$(echo "$pod_line" | awk '{print $1}')"
    if [ -z "$container_id" ] ; then
        kubectl logs --tail="$tail" -n "$pod_ns" "$pod_id"
    else
        kubectl logs --tail="$tail" -c "$container_id" -n "$pod_ns" "$pod_id"
    fi
}

px() {
    if [ -z "$1" ] ; then
        echo "pattern missing" >&2
        return 1
    fi
    container_id="${2:-}"
    pod_line="$(kubectl get pods --all-namespaces | grep -i "$1" -m 1)"
    pod_id="$(echo "$pod_line" | awk '{print $2}')"
    pod_ns="$(echo "$pod_line" | awk '{print $1}')"
    if [ -z "$container_id" ] ; then
        kubectl exec -it "$pod_id" --namespace "$pod_ns" -- /bin/sh
    else
        kubectl exec -it "$pod_id" -c "$container_id" --namespace "$pod_ns" -- /bin/sh
    fi
}

kc() {
    if [ -z "$1" ] ; then
        echo "pattern missing" >&2
        return 1
    fi
    context="$(kubectl config view -o json | \
        jq -r ".contexts[] |
                select(
                    (.name | test(\"$1\"; \"i\")) or
                    (.context.cluster | test(\"$1\"; \"i\"))
                ) | .name")"
    context_count="$(wc -l <<< "$context")"
    if [[ "$context_count" == 0 ]] ; then
        echo "Pattern '$1' not found in kubectl contexts" >&2
        return 2
    elif [[ "$context_count" -gt 1 ]] ; then
        echo -e "Pattern '$1' ambiguous. Results: \n$context" >&2
        return 3
    else
        kubectl config use-context "$context"
    fi
}

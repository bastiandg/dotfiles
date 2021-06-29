# azure cloud stuff

# initialize kubectl with azure kubernetes cluster credentials
akc() {
        pattern="${1:-}"
        cluster_list="$(akl "$pattern")"
        if [[ -n "$cluster_list" ]] ; then
                name="$(jq -r '.[0].name' <<< "$cluster_list" )"
                resourceGroup="$(jq -r '.[0].resourceGroup' <<< "$cluster_list")"
        else
                echo "No cluster matching the pattern \"$pattern\" was found" >&2
                return 1
        fi
        az aks get-credentials --overwrite-existing --name "$name" --resource-group "$resourceGroup"
}

# List kubernetes cluster which match a pattern
akl () {
        pattern="${1:-}"
        az aks list | jq "[.[] | \
                select((.name | test(\"$pattern\")) \
                or (.fqdn| test(\"$pattern\"))) \
                | { \"name\": .name, \"resourceGroup\": .resourceGroup, \"location\": .location, \"nodeCount\": [.agentPoolProfiles[].count] | add}]"
}

# List subscriptions that match a pattern
as () {
        pattern="${1:-}"
        az account list | jq -r "[.[] | select(.name | test(\"$pattern\"; \"i\")) | {\"name\": .name, \"id\": .id}]"
}

# Set the subscription that matches a pattern as default
ass () {
        pattern="$1"
        subscription="$(as "$pattern" | jq -r ".[0].id")"
        if [[ -n "$subscription" ]] ; then
                az account set --subscription  "$subscription"
                return 0
        else
                echo "No subscription found" >&2
                return 1
        fi
}


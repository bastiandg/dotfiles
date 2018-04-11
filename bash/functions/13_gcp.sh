# google cloud stuff

# Build log list
bl() {
        DAYS="${2:-1}"
        gcloud container builds list --filter "create_time>-P${DAYS}D AND source: '$1'" --limit 10
}

bs() {
        gcloud container builds log "$1" | less
}

# initialize kubernetes with google cloud cluster credentials
kcc() {
        if [ -z "$1" ] ; then
                return 2
        fi
        cluster_line="$(gcloud container clusters list --format="value(name, zone)" | grep "$1" -m 1)"
        if [ -n "$cluster_line" ] ; then
                cluster="$(echo "$cluster_line" | awk '{print $1}')"
                zone="$(echo "$cluster_line" | awk '{print $2}')"
                project="$(gcloud config get-value project)"
                gcloud container clusters get-credentials "$cluster" \
                        --zone "$zone" \
                        --project "$project"
        else
                echo "cluster $1 not found" >&2
                return 3
        fi
}

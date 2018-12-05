# google cloud stuff

# alias gcloud='docker run --volume "$HOME/.config/docker/gcloud:/root/.config" google/cloud-sdk:alpine gcloud'

# Build log list
bl() {
        DAYS="${2:-1}"
        gcloud builds list --sort-by CREATE_TIME --filter "create_time>-P${DAYS}D AND source: '$1'" --limit 10
}

bs() {
        gcloud builds log --stream "$1"
}

# initialize kubernetes with google cloud cluster credentials
kcc() {
        pattern="${1:-cluster}"
        cluster_line="$(gcloud container clusters list --format="value(name, zone)" | grep "$pattern" -m 1)"
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

# set gcloud project
gcp() {
        if [ -z "$1" ] ; then
                echo "gcp requires a pattern" >&2
                return 2
        fi
        project_list="$(gcloud projects list --format="value(project_id, name)" | grep -i "$1" -m 1)"
        if [ -n "$project_list" ] ; then
                project_id="$(echo "$project_list" | awk '{print $1}')"
                gcloud config set project "$project_id"
        else
                echo "project_id $1 not found" >&2
                return 3
        fi
}

# list clusters
gcl() {
        cluster_list="$(gcloud container clusters list)"
        if [ -n "$1" ] ; then
                echo "$cluster_list" | grep "$1"
        else
                echo "$cluster_list"
        fi
}

# list clusters
gcd() {
        if [ -z "$1" ] ; then
                echo "gcd requires a pattern" >&2
                return 2
        fi
        cluster_line="$(gcloud container clusters list --format="value(name, zone)" | grep "$1" -m 1)"
        if [ -n "$cluster_line" ] ; then
                cluster="$(echo "$cluster_line" | awk '{print $1}')"
                zone="$(echo "$cluster_line" | awk '{print $2}')"
                project="$(gcloud config get-value project)"
                if [ -n "$(which jq)" ] ; then
                        gcloud container clusters describe "$cluster" \
                                --format="json()" \
                                --zone "$zone" \
                                --project "$project" | jq .
                else
                        gcloud container clusters describe "$cluster" \
                                --zone "$zone" \
                                --project "$project"
                fi
        else
                echo "cluster $1 not found" >&2
                return 3
        fi
}

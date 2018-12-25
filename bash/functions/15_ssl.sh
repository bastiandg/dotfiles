sslval () {
    if [[ -z "$1" ]] ; then
      echo "domain required" >&2 /dev/null
    fi
  domain="$1"
  echo "$1"
  echo | openssl s_client -showcerts -servername "$domain" -connect "$domain:443" 2> /dev/null | openssl x509 -text | grep -A2 Validity
}

if [ -n "$(which vault)" ] ; then
   complete -C /usr/bin/vault vault
fi

if [ -n "$(which terraform)" ] ; then
   complete -C /usr/bin/terraform terraform
fi

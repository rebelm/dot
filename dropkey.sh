#!/bin/bash

remotehost=${1:-dummyhost}
pubkey=${2:-${HOME}/.ssh/id_rsa_adm01alp.pub}
authkeys=\${HOME}/.ssh/authorized_keys            # Note \${HOME} is ${HOME} on the remote host
sshoptions="-o StrictHostKeyChecking=no"
cat ${pubkey} | ssh ${sshoptions} ${remotehost} \
    "cat > ~/$(basename ${pubkey}); \
     mkdir .ssh > /dev/null 2>&1; \
     chmod 700 ~/.ssh; \
     echo $(hostname); \
     grep $(cat ~/.ssh/id_rsa_adm01alp.pub | awk '{print $2}') ${authkeys} > /dev/null 2>&1 || \
        cat ~/$(basename ${pubkey}) >> ${authkeys}; chmod 400 ${authkeys}"

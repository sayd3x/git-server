#!/bin/sh

ssh-keygen -A

[[ -n "$PUBLIC_KEY" ]] && \
    [[ ! $(grep "$PUBLIC_KEY" /home/git/.ssh/authorized_keys) ]] && \
    echo "$PUBLIC_KEY" >> /home/git/.ssh/authorized_keys && \
    echo "Public key from env variable is used"

[[ -n "$PUBLIC_KEY" ]] && \
    [[ ! $(grep "$PUBLIC_KEY" /home/gitadmin/.ssh/authorized_keys) ]] && \
    echo "$PUBLIC_KEY" >> /home/gitadmin/.ssh/authorized_keys && \
    echo "Public key from env variable is used"

exec "$@"

#!/bin/bash

#  Name scipt: FastCleaner 
#  Release date: 2021-07-12 
#  Version: 1.0
#  Copyright (C) Georgii Bogdanov | GBOG@protonmail.com

PASSWORD=$(zenity --password --title "The Script will now install the requiered dependencies, enter your password to proceed")

set -eu

LANG=C snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done
flatpak remove --unused
rm /var/lib/snapd/cache/*
eopkg dc
eopkg rmo
rm -f ~/.cache/thumbnails/*
journalctl --vacuum-time=2day

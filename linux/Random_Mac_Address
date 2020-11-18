#!/bin/bash
# Fonction Random Mac with a prefix 00

random_mac_with_prefix() {
    echo -n "00:" &&
    printf '%.2x\n' "$(shuf -i 0-281474976710655 -n 1)" | sed -r 's/(..)/\1:/g' | cut -d: -f -4
}

#!/usr/bin/env bash

cpqIde -f -L &
cpqiScsi -f -L &
amsd -f -L &
smad -f -L &
/sbin/smartupdate

pid=$(pgrep sum_bin)
/usr/bin/tail --pid=$pid -f /dev/null
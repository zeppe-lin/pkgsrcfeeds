#!/bin/sh
# Backup snownews' local feeds.
CURDIR=$PWD
(cd ~/; tar -czf $CURDIR/backup.tar.gz .local/share/snownews/)

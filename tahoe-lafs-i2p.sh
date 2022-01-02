#! /usr/bin/env sh

set -euo

PLUGIN=$1
CONFIG=$2
I2P=$3

. $PLUGIN/lib/bin/activate

tahoe

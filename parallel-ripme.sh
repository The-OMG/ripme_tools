#!/usr/bin/env bash

################################################################################
############# Download reddit images, videos with ripme in parallel ############
################################################################################
#							      ___           ___           ___                            #
#							     /  /\         /__/\         /  /\                           #
#							    /  /::\       |  |::\       /  /:/_                          #
#							   /  /:/\:\      |  |:|:\     /  /:/ /\                         #
#							  /  /:/  \:\   __|__|:|\:\   /  /:/_/::\                        #
#							 /__/:/ \__\:\ /__/::::| \:\ /__/:/__\/\:\                       #
#							 \  \:\ /  /:/ \  \:\~~\__\/ \  \:\ /~~/:/                       #
#							  \  \:\  /:/   \  \:\        \  \:\  /:/                        #
#							   \  \:\/:/     \  \:\        \  \:\/:/                         #
#							    \  \::/       \  \:\        \  \::/                          #
#							     \__\/         \__\/         \__\/                           #
#                                                                              #
################################################################################
## This project: https://github.com/The-OMG/ripme_tools
## Check out everything else: https://github.com/The-OMG/orionsbelt
#
## ripme: https://github.com/RipMeApp/ripme
#
## No root required.
#
## Tested on: https://ultraseedbox.com/
#             https://cloud.google.com/compute/
#             https://www.digitalocean.com/
#
## Tested on: Debian 8,9
#             Ubuntu 16.04 - 18.04
#
## Requires ripme to be installed prior to this file being ran.
## Assumes you have a config file for ripme in the same directory.
## Assumes you have a file called "list" in the same directory.
## Assumes the file "list" is a list of reddit subreddit names.
################################################################################

function install() {
  # Install latest version of ripme.jar
  VERSION=$(curl -s "https://github.com/OpenVPN/easy-rsa/releases/latest" | grep -o 'tag/[v.0-9]*' | awk -F/ '{print $2}')
  export VERSION
  wget https://github.com/RipMeApp/ripme/releases/download/"$VERSION"/ripme.jar
}

function _ripme() {
  local RIPMEPATH="$HOME/ripreddit"
  local JTHREADS="6"
  local URLS="$HOME/files/ripreddit/list"

  local ripmeARGS=(
    "--ripsdirectory=$RIPMEPATH"
    "--threads=$JTHREADS"
    "--url=https://reddit.com/r/{}"
  )

  local parallelARGS=(
    "--joblog=$RIPMEPATH/ripme-parallel.log"
    '--delay'
    "--progress"
    '--memfree=128M'
    '--load=50%'
    '--retries=3'
    '--noswap'
  )

  parallel "${parallelARGS[@]}" java -jar ripme.jar "${ripmeARGS[@]}" :::: "$URLS"
}

_ripme

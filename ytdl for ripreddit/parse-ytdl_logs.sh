#!/usr/bin/env bash
./grep-tool.sh && sort --unique --dictionary-order \
  --output=ytdl.txt ".sanitize.txt"

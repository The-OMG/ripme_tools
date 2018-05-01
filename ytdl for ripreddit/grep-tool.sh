#!/usr/bin/env bash
grep -Eoi '(http|https)[://]\S+' log.txt >.sanitize.txt

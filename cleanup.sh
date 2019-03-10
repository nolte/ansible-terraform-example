#!/bin/bash

find . -type f -regex ".*\.\(tfstate\|tfplan\|log\|reply\|tfstate.backup\)" | while read f ; do
  rm "$f"
done

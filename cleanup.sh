#!/bin/bash

find ./terraform_modules -type f -regex ".*\.\(tfstate\|tfplan\|reply\|tfstate.backup\)" | while read f ; do
  rm "$f"
done

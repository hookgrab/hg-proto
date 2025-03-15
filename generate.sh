#!/usr/bin/env bash

# Get current directory.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Find all directories containing at least one prototfile.
# Based on: https://buf.build/docs/migration-prototool#prototool-generate.
for dir in $(find ${DIR}/proto -name '*.proto' -print0 | xargs -0 -n1 dirname | sort | uniq); do
  files=$(find "${dir}" -name '*.proto')

  # Generate all files with protoc-gen-go.
  protoc -I ${DIR} --go_out=paths=source_relative:${DIR}/gen/go ${files}
  protoc -I ${DIR} --ts_out=paths=source_relative:${DIR}/gen/ts ${files}
done


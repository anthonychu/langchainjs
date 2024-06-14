#!/usr/bin/env bash

set -euxo pipefail

export CI=true

# New monorepo directory paths
monorepo_dir="/app/monorepo"
monorepo_openai_dir="/app/monorepo/libs/langchain-cohere"

# Run the shared script to copy all necessary folders/files
bash /scripts/with_standard_tests/shared.sh cohere

# Navigate back to monorepo root and install dependencies
cd "$monorepo_dir"
yarn

# Navigate into `@langchain/cohere` to build and run tests
# We need to run inside the cohere directory so turbo repo does
# not try to build the package/its workspace dependencies.
cd "$monorepo_openai_dir"
yarn test

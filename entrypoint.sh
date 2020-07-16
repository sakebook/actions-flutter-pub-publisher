#!/bin/sh

set -e

check_credentials() {
  echo "Check credentials"
  if [ -z "$INPUT_CREDENTIAL" ]; then
    echo "Missing credential"
    exit 1
  fi
  echo "OK"
}

switch_working_directory() {
  echo "Switching to package directory"
  cd "$INPUT_PACKAGE_DIRECTORY"
}

copy_credential() {
  echo "Copy credentials"
  mkdir -p ~/.pub-cache
  cat <<EOF > ~/.pub-cache/credentials.json
$INPUT_CREDENTIAL
EOF
  echo "OK"
}

create_prefix() {
  FLUTTER_PREFIX=""
  PUB_PREFIX="pub"
  if "${INPUT_FLUTTER_PACKAGE}"; then
    FLUTTER_PREFIX="flutter"
    PUB_PREFIX=""
  fi
}

test() {
  echo "Run test"
  $FLUTTER_PREFIX pub get
  $FLUTTER_PREFIX $PUB_PREFIX run test
}

run_test_if_needed() {
  if "${INPUT_SKIP_TEST}"; then
    echo 'Skip test'
  else
    test
  fi
}

dry_run() {
  echo "Executing package validation"
  $FLUTTER_PREFIX pub publish --dry-run
}

publish_package() {
  dry_run
  if [ "${INPUT_DRY_RUN}" = false ]; then
    echo "Publish package to Pub"
    $FLUTTER_PREFIX pub publish -f
  fi
}

check_credentials
copy_credential
switch_working_directory
create_prefix
run_test_if_needed
publish_package

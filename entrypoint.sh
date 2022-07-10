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

copy_credential() {
  echo "Copy credentials"
  mkdir -p ~/Library/Application\ Support/dart
  cat <<EOF > ~/Library/Application\ Support/dart/pub-credentials.json
$INPUT_CREDENTIAL
EOF
  mkdir -p ~/.pub-cache
  ln -s ~/Library/Application\ Support/dart/pub-credentials.json credentials.json
  echo "OK"
}

switch_working_directory() {
  echo "Switching to package directory"
  cd "$INPUT_PACKAGE_DIRECTORY"
}

test_dart() {
  echo "Run test for dart"
  dart pub get
  dart run test
}

test_flutter() {
  echo "Run test for flutter"
  flutter pub get
  flutter test
}

run_test_if_needed() {
  if "${INPUT_SKIP_TEST}"; then
    echo 'Skip test'
  else
    if "${INPUT_FLUTTER_PACKAGE}"; then
      test_flutter
    else
      test_dart
    fi
  fi
}

create_prefix() {
  EXECUTABLE_PREFIX="dart"
  if "${INPUT_FLUTTER_PACKAGE}"; then
    EXECUTABLE_PREFIX="flutter"
  fi
}

dry_run() {
  echo "Executing package validation"
  $EXECUTABLE_PREFIX pub publish --dry-run
}

publish_package() {
  dry_run
  if [ "${INPUT_DRY_RUN}" = false ]; then
    echo "Publish package to Pub"
    $EXECUTABLE_PREFIX pub publish -f
  fi
}

check_credentials
copy_credential
switch_working_directory
run_test_if_needed
create_prefix
publish_package

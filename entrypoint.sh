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

test_dart() {
  echo "Run test for dart"
  pub get
  pub test
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

dry_run_package_dart() {
  echo "Executing dart package validation"
  pub publish --dry-run
}

publish_package_dart() {
  dry_run_package_dart
  echo "Publish dart package to Pub"
  pub publish -f
}

dry_run_package_flutter() {
  echo "Executing flutter package validation"
  flutter pub pub publish --dry-run
}

publish_package_flutter() {
  dry_run_package_flutter
  echo "Publish flutter package to Pub"
  flutter pub pub publish -f
}

publish_package() {
  if "${INPUT_FLUTTER_PACKAGE}"; then
    if "${INPUT_DRY_RUN}"; then
      dry_run_package_flutter
    else
      publish_package_flutter
    fi
  else
    if "${INPUT_DRY_RUN}"; then
      dry_run_package_dart
    else
      publish_package_dart
    fi
  fi
}

check_credentials
copy_credential
switch_working_directory
run_test_if_needed
publish_package

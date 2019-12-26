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

run_test_if_needed() {
  if "${INPUT_SKIP_TEST}"; then
    echo 'Skip test'
  else
    echo "Run test"
    if "${INPUT_FLUTTER_PACKAGE}"; then
      flutter pub get
      flutter test
    else
      pub get
      pub test
    fi
  fi
}

publish_package_dart() {
  echo "Publish dart package to Pub"
  pub publish --dry-run
  pub publish -f
}

publish_package_flutter() {
  echo "Publish flutter package to Pub"
  flutter pub pub publish --dry-run
  flutter pub pub publish -f
}

publish_package() {
  if "${INPUT_FLUTTER_PACKAGE}"; then
    publish_package_flutter
  else
    publish_package_dart
  fi
}

check_credentials
copy_credential
switch_working_directory
run_test_if_needed
publish_package

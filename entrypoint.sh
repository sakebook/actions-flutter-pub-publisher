#!/bin/sh -l

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
    flutter pub get
    flutter test
  fi
}

publish_package() {
  echo "Publish to Pub"
  flutter pub pub publish --dry-run
  flutter pub pub publish -f
}

check_credentials
copy_credential
run_test_if_needed
publish_package

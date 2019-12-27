# actions-flutter-pub-publisher

This action publishing the Flutter plugin.

## Inputs

### `credential`

**Required** Google Account credential.

You can find the credentials.json within `.pub-cache` in the User's home directory.
You can use `open ~/.pub-cache`.

### `flutter_package`

**Optional** Publish packages type. Default: `true`

### `skip_test`

**Optional** Skip test. Default: `false`

### `package_directory`

**Optional** Package directory. Default: `"."`

## Example usage

```yaml
name: Publish plugin

on:
  release:
    types: [published]

jobs:
  publish:

    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v1
      - name: Publish
        uses: sakebook/actions-flutter-pub-publisher@v1.2.1
        with:
          credential: ${{ secrets.CREDENTIAL_JSON }}
          flutter_package: false
          skip_test: true
```

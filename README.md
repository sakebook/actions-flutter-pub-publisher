# actions-flutter-pub-publisher

This action publishing the Flutter plugin.

## Inputs

### `credential`

**Required** Google Account credential.

You can find the `pub-credentials.json` within `Library/Application Support/dart` in the Windows User's home directory or `~/.config/dart/pub-credentials.json` on Ubuntu (Linux).
If you can't find it, you can generate it by running `pub login`.

### `flutter_package`

**Optional** Publish packages type. Default: `true`

### `skip_test`

**Optional** Skip test. Default: `false`

### `package_directory`

**Optional** Package directory. Default: `"."`

### `dry_run`

**Optional** Dry run, no publish. Default: `false`

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
        uses: sakebook/actions-flutter-pub-publisher@v1.4.0
        with:
          credential: ${{ secrets.CREDENTIAL_JSON }}
          flutter_package: false
          skip_test: true
          dry_run: true
```

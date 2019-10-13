# actions-flutter-pub-publisher

This action publishing the Flutter plugin.

## Inputs

### `credential`

**Required** Google Account credential.

### `skip_test`

**Optional** Skip test. Default: `false`

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
      - uses: actions/checkout@v1
      - name: Publish
        uses: actions/actions-flutter-pub-publisher@v1
        with:
          credential: ${{ secrets.CREDENTIAL_JSON }}
          skip_test: true
```

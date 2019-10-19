# actions-flutter-pub-publisher

This action publishing the Flutter plugin.

## Inputs

### `credential`

**Required** Google Account credential.

### `channel`

**Optional** Flutter channel. Default: `stable`

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
      - name: Checkout
        uses: actions/checkout@v1
      - name: Publish
        uses: sakebook/actions-flutter-pub-publisher@v1.1.0
        with:
          credential: ${{ secrets.CREDENTIAL_JSON }}
          channel: 'stable'
          skip_test: true
```

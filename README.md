# PairSync

PairSync is how you keep your PairSpaces up-to-date with the latest version of your code. You don't have to share credentials or keys with us, so you remain in control of when you push your data to your PairSpace.

To create a PairSpace account to use this GitHub Action, visit https://pairspaces.com. To learn more about creating a PairSpace role to sync your repository with PairSpace, see https://docs.pairspaces.com/sync. To learn more about how PairSpaces protects your code and data, see https://pairspaces.com/secure.

## Usage

PairSync uses the role assigned to your PairSpaces account and creates a temporary token that syncs your repository securely with your PairSpace. The temporary token is created using the offical GitHub Action from AWS, `configure-aws-credentials` (see https://github.com/aws-actions/configure-aws-credentials). The role and its region are available from your PairSpaces account (see https://pairspaces.com/repos).

PairSpaces grants your role least privilege and uses a condition that ensures only your GitHub organization can sync with your PairSpace and only your PairSpace can read your code.

*Note* In your `actions/checkout` step, include `fetch-depth: 0` to ensure all references are synced to your PairSpace.

```yaml
name: sync pairspace

on:
  push:
    tags-ignore:
      - '*'
    branches:
      - '*'
  pull_request:
    types:
      - opened
      - edited
      - reopened
      - synchronize  

permissions:
  contents: read

jobs:
  pairspace:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
        with:
          fetch-depth: 0

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          # This is available from https://pairspaces.com/repos
          role-to-assume: ${{ secrets.PAIRSPACE_ROLE }}
          # This is available from https://pairspaces.com/repos
          aws-region: ${{ secrets.PAIRSPACE_REGION }}

      - name: Sync PairSpace
        uses: pairspaces/sync-pairspace-action@v1
        with:
          repository: ${{ github.repository }}
          user: ${{ github.actor_id }}
```


## Inputs and Outputs

### Inputs

PairSync requires the following inputs.

| Input | Description |
|-------|-------------|
| `repository` | The owner and repository name, e.g., `pairspaces/pairsync`; this is available from any GitHub Action's context as `github.repository` |
| `user` | The ID of the GitHub user, e.g., `1234567`; this is available from any GitHub Action's context as `github.actor_id` |

PairSync provides the following optional inputs.

| Input | Description |
|-------|-------------|
| `region` | The region to which to push code to (see "Regions" below); defaults to `us-east-1` |

#### Regions

PairSpaces defaults to using America (Virginia) for customers using the Free or Organization plans. For Enterprise customers, you can use any region that you set up for your account.

### Outputs

PairSync does not output any arguments.

## Secrets

PairSync does not use any secrets.

## Environment Variables

PairSync does not use any explicit environment variables; it does use variables produced by `configure-aws-credentials`.

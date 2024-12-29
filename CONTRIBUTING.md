# Contributing

The base branch is **`main`**.

## Workflow

> **Note**
> Please feature/fix/update... into individual PRs (not one changing everything)

- Create a [github fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo).
- On your fork, create a branch make the changes, commit and push.
- Create a pull-request.

## Checklist

If applicable:

- [x] **tests** should be included part of your PR. The current package is using
  `testthat` testing framework.

## Git message format

This repo adheres to the [conventional commit](https://www.conventionalcommits.org/en/v1.0.0/) convention.

### Used prefixes

- **chore**: Changes that affect the build system or external dependencies
- **ci**: Changes to our CI configuration files and scripts
- **docs**: Documentation only changes
- **feat**: A new feature
- **fix**: A bug fix
- **perf**: A code change that improves performance
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **lint**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: Adding missing tests or correcting existing tests
- **translation**: Adding missing translations or correcting existing ones
- **revert**: When reverting a commit
- **style**: A change that affects the scss, less, css styles
- **release**: All related to changeset (pre exit...)

For example:

```
docs: Added documentation for wbw_slope() function
```

## Structure

```
├── inst
│   ├── exdata
│   │   └── ...
│   └── wbw_helpers.py
├── R
│   └── ...
├── tests
│   ├── tests
│   │   └── ...
│   └── testthat.R
└ DESCRIPTION
```
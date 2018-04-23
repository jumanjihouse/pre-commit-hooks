# Pre-commit git hooks

Git hooks to integrate with [pre-commit](http://pre-commit.com).


## Table of contents

- [Configure pre-commit](#configure-pre-commit)
- [Two ways to invoke pre-commit](#two-ways-to-invoke-pre-commit)
- [Available hooks](#available-hooks)
  * [`fasterer`](#fasterer)
  * [`forbid-binary`](#forbid-binary)
  * [`git-check`](#git-check)
  * [`git-dirty`](#git-dirty)
  * [`shellcheck`](#shellcheck)
  * [`shfmt`](#shfmt)
- [Contributing](#contributing)
- [Testing](#testing)
- [License](#license)


## Configure pre-commit

Add to `.pre-commit-config.yaml` in your git repo:

    - repo: https://github.com/jumanjihouse/pre-commit-hooks
      sha: 1.6.0
      hooks:
        - id: fasterer
        - id: forbid-binary
        - id: forbid-space-in-indent
        - id: git-check  # Configure in .gitattributes
        - id: git-dirty  # Configure in .gitignore
        - id: shellcheck
        - id: shfmt


## Two ways to invoke pre-commit

If you want to invoke the checks as a git pre-commit hook, run:

    pre-commit install

If you want to run the checks on-demand (outside of git hooks), run:

    pre-commit run --all-files --verbose

The [test harness](TESTING.md) of this git repo uses the second approach
to run the checks on-demand.


## Available hooks

### `fasterer`

#### What it does

Suggest ways to improve speed of Ruby code.

#### More info

[`fasterer`](https://github.com/DamirSvrtan/fasterer)
suggests speed improvements that you can check in detail at the
[fast-ruby repo](https://github.com/JuanitoFatas/fast-ruby).

**Note:** You should not follow the suggestions blindly.


### `forbid-binary`

#### What it does

Prevent binary files from being committed.

#### More info

Fail if a file appears to be a [binary filetype](https://pre-commit.com/#filtering-files-with-types).
Override with an `exclude` regular expression,
such as the example [**here**](.pre-commit-config.yaml).


### `forbid-space-in-indent`

#### What it does

Prevent files with spaces within indentation from being committed.

#### More info

Fail if a file contains spaces within indentation.
Override with an `exclude` regular expression,
such as the example [**here**](.pre-commit-config.yaml).


### `git-check`

#### What it does

Check both committed and uncommitted files for git conflict markers and
whitespace errors according to `core.whitespace` and `conflict-marker-size`
configuration in a git repo.

#### More info

This hook uses `git` itself to perform the checks.<br/>
The git-scm book describes
[**here**](https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#_code_core_whitespace_code)
that there are six `core.whitespace` checks.

Enabled by default:

* `blank-at-eol`, which looks for spaces at the end of a line
* `blank-at-eof`, which looks for blank lines at the end of a file
* `space-before-tab`, which looks for spaces before tabs at the beginning of a line

Disabled by default:

* `indent-with-non-tab`, which looks for lines that begin with spaces instead of tabs
  (and is controlled by the `tabwidth` option)
* `tab-in-indent`, which looks for tabs in the indentation portion of a line
* `cr-at-eol`, which looks for carriage returns at the end of a line

#### Custom configuration (overrides)

The git documentation describes
[**here**](https://git-scm.com/docs/git-config#git-config-corewhitespace)
how to configure the various checks.

The recommended place to persist the configuration is the `.gitattributes` file,
described [**here**](https://git-scm.com/docs/gitattributes#_checking_whitespace_errors).
It provides fine control over configuration per file path for both
`core.whitespace` and `conflict-marker-size`.

Real-world examples of `.gitattributes` file to configure overrides per path:

* https://github.com/jumanjihouse/devenv/blob/master/.gitattributes


### `git-dirty`

#### What it does

During the pre-commit stage, do nothing.<br/>
Otherwise, detect whether the git tree contains modified, staged, or untracked files.

#### More info

This is useful to run near the end of a CI process to
see if a build step has modified the git tree in unexpected ways.

#### Custom configuration (overrides)

The recommended place to persist the configuration is the `.gitignore` file,
described [**here**](https://git-scm.com/docs/gitignore).


### `shellcheck`

#### What it does

Run shellcheck against scripts.

#### More info

This hook uses the `identify` library of pre-commit to identify shell scripts.
If the file is a shell script, then run shellcheck against the file.

By default, this hooks passes `-e SC1091` to shellcheck.
Override locally with the `args` parameter in `.pre-commit-config.yaml`.

:warning: The `shellcheck` hook requires
[shellcheck](https://github.com/koalaman/shellcheck).


### `shfmt`

#### What it does

Run `shfmt` against scripts with args.

#### More info

This hook uses the `identify` library of pre-commit to identify shell scripts.
If the file is a shell script, then run shfmt against the file.

By default, this hooks passes `-l -i 2 -ci` to shfmt to conform to the
[Google Shell Style Guide](https://google.github.io/styleguide/shell.xml).
Override locally with the `args` parameter in `.pre-commit-config.yaml`.

:warning: The `shfmt` hook requires
[shfmt](https://github.com/mvdan/sh/releases).


## Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md).


## Testing

Please see [TESTING.md](TESTING.md).


## License

The code in this repo is licensed under the [MIT License](LICENSE).

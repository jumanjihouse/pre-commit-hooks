# Pre-commit git hooks

Git hooks to integrate with [pre-commit](http://pre-commit.com).


## Table of contents

- [Requirements](#requirements)
- [Configure pre-commit](#configure-pre-commit)
- [Available hooks](#available-hooks)
  * [`git-check`](#git-check)
  * [`git-dirty`](#git-dirty)
- [Contributing](#contributing)
- [License](#license)


## Requirements

pre-commit-hooks requires the following to run:

* [pre-commit](http://pre-commit.com)
* [git](https://github.com/git/git)
* A posix shell


## Configure pre-commit

Add to `.pre-commit-config.yaml` in your git repo:

    - repo: https://github.com/jumanjihouse/pre-commit-hooks
      sha: 1.0.0
      hooks:
        - id: git-check  # Configure in .gitattributes
        - id: git-dirty  # Configure in .gitignore


## Available hooks

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


## Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md).


## License

The code in this repo is licensed under the [MIT License](LICENSE).

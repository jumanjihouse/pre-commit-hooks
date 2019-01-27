# Pre-commit git hooks

Git hooks to integrate with [pre-commit](http://pre-commit.com).


## Table of contents

- [Configure pre-commit](#configure-pre-commit)
- [Two ways to invoke pre-commit](#two-ways-to-invoke-pre-commit)
- [Available hooks](#available-hooks)
  * [`check-mailmap`](#check-mailmap)
  * [`fasterer`](#fasterer)
  * [`forbid-binary`](#forbid-binary)
  * [`git-check`](#git-check)
  * [`git-dirty`](#git-dirty)
  * [`markdownlint`](#markdownlint)
  * [`reek`](#reek)
  * [`require-ascii`](#require-ascii)
  * [`rubocop`](#rubocop)
  * [`script-must-have-extension`](#script-must-have-extension)
  * [`script-must-not-have-extension`](#script-must-not-have-extension)
  * [`shellcheck`](#shellcheck)
  * [`shfmt`](#shfmt)
- [Contributing](#contributing)
- [Testing](#testing)
- [License](#license)


## Configure pre-commit

Add to `.pre-commit-config.yaml` in your git repo:

    - repo: https://github.com/jumanjihouse/pre-commit-hooks
      sha: 1.10.3
      hooks:
        - id: check-mailmap
        - id: fasterer
        - id: forbid-binary
        - id: forbid-space-in-indent
        - id: git-check  # Configure in .gitattributes
        - id: git-dirty  # Configure in .gitignore
        - id: markdownlint # Configure in .mdlrc
        - id: reek
        - id: require-ascii
        - id: rubocop
        - id: script-must-have-extension
        - id: script-must-not-have-extension
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

### `check-mailmap`

#### What it does

Detect botched name/email translations in git history.

`git shortlog -sn` is useful to summarize contributors.

However, it gets muddy when an email address is associated with multiple names.<br/>
Reasons include:

* the author's full name was messed up
* not always written the same way
* the author has multiple email addresses

#### More info

Sample output for good condition:

    $ pre-commit run check-mailmap --all-files --verbose
    [check-mailmap] Detect if an email address needs to be added to mailmap.......................Passed


Sample output for bad condition:

    $ pre-commit run check-mailmap --all-files --verbose
    [check-mailmap] Detect if an email address needs to be added to mailmap.......................Failed
    hookid: check-mailmap

    The following email addresses are associated with more than one name:

            billy.bob@example.com
            jdoe@example.com

    The associations include:

          2 Billy Bob <billy.bob@example.com>
          2 Bubba <billy.bob@example.com>

         13 John Doe <jdoe@example.com>
          4 jdoe <jdoe@example.com>


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


### `markdownlint`

**What it does**

Check markdown files and flag style issues.

**More info**

[markdownlint](https://github.com/markdownlint/markdownlint)
is a ruby tool that examines markdown files against various
[style rules](https://github.com/markdownlint/markdownlint/blob/master/docs/RULES.md).

**Custom configuration (overrides)**

Provide `.mdlrc` in the top-level of your project git repo.


### `reek`

#### What it does

Detect code smells in Ruby code.

#### More info

[Reek](https://github.com/troessner/reek)
is a tool that examines Ruby classes, modules and methods and reports any
[Code Smells](docs/Code-Smells.md) it finds.

For an excellent introduction to
[Code Smells](docs/Code-Smells.md) and Reek check out
[this blog post](https://blog.codeship.com/how-to-find-ruby-code-smells-with-reek/)
or [that one](https://troessner.svbtle.com/the-latest-and-greatest-additions-to-reek).
There is also [this talk](https://www.youtube.com/watch?v=pazYe7WRWRU) from
[RubyConfBY](http://rubyconference.by/)
(there is also a [slide deck](http://talks.chastell.net/rubyconf-by-lt-2016/)
if you prefer that).

**Note:** You should not follow the suggestions blindly.

This hook uses the `identify` library of pre-commit to identify ruby scripts.
If the file is a ruby script, then run reek against the file.

#### Custom configuration (overrides)

The recommended place to persist the configuration is the `.reek` file,
described [**here**](https://github.com/troessner/reek#configuration-options).

You can also create [in-line comments](https://github.com/troessner/reek#source-code-comments)
in the source code for individual overrides.


### `require-ascii`

#### What it does

Requires that text files have ascii-encoding.
This is useful to detect files that have unicode characters.

#### Custom configuration (overrides)

Use the [built-in overrides](https://pre-commit.com/#pre-commit-configyaml---hooks)
from the pre-commit framework.


### `rubocop`

#### What it does

RuboCop is a Ruby static code analyzer. Out of the box it
enforces many of the guidelines outlined in the community
[Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide).

#### More info

This hook uses the `identify` library of pre-commit to identify ruby scripts.
If the file is a ruby script, then run rubocop against the file.
Additionally, run rubocop-rspec against rspec files.

#### Custom configuration (overrides)

Most aspects of rubocop behavior can be tweaked via various
[configuration options](https://github.com/bbatsov/rubocop/blob/master/config/default.yml).

Rubocop-rspec is documented
[here](https://github.com/rubocop-rspec/rubocop-rspec).


### `script-must-have-extension`

The [Google shell style guide](https://google.github.io/styleguide/shell.xml#File_Extensions)
states:

> Libraries must have a `.sh` extension and should not be executable.

This hook checks for conformance.

#### Default

Filter on files that are both `shell` **and** `non-executable`.

    types: [shell, non-executable]


#### Override

Suppose your local style guide is the opposite of the default.<br/>
In other words, you require **executable** scripts to end with `.sh`.<br/>
Put this in your `.pre-commit-config.yaml`:

    - repo: https://github.com/jumanjihouse/pre-commit-hooks
      rev: <version>
      hooks:
        - id: script-must-have-extension
          name: Local policy is to use .sh extension for shell scripts
          types: [shell, executable]

Note the use of "name" to override the hook's default name and
provide context for the override.


### `script-must-not-have-extension`

The [Google shell style guide](https://google.github.io/styleguide/shell.xml#File_Extensions)
states:

> Executables should have no extension (strongly preferred)

This hook checks for conformance.

#### Default

Filter on files that are both `shell` **and** `executable`.

    types: [shell, executable]


#### Override

You can use this hook to forbid filename extensions on other types of files.<br/>
Put something like this in your `.pre-commit-config.yaml`:

    - repo: https://github.com/jumanjihouse/pre-commit-hooks
      rev: <version>
      hooks:
        - id: script-must-not-have-extension
          name: Local policy is to exclude extension from all shell files
          types: [shell]

        - id: script-must-not-have-extension
          name: Executable Ruby scripts must not have a file extension
          types: [ruby, executable]

Note the use of "name" to override the hook's default name and
provide context for the override.


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

# Test harness

## Dependencies

* [`bash`](https://www.gnu.org/software/bash/bash.html)
* [`git`](https://github.com/git/git)
* [`pip`](http://www.pip-installer.org) command


## How-to

Run:

    ci/test

Output resembles:

    [forbid-binary] Forbid binaries..............................................................Passed
    [git-check] Check for conflict markers and core.whitespace errors............................Passed
    [git-dirty] Check if the git tree is dirty...................................................Passed
    [shellcheck] Test shell scripts with shellcheck..............................................Passed
    [forbid-binary] forbid-binary (local)........................................................Passed
    [git-dirty] git-dirty (local)................................................................Passed
    [shellcheck] shellcheck (local)..............................................................Passed
    [yamllint] yamllint..........................................................................Passed
    [check-added-large-files] Check for added large files........................................Passed
    [check-case-conflict] Check for case conflicts...............................................Passed
    [check-executables-have-shebangs] Check that executables have shebangs.......................Passed
    [check-json] Check JSON..................................................(no files to check)Skipped
    [detect-private-key] Detect Private Key......................................................Passed
    [forbid-crlf] CRLF end-lines checker.........................................................Passed
    [forbid-tabs] No-tabs checker................................................................Passed
    ci/test OK

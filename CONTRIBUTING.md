# Contributing to RailsDevs

Welcome to [RailsDevs](https://railsdevs.com)! I'm Joe, the founder, and I'd love for you to contribute to the project.

Lots of developers' first open source contribution was to RailsDevs. Let me help you make it yours, too.

## What to work on?

[Unassigned issues labeled "help wanted"](https://github.com/joemasilotti/railsdevs.com/issues?q=is%3Aissue+is%3Aopen+no%3Aassignee+label%3A%22help+wanted%22) are ready to be worked on. Comment on one to "claim" it – I'll assign it to you to let others know.

To keep things moving, you'll have 2 weeks to submit a pull request. If you don't finish in time, no worries! Comment and let me know and we can work something out.

## Quick Setup Guide - more details in README.md

1. Install Ruby packages via `bundle install`
2. Install non-Ruby packages via `brew bundle install --no-upgrade`
3. `brew services start postgresql`  If you already have an instance of postgres running, you may not need this step. If you have an older version of postgres that is not running, get it started. In the case of Mac users, you can open it via launchpad and start via the UI.
4. `brew services start redis`
5. `bin/setup`
6. `bin/dev`
7. Run `rails test` to run unit/integration tests.

## PR checklist

Before submitting a pull request make sure to:


1. [Fork](https://github.com/joemasilotti/railsdevs.com/fork) and clone the repository
2. Create a new branch: `git checkout -b my-branch-name`
3. Add tests covering the code you modified
4. Lint and test the project with `bin/check`
5. Add significant changes and product updates to the [changelog](CHANGELOG.md)
6. Push to your fork and [submit a pull request](https://github.com/joemasilotti/railsdevs.com/compare)

## Need help?

First PR ever? Need help deciding which design pattern to use? Can't fix a flaky test? Let me know – I'm more than happy to help.

Feel free to comment on the issue/PR or [send me an email](mailto:joe@masilotti.com).
